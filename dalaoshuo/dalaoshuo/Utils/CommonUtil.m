//
//  CommonUtil.m
//  xcode6Test
//
//  Created by wiselink on 15/3/25.
//  Copyright (c) 2015年 wiselink. All rights reserved.
//

#import "CommonUtil.h"
#import <objc/runtime.h>
#import <objc/objc.h>
#import <sys/utsname.h>
/**
 * Save path
 * 存储路径
 */
static NSString *wp_tempPath = @"/WPVideoPlayer_temp"; // temporary file(临时文件)
static NSString *wp_savePath = @"/WPVideoPlayer_save"; // complete file(完成文件)

@implementation CommonUtil

#pragma mark -- 模型转换

+(NSString *)getDocumentsDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}

+(NSString *)getClassNameWithObj:(id)obj;
{
    @synchronized(self)
    {
        NSString *className=[NSString stringWithUTF8String:object_getClassName(obj)];
        return className;
    }
}


+(NSMutableDictionary *)dicFromWithObj:(id)classInstance
{
    @synchronized(self)
    {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:1];
        Class cls = [classInstance class];
        u_int count;
        objc_property_t *properties = class_copyPropertyList(cls, &count);
        
        for (int i = 0; i < count; i++)
        {
            objc_property_t property = properties[i];
            NSString * propertyName = [NSString stringWithUTF8String:property_getName(property)];
            id value = [classInstance valueForKey:propertyName];
            if (value == nil)
            {
                value = @"";
            }
            [dic setObject:value forKey:propertyName];
        }
        return dic;
    }
}



+(id)objFromWithDic:(NSDictionary *)dic class :(Class )cls
{
    @synchronized(self)
    {
        id model_Instance = [[cls alloc] init];
        // 获取类属性
        unsigned int nCount = 0;
        
        objc_property_t *propertyList = class_copyPropertyList(cls, &nCount);
        
        for (int i = 0; i < nCount; i++) {
            @try {
                // 获取属性
                objc_property_t property = propertyList[i];
                // 获取属性名称
                NSString *str = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
                
                if (str!=nil&&[dic objectForKey:str] != nil&&(NSNull *)[dic objectForKey:str] != [NSNull null] )
                {
                    [model_Instance setValue:[dic objectForKey:str] forKey:str];
                }
            }
            @catch (NSException *exception) {
                NSLog(@"%@", exception);
            }
        }
        return model_Instance;
    }
}

+ (NSMutableArray *)keysFromWithClass:(Class)cls
{
    @synchronized(self)
    {
        u_int count;
        objc_property_t *properties = class_copyPropertyList(cls, &count);
        NSMutableArray *keyArr = [NSMutableArray arrayWithCapacity:1];
        for (int i = 0; i < count; i++)
        {
            objc_property_t property = properties[i];
            NSString * propertyName = [NSString stringWithUTF8String:property_getName(property)];
            [keyArr addObject:propertyName];
        }
        return keyArr;
    }
}

//获取系统语言
+ (NSString *)getPreferredLanguage
{

    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    
    if (![self isValueableString:currentLanguage])
    {
        currentLanguage = LANGUAGE_EN;
    }
    
   //    NSLog(@"当前语言:%@", preferredLang);
    
    return currentLanguage;
    
}

#pragma mark - 动态计算label高度 传入要计算的内容  字体  和 限定的宽度

