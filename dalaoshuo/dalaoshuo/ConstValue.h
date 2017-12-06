//
//  ConstValue.h
//  dalaoshuo
//
//  Created by 邵义珑 on 2017/7/25.
//  Copyright © 2017年 邵义珑. All rights reserved.
//



/**
 *  单例的宏定义
 */

// @interface
#define SINGLETON_INTERFACE(className) \
+ (className *)sharedInstance;


// @implementation
#define SINGLETON_IMPLEMENTATION(className) \
static className *_instance = nil; \
+ (id)allocWithZone:(NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
+ (className *)sharedInstance \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
}

//view
#import "BaseViewController.h"
#import "BaseNavViewController.h"
#import "BaseTableViewController.h"

//Util
#import "CommonUtil.h"
#import "SingleData.h"
#import "MainRequest.h"

//ThirdFramework
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
#import "Reachability.h"
#import "CocoaLumberjack.h"
static const int ddLogLevel = DDLogLevelVerbose;//定义日志级别

#import "Masonry.h"

#import "MJRefresh.h"
#import "MJExtension.h"

//Category
#import "UIColor+Hex.h"
#import "UIView+Extension.h"

#ifndef ConstValue_h
#define ConstValue_h

#define kURLEnvironment 1 //1是测试环境，0是正式环境
#define kURLDevelop         @"http://mcexpert.cn"  //测试环境
#define kURLDistribution    @"http://www.wipace.cn/server"     //正式环境
#define kURLRequest      kURLEnvironment?kURLDevelop:kURLDistribution




//******************   常用宏   *************************

//是否是pad
#define IS_IPAD ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)

// 是否是iOS 7或者更高版本
#define IS_IOS7_OR_HIGHER ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0 ? YES : NO)

#define IS_IOS8_OR_HIGHER ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0 ? YES : NO)

#define IS_IOS9_OR_HIGHER ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0 ? YES : NO)

#define IS_IOS10_OR_HIGHER ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0 ? YES : NO)

// 手机型号
#define isIPhone4S ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define isIPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define isIPhone6   ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

/*
 屏幕尺寸
 */

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

/**
 *设置图片
 */
#define ImageNamed(_pointer) [UIImage imageNamed:_pointer]


/**
 *获得appDelegate对象
 */
#define APPDELEGATE (AppDelegate *)[UIApplication sharedApplication].delegate

/**
 *IOS系统版本
 */
#define IOS_VERSION_CODE [[[UIDevice currentDevice] systemVersion] intValue]

/**
 *IOS APP版本
 */
#define APP_VERSION_CODE [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]

#define SDK_VERSION_CODE @"2.1.1"

#define APP_BUNDLEID [[NSBundle mainBundle] bundleIdentifier]

/**
 *设置颜色
 */
#define RGBCOLOR(r,g,b,p) [UIColor colorWithRed:r/255.00f green:g/255.00f blue:b/255.00f alpha:p/1.0]

#define GetColorWithString(colorStr) [UIColor colorWithHexString:colorStr]
#define GetColorWithString2(colorStr,opacity) [UIColor colorWithHexString:(colorStr) alpha:(opacity)]

/**
 *USER_DEFAULT
 */
#define USER_DEFAULT [NSUserDefaults standardUserDefaults]

/**
 *相关代码要在主线程执行
 */
#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)


/**
 *自定义log
 */
#ifdef DEBUG
#   define MYLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define MYLog(...)
#endif


//******************   颜色   *************************

static NSString * const ConstColor_navBg = @"#ACCB2A";
static NSString * const ConstColor_mainBg = @"#EAEEF2";
static NSString * const ConstColor_cellBg = @"#EAEEF2";
static NSString * const ConstColor_borderColor = @"#bdc0c2";
//static NSString * const ConstColor_BtnBg = @"#0080FF";
static NSString * const ConstColor_BtnBg = @"#ACCB2A";
//static NSString * const ConstColor_BtnBgHighlight = @"#6699ff";
static NSString * const ConstColor_BtnBgHighlight = @"#C4D60C";

static NSString * const ConstColor_diyBtnBg = @"#2196F3";

//运动数据柱状图
static NSString * const ConstColor_sportBar = @"#1e85fe";
static NSString * const ConstColor_sportBarSelect = @"#81bcff";


//cookie
static NSString * const kUserDefaultsCookie = @"kUserDefaultsCookie";
//语言参数
static NSString * const LANGUAGE_EN = @"en";
static NSString * const LANGUAGE_ZH = @"zh";

//******************   字体   *************************
#define font_supersuperLargeFont [UIFont systemFontOfSize:19]
#define font_superLargeFont [UIFont systemFontOfSize:17]
#define font_largeFont [UIFont systemFontOfSize:16]
#define font_mediumFont [UIFont systemFontOfSize:15]
#define font_smallFont [UIFont systemFontOfSize:13]
#define font_minimalFont [UIFont systemFontOfSize:12]
#define font_superMinimalFont [UIFont systemFontOfSize:10]



#endif /* ConstValue_h */
