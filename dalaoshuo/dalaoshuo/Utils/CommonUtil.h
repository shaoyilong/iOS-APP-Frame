//
//  CommonUtil.h
//  xcode6Test
//
//  Created by wiselink on 15/3/25.
//  Copyright (c) 2015年 wiselink. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonUtil : NSObject
NS_ASSUME_NONNULL_BEGIN
/**
 * 获得Documents目录
 */
+(NSString *)getDocumentsDirectory;


#pragma mark -- 模型转换

/**
 *获得类名称
 */
+(NSString *)getClassNameWithObj:(id)obj;

/**
 *对象转成字典
 */
+(NSMutableDictionary *)dicFromWithObj:(id)classInstance;

/**
 *字典转成对象
 */
+(id)objFromWithDic:(NSDictionary *)dic class :(Class )cls;


/**
 *取出类中所有的属性
 */
+(NSMutableArray *)keysFromWithClass:(Class)cls;

#pragma mark -- 字符串相关

//获取字符串高度

+ (CGFloat)heightWithContent:(NSString *)content font:(UIFont *)font labelWidth:(CGFloat )labelWidth;

//获取屏幕宽度

+ (CGFloat)cellContentViewWith;

//
+ (BOOL)isValueablePhoneNum:(NSString *)phoneNum;

//非空判断
+ (BOOL)isValueableString:(NSString *)content;

+ (BOOL)isValueableObject:(NSObject *)obj;

//color -->  image
+ (UIImage *)createImageWithColor:(UIColor *) color;

//获取系统语言
+ (NSString *)getPreferredLanguage;

//设置string不同字体大小
+ (NSMutableAttributedString *)setAttributeStringWithString:(NSString *)string;
+ (NSMutableAttributedString *)setAttributeStringWithString2:(NSString *)string;

#pragma mark -- [UIApplication sharedApplication] openURL
+ (void)openBlueTooth;
+ (void)callPhoneWidthPhoneNum:(NSString *)tel;
+ (void)openUrlWithString:(NSString *)urlStr;
+ (void)joinTencentGroup;

#pragma mark -- APP 系统相关
//获取app版本号
+ (NSString *)getAppVersion;

#pragma mark date
+ (NSDateFormatter *)getDateFormat;

+ (NSString *)getCurrentTimeWithLongLongNum;

+ (NSString *)getCurrentTimeWithSecondNum;

+ (NSInteger)getMonthOfDaysWithYear:(NSInteger) year month:(NSInteger) month;

+ (NSString *)getStringDateWithNSDate:(NSDate *)date;

+ (NSDate *)getNSDateWithStr:(NSString*)dateStr;

+ (NSDate *)getNSDateWithStr:(NSString *)dateStr forMateStr:(NSString *)forMateStr;

+ (NSString *)getDateFromaManyDaysAgo:(int)days fromDate:(NSString *)fromDate;

+ (NSTimeInterval)getLongTimeWithStr:(NSString *)dateStr;

+ (NSArray *)getWeekBeginAndEndWith:(NSDate  * _Nullable )newDate;

#pragma mark --cookie
+ (void)getWipaceCookie;
+ (void)setWipaceCookie;
+ (void)updateWipaceCookieSuccess:(void  (^ _Nullable )())success
//                           failed:(void (^)(NSError *error))failure
                        noNetWork:(void (^ _Nullable)(void))noNetwork;


#pragma mark -- 本地个人信息
+ (void)updateLocalUserInfo;
+ (void)clearLocalUserInfo;
#pragma mark -- UI
+ (UIButton *)creatButtonWithTitle:(NSString *)title
                         titleFont:(UIFont *)titleFont
                        titleColor:(UIColor *_Nullable)titleColor
                    nomalBackColor:(UIColor *)nomalBackColor
                highlightBackColor:(UIColor *)highlightBackColor
                       borderColor:(UIColor * _Nullable)borderColor
                            action:(SEL _Nullable)action
                            target:(nullable id)target;

+ (UILabel *)creatLabelWithText:(NSString *)text
                           font:(UIFont *)font
                      textColor:(UIColor *)textColor
                  textAlignment:(NSTextAlignment)textAlignment
                      backColor:(UIColor *_Nullable)backColor;

+ (void)diyButton:(UIButton *)button
            Title:(NSString *)title
        titleFont:(UIFont *)titleFont
       titleColor:(UIColor *)titleColor
   nomalBackColor:(UIColor *)nomalBackColor
highlightBackColor:(UIColor *)highlightBackColor
      borderColor:(UIColor *_Nullable)borderColor
           action:(SEL _Nullable)action
           target:(nullable id)target;

+ (void)diyImgButton:(UIButton *)btn
        nomalBackImg:(NSString *)nomalBackImg
    highlightBackImg:(NSString *)highlightBackImg
              action:(SEL _Nullable)action
              target:(nullable id)target;

+ (void)diyRingButton:(UIButton *)btn
                Title:(NSString *)title
            titleFont:(UIFont *)titleFont
           titleColor:(UIColor *)titleColor
               action:(SEL _Nullable)action
               target:(nullable id)target;


+ (void)diyLabel:(UILabel *)label
            Text:(NSString *)text
            font:(UIFont *)font
       textColor:(UIColor *)textColor
   textAlignment:(NSTextAlignment)textAlignment
       backColor:(UIColor *_Nullable)backColor;


+ (void)showAlertInfo:(NSString *)alertInfo;


#pragma mark -- 沙盒
+ (NSString *)homePath;     // 程序主目录，可见子目录(3个):Documents、Library、tmp
+ (NSString *)appPath;        // 程序目录，不能存任何东西
+ (NSString *)docPath;        // 文档目录，需要ITUNES同步备份的数据存这里，可存放用户数据
+ (NSString *)libPrefPath;    // 配置目录，配置文件存这里
+ (NSString *)libCachePath;    // 缓存目录，系统永远不会删除这里的文件，ITUNES会删除
+ (NSString *)tmpPath;        // 临时缓存目录，APP退出后，系统可能会删除这里的内容
+ (BOOL)isFileExist:(NSString *)path; //判断目录是否存在，不存在则创建
+ (NSString *)getVideoCachePath:(NSString *)urlStr isTmp:(BOOL)isTmp;
+ (BOOL)isLocalVideoExist:(NSString *)urlStr;
+ (NSString *)getVideoFile:(NSString *)urlStr isTmp:(BOOL)isTmp;


#pragma mark -- 网络监听
+ (BOOL)isEnableWifi;

#pragma mark - 手机型号
+ (NSString *)getiPhoneVersion;

//暂停layer上面的动画
+ (void)pauseLayer:(CALayer*)layer;

//继续layer上面的动画
+ (void)resumeLayer:(CALayer*)layer;

NS_ASSUME_NONNULL_END
@end