+ (CGFloat)heightWithContent:(NSString *)content font:(UIFont *)font labelWidth:(CGFloat )labelWidth
{
    NSDictionary *attributes = @{NSFontAttributeName: font};
    CGRect rect = [content boundingRectWithSize:CGSizeMake(labelWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    return rect.size.height;
}

//获取屏幕宽度
+ (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}
#pragma mark --大陆手机号正则判断

+ (BOOL)isValueablePhoneNum:(NSString *)phoneNum
{
    //    电信号段:133/153/180/181/189/177
    //    联通号段:130/131/132/155/156/185/186/145/176
    //    移动号段:134/135/136/137/138/139/150/151/152/157/158/159/182/183/184/187/188/147/178
    //    虚拟运营商:170
    
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[06-8])\\d{8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    return [regextestmobile evaluateWithObject:phoneNum];
}


#pragma mark --非空判断

+ (BOOL)isValueableString:(NSString *)content
{
    if (content != nil && (NSNull *)content != [NSNull null] && ![@"" isEqualToString:content] && ![content isEqualToString:[[NSNull null] description]])
    {
        return YES;
    }
    return NO;
}
+ (BOOL)isValueableObject:(NSObject *)obj
{
    if (obj != nil && (NSNull *)obj != [NSNull null])
    {
        return YES;
    }
    return NO;
}


+ (UIImage *)createImageWithColor:(UIColor *) color
{
    CGRect rect=CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *senderImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return senderImage;
}
//判断字符串或者字符是不是数字
+ (BOOL)isPureInt:(NSString *)string{
    NSScanner *scan = [NSScanner scannerWithString:string];
    int value;
    return [scan scanInt:&value] && [scan isAtEnd];
}

+ (NSMutableAttributedString *)setAttributeStringWithString:(NSString *)string
{
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:string];
    //先将整个字符串设置为默认字体defaultFont
    [attributeString addAttribute:NSFontAttributeName value:font_mediumFont range:NSMakeRange(0, string.length)];
    [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0, string.length)];
    
    for (int i = 0 ; i<string.length; i++)
    {
        NSRange range = NSMakeRange(i, 1);
        NSString *subString = [string substringWithRange:range];
        if ([self isPureInt:subString] || [subString isEqualToString:@"."])
        {
            //如果是数字或者小数点就将这个字符设置为attributeFont
            [attributeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:25] range:range];
            [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:range];
            
        }
    }
    return attributeString;
}

//+ (NSMutableAttributedString *)setAttributeStringWithString:(NSString *)string
//{
//    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:string];
//    //先将整个字符串设置为默认字体defaultFont
//    [attributeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:25] range:NSMakeRange(0, string.length)];
//    [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:NSMakeRange(0, string.length)];
//
//    for (int i = 0 ; i<string.length; i++)
//    {
//        NSRange range = NSMakeRange(i, 1);
//        NSString *subString = [string substringWithRange:range];
//        const char *cString = [subString UTF8String];
//        if (strlen(cString) == 3)
//        {
////            MYLog(@"%@这个字符是文字",subString);
//            //遇到文字的字符就将这个字符设置为attributeFont
//            [attributeString addAttribute:NSFontAttributeName value:font_mediumFont range:range];
//            [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:range];
//
//        }
//    }
//    return attributeString;
//}

+ (NSMutableAttributedString *)setAttributeStringWithString2:(NSString *)string
{
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:string];
    //先将整个字符串设置为默认字体defaultFont
    [attributeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:30] range:NSMakeRange(0, string.length)];
    [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, string.length)];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:20];
    [attributeString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, string.length)];
    
    for (int i = 0 ; i<string.length; i++)
    {
        NSRange range = NSMakeRange(i, 1);
        NSString *subString = [string substringWithRange:range];
        const char *cString = [subString UTF8String];
        if (strlen(cString) == 3)
        {
            //            MYLog(@"%@这个字符是文字",subString);
            //遇到文字的字符就将这个字符设置为attributeFont
            [attributeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:20] range:range];
            [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:range];
            
        }
    }
    return attributeString;
}

#pragma mark --[UIApplication sharedApplication] openURL

+ (void)openBlueTooth
{
// iOS 10 之前用 @"prefs:root=Bluetooth"  经测试，下面的iOS9和iOS10均可用
    NSURL *url = [NSURL URLWithString:@"App-Prefs:root=Bluetooth"];
    
    if ([[UIApplication sharedApplication] canOpenURL:url])
    {
        [[UIApplication sharedApplication] openURL:url];
    }
}

+ (void)callPhoneWidthPhoneNum:(NSString *)tel
{
    //拨打电话号码
    NSString *number = [[NSString alloc] initWithFormat:@"telprompt://%@", tel];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:number]];
}

+ (void)openUrlWithString:(NSString *)urlStr
{
    //Safari 打开网页
//    NSString *urlText =[NSString stringWithFormat:@"http://%@",urlStr];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
}

+ (void)joinTencentGroup
{
    //加入QQ群
    NSString *urlStr = [NSString stringWithFormat:@"mqqapi://card/show_pslcard?src_type=internal&version=1&uin=%@&key=%@&card_type=group&source=external", @"215180541",@"d932a3527b5eaa9655394f66f8a17f1b43a2a7730cff7b826d63651a75e04f31"];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    if([[UIApplication sharedApplication] canOpenURL:url])
    {
        [[UIApplication sharedApplication] openURL:url];
    }
}

#pragma mark -- APP 系统相关


//获取app版本号
+ (NSString *)getAppVersion
{
    //kCFBundleVersionKey
    //CFBundleShortVersionString   实际版本号
    //CFBundleVersion  编译版本号
    static NSString* version;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        
    });
    return version;

}


#pragma mark date

//保证只创建一次
+ (NSDateFormatter*)getDateFormat
{
    static NSDateFormatter* format;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        format = [[NSDateFormatter alloc] init];
        [format setTimeZone:[NSTimeZone localTimeZone]];
    });
    return format;
}
+ (NSString *)getCurrentTimeWithLongLongNum
{
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970] * 1000;
    return [[NSNumber numberWithLongLong:time] stringValue];
}
+ (NSString *)getCurrentTimeWithSecondNum
{
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    return [[NSNumber numberWithLongLong:time] stringValue];
}

+ (NSInteger)getMonthOfDaysWithYear:(NSInteger) year month:(NSInteger) month
{
    MYLog(@"%ld    %ld",(long)year,(long)month);
    int monthday[] = {31,28,31,30,31,30,31,31,30,31,30,31};
    if (month != 1)
    {
        //不是2月
        return monthday[month];
    }
    //2月
    if(year % 4 != 0)
        return 28;
    else if(year % 100 == 0 && year % 400 != 0)
        return 28;
    else
        return 29;
}

+ (NSString *)getStringDateWithNSDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [self getDateFormat];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr =  [dateFormatter stringFromDate:date];
    return dateStr;
}

+ (NSDate *)getNSDateWithStr:(NSString*)dateStr
{
    NSDateFormatter *dateFormatter = [self getDateFormat];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:dateStr];
    return date;
}

+ (NSDate *)getNSDateWithStr:(NSString *)dateStr forMateStr:(NSString *)forMateStr
{
    
    NSDateFormatter *dateFormatter = [self getDateFormat];
    [dateFormatter setDateFormat:forMateStr];
    NSDate *date = [dateFormatter dateFromString:dateStr];
    
    return date;
}

+ (NSString *)getDateFromaManyDaysAgo:(int)days fromDate:(NSString *)fromDate
{
    NSDateFormatter *dateFormatter = [self getDateFormat];;
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *myDate = [dateFormatter dateFromString:fromDate];
    NSDate *newDate = [myDate dateByAddingTimeInterval:-60 * 60 * 24 * days];
    
    return [dateFormatter stringFromDate:newDate];
}

+ (NSTimeInterval)getLongTimeWithStr:(NSString *)dateStr
{
    NSDate *date = [self getNSDateWithStr:dateStr];
    
    return [date timeIntervalSince1970];
}

+ (NSArray *)getWeekBeginAndEndWith:(NSDate *)nowDate
{
    if (nowDate == nil)
    {
        nowDate = [NSDate date];
    }
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitWeekday | NSCalendarUnitDay fromDate:nowDate];
    // 获取今天是周几
    NSInteger weekDay = [comp weekday];
    // 获取几天是几号
    NSInteger day = [comp day];
//    NSLog(@"%d----%d",weekDay,day);
    
    // 计算当前日期和本周的星期一和星期天相差天数
    long firstDiff,lastDiff;
    //    weekDay = 1;
    if (weekDay == 1)
    {
        firstDiff = -6;
        lastDiff = 0;
    }
    else
    {
        firstDiff = [calendar firstWeekday] - weekDay + 1;
        lastDiff = 8 - weekDay;
    }
//    NSLog(@"firstDiff: %ld   lastDiff: %ld",firstDiff,lastDiff);
    
    // 在当前日期(去掉时分秒)基础上加上差的天数
    NSDateComponents *firstDayComp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay  fromDate:nowDate];
    [firstDayComp setDay:day + firstDiff];
    NSDate *firstDayOfWeek = [calendar dateFromComponents:firstDayComp];
    
    NSDateComponents *lastDayComp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay   fromDate:nowDate];
    [lastDayComp setDay:day + lastDiff];
    NSDate *lastDayOfWeek = [calendar dateFromComponents:lastDayComp];
    
    NSDateFormatter *formatter = [self getDateFormat];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *firstDay = [formatter stringFromDate:firstDayOfWeek];
    NSString *lastDay = [formatter stringFromDate:lastDayOfWeek];
//    NSLog(@"%@=======%@",firstDay,lastDay);
    
    NSArray *tmpArr = @[firstDay,lastDay];
    return tmpArr;
}

#pragma  mark -- 设置cookie

+ (void)getWipaceCookie
{
    //存储cookie
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:cookies];
    [USER_DEFAULT setObject:data forKey:kUserDefaultsCookie];
    [USER_DEFAULT synchronize];
}

+ (void)setWipaceCookie
{
    //设置cookie
    NSData *cookiesdata = [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsCookie];
    if([cookiesdata length])
    {
        NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData:cookiesdata];
        NSHTTPCookie *cookie;
        for (cookie in cookies)
        {
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
        }
    }
}
//更新cookie
+ (void)updateWipaceCookieSuccess:(void (^)())success
//                           failed:(void (^)(NSError *error))failure
                        noNetWork:(void (^)(void))noNetwork
{
    
}

#pragma mark -- 更新本地个人信息
+ (void)updateLocalUserInfo
{
    
}

#pragma mark -- 清空本地个人信息
+ (void)clearLocalUserInfo
{

}

#pragma maark --UI

+ (UIButton *)creatButtonWithTitle:(NSString *)title
                         titleFont:(UIFont *)titleFont
                        titleColor:(UIColor *)titleColor
                    nomalBackColor:(UIColor *)nomalBackColor
                highlightBackColor:(UIColor *)highlightBackColor
                       borderColor:(UIColor *)borderColor
                            action:(SEL)action
                            target:(nullable id)target
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = titleFont;
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn setBackgroundImage:[self createImageWithColor:nomalBackColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:[self createImageWithColor:highlightBackColor] forState:UIControlStateHighlighted];
    
    if (action)
    {
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    
    btn.layer.cornerRadius = 4.0;
    btn.layer.masksToBounds = YES;
    if (borderColor)
    {
        btn.layer.borderColor = borderColor.CGColor;
        btn.layer.borderWidth = 1;
    }
    
    
    return btn;
}


+ (UILabel *)creatLabelWithText:(NSString *)text
                           font:(UIFont *)font
                          textColor:(UIColor *)textColor
                      textAlignment:(NSTextAlignment)textAlignment
                      backColor:(UIColor *)backColor
{
    UILabel *lb = [[UILabel alloc] init];
    lb.text = text;
    lb.font = font;
    lb.numberOfLines = 0;
    lb.textColor = textColor;
    lb.textAlignment = textAlignment;
    lb.backgroundColor = backColor;
    return lb;
}

+ (void)diyButton:(UIButton *)btn
            Title:(NSString *)title
        titleFont:(UIFont *)titleFont
       titleColor:(UIColor *)titleColor
   nomalBackColor:(UIColor *)nomalBackColor
highlightBackColor:(UIColor *)highlightBackColor
      borderColor:(UIColor *)borderColor
           action:(SEL)action
           target:(nullable id)target
{
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = titleFont;
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn setBackgroundImage:[self createImageWithColor:nomalBackColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:[self createImageWithColor:highlightBackColor] forState:UIControlStateHighlighted];
    
    if (action)
    {
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    
    btn.layer.cornerRadius = 4.0;
    btn.layer.masksToBounds = YES;
    if (borderColor)
    {
        btn.layer.borderColor = borderColor.CGColor;
        btn.layer.borderWidth = 1;
    }
    
}

+ (void)diyRingButton:(UIButton *)btn
            Title:(NSString *)title
        titleFont:(UIFont *)titleFont
       titleColor:(UIColor *)titleColor
           action:(SEL)action
           target:(nullable id)target
{
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = titleFont;
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    [btn setBackgroundImage:[self createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [btn setBackgroundImage:[self createImageWithColor:titleColor] forState:UIControlStateHighlighted];
    
    if (action)
    {
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    
    btn.layer.cornerRadius = btn.frame.size.height/2;
    btn.layer.masksToBounds = YES;

    btn.layer.borderColor = titleColor.CGColor;
    btn.layer.borderWidth = 1;
    

}

+ (void)diyImgButton:(UIButton *)btn
        nomalBackImg:(NSString *)nomalBackImg
    highlightBackImg:(NSString *)highlightBackImg
              action:(SEL)action
              target:(nullable id)target
{

    [btn setBackgroundImage:ImageNamed(nomalBackImg) forState:UIControlStateNormal];
    [btn setBackgroundImage:ImageNamed(highlightBackImg) forState:UIControlStateHighlighted];
    
    if (action)
    {
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
}



+ (void)diyLabel:(UILabel *)lb
            Text:(NSString *)text
            font:(UIFont *)font
       textColor:(UIColor *)textColor
   textAlignment:(NSTextAlignment)textAlignment
       backColor:(UIColor *)backColor
{
    lb.text = text;
    lb.font = font;
    lb.numberOfLines = 0;
    lb.textColor = textColor;
    lb.textAlignment = textAlignment;
    if (backColor)
    {
        lb.backgroundColor = backColor;
    }
}

#pragma mark -- system Alert
+ (void)showAlertInfo:(NSString *)alertInfo
{
    if (alertInfo)
    {
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:nil message:alertInfo delegate:self cancelButtonTitle:NSLocalizedString(@"取消", nil) otherButtonTitles: nil];
        [al show];
    }
}


#pragma mark -- 沙盒目录

+ (NSString *)homePath
{
    return NSHomeDirectory();
}

+ (NSString *)appPath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSApplicationDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+ (NSString *)docPath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+ (NSString *)libPrefPath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingFormat:@"/Preference"];
}

+ (NSString *)libCachePath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+ (NSString *)tmpPath
{
    return [NSHomeDirectory() stringByAppendingFormat:@"/tmp"];
}

+ (BOOL)isFileExist:(NSString *)path
{
    if ( NO == [[NSFileManager defaultManager] fileExistsAtPath:path] )
    {
        return [[NSFileManager defaultManager] createDirectoryAtPath:path
                                         withIntermediateDirectories:YES
                                                          attributes:nil
                                                               error:NULL];
    }
    
    return YES;
}

+ (NSString *)getVideoCachePath:(NSString *)urlStr isTmp:(BOOL)isTmp
{
    NSString *tmp = nil;
    if (isTmp)
    {
        tmp = wp_tempPath;
    }
    else
    {
        tmp = wp_savePath;
    }
    
    NSString *cachePath = [[CommonUtil libCachePath] stringByAppendingString:tmp];
    
    return cachePath;
}

+ (BOOL)isLocalVideoExist:(NSString *)urlStr
{
    NSString *videoName = [[urlStr componentsSeparatedByString:@"/"] lastObject];
    
    NSString *videoPath = [self getVideoCachePath:urlStr isTmp:NO];
    
    videoPath = [videoPath stringByAppendingPathComponent:videoName];
    
    return [[NSFileManager defaultManager] fileExistsAtPath:videoPath];
}

+ (NSString *)getVideoFile:(NSString *)urlStr isTmp:(BOOL)isTmp
{
    NSString *videoName = [[urlStr componentsSeparatedByString:@"/"] lastObject];
    
    NSString *tmp = nil;
    if (isTmp)
    {
        tmp = wp_tempPath;
    }
    else
    {
        tmp = wp_savePath;
    }
    
    NSString *cachePath = [[CommonUtil libCachePath] stringByAppendingString:tmp];
    
    cachePath = [cachePath stringByAppendingPathComponent:videoName];
    
    return cachePath;
}

#pragma mark -- 网络监听
+ (BOOL)isEnableWifi
{
    BOOL isWifi;
    
    Reachability *r = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    switch ([r currentReachabilityStatus]) {
            
        case NotReachable:// 没有网络连接
        
            isWifi = NO;
            
            break;
            
        case ReachableViaWWAN:// 使用3G网络
            
            isWifi = NO;
            
            break;
            
        case ReachableViaWiFi:// 使用WiFi网络
            
            isWifi = YES;
            
            break;
            
    }
    
    return isWifi;
}


#pragma mark - 手机型号

+ (NSString *)getiPhoneVersion
{
    NSString *iphoneModel = [self iphoneType];
    
    NSString *systemVersion = [[UIDevice currentDevice] systemVersion];
    
    NSString *iPhoneVersion = [NSString stringWithFormat:@"%@,%@",iphoneModel,systemVersion];
    
    return iPhoneVersion;
}

+ (NSString *)iphoneType
{
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
    
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    
    if ([platform isEqualToString:@"iPhone3,1"] || [platform isEqualToString:@"iPhone3,2"] || [platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    
    if ([platform isEqualToString:@"iPhone5,1"] || [platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    
    if ([platform isEqualToString:@"iPhone5,3"] || [platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    
    if ([platform isEqualToString:@"iPhone6,1"] || [platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone 7";
    
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";
    
    
    if ([platform isEqualToString:@"iPod1,1"]) return @"iPod Touch 1G";
    
    if ([platform isEqualToString:@"iPod2,1"]) return @"iPod Touch 2G";
    
    if ([platform isEqualToString:@"iPod3,1"]) return @"iPod Touch 3G";
    
    if ([platform isEqualToString:@"iPod4,1"]) return @"iPod Touch 4G";
    
    if ([platform isEqualToString:@"iPod5,1"]) return @"iPod Touch 5G";
    
    
    
    if ([platform isEqualToString:@"iPad1,1"]) return @"iPad 1G";
    
    if ([platform isEqualToString:@"iPad2,1"] || [platform isEqualToString:@"iPad2,2"] || [platform isEqualToString:@"iPad2,3"] || [platform isEqualToString:@"iPad2,4"]) return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,5"] || [platform isEqualToString:@"iPad2,6"] || [platform isEqualToString:@"iPad2,7"]) return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad3,1"] || [platform isEqualToString:@"iPad3,2"] || [platform isEqualToString:@"iPad3,3"]) return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,4"] || [platform isEqualToString:@"iPad3,5"] || [platform isEqualToString:@"iPad3,6"]) return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad4,1"] || [platform isEqualToString:@"iPad4,2"] || [platform isEqualToString:@"iPad4,3"]) return @"iPad Air";
    
    if ([platform isEqualToString:@"iPad4,4"] || [platform isEqualToString:@"iPad4,5"] || [platform isEqualToString:@"iPad4,6"]) return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"iPad4,7"] || [platform isEqualToString:@"iPad4,8"] || [platform isEqualToString:@"iPad4,9"]) return @"iPad Mini 3G";
    
    if ([platform isEqualToString:@"iPad5,1"] || [platform isEqualToString:@"iPad5,2"]) return @"iPad Mini 4G";
    
    if ([platform isEqualToString:@"iPad5,3"] || [platform isEqualToString:@"iPad5,4"]) return @"iPad Air 2";
    
    if ([platform isEqualToString:@"iPad6,3"] || [platform isEqualToString:@"iPad6,4"] || [platform isEqualToString:@"iPad6,7"] || [platform isEqualToString:@"iPad6,8"]) return @"iPad Pro";
    
    
    
    if ([platform isEqualToString:@"i386"] || [platform isEqualToString:@"x86_64"]) return @"iPhone Simulator";
    
    return platform;
    
}


//暂停layer上面的动画
+ (void)pauseLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;
}

//继续layer上面的动画
+ (void)resumeLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer timeOffset];
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    layer.beginTime = timeSincePause;
}











@end
