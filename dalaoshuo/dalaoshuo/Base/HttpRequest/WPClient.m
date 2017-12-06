//
//  WPClient.m
//  WipaceApp
//
//  Created by 邵义珑 on 16/5/10.
//  Copyright © 2016年 邵义珑. All rights reserved.
//

#import "WPClient.h"
#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonHMAC.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <netdb.h>
#import <arpa/inet.h>

@implementation WPClient
+ (void)sendGetRequest:(NSString *)URLString
            parameters:(NSDictionary *) parameters
              success:(void (^)(NSURLSessionDataTask *operation, id responseObject))_success
              failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))_failure
            noNetWork:(void (^)(void))noNetwork
{
    MYLog(@"URLString = %@",URLString);
    MYLog(@"parameters = %@",parameters);
    
    if (![self connectedToNetwork])
    {
        if (noNetwork)
        {
//            [CommonUtil showAlertInfo:NSLocalizedString(PROMPT_NET_ERROR, nil)];
            noNetwork();
            
        }
        return;
    }
    
    AFHTTPSessionManager *manager = [self getManager];
    //超时
    manager.requestSerializer.timeoutInterval = 20.0f;

    
    [manager GET:URLString parameters:parameters progress:nil success:_success failure:_failure];
}

+ (void)sendPostRequest:(NSString *)URLString
             parameters:(id) parameters
               success:(void (^)(NSURLSessionDataTask *operation, id responseObject))_success
               failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))_failure
             noNetWork:(void (^)(void))noNetwork
{
    
    MYLog(@"URLString = %@",URLString);
    MYLog(@"params = %@",parameters);

    if (![self connectedToNetwork])
    {
        if (noNetwork)
        {
//            [CommonUtil showAlertInfo:NSLocalizedString(PROMPT_NET_ERROR, nil)];
            noNetwork();
        }
        return;
    }
    AFHTTPSessionManager *manager = [self getManager];
    manager.requestSerializer.timeoutInterval = 20.0f;
//    [manager POST:URLString parameters:parameters success:_success  failure:_failure];
    [manager POST:URLString parameters:parameters progress:nil success:_success failure:_failure];
    
}

+ (void)sendNativePostRequest:(NSString *)urlString
                   parameters:(id) parameters
            completionHandler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler
                    noNetWork:(void (^)(void))noNetwork
{
    if (![self connectedToNetwork]) {
        if (noNetwork) {
//            [CommonUtil showAlertInfo:NSLocalizedString(PROMPT_NET_ERROR, nil)];
            noNetwork();
        }
    }
    NSURLSession *mySession = [NSURLSession sharedSession];
    
    NSURL *fullURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kURLRequest, urlString]];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:fullURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20.0];
    request.HTTPMethod = @"POST";
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [self addLanguageParamToHeaderNative:request];
    
    request.HTTPBody = [parameters dataUsingEncoding:NSUTF8StringEncoding];
    MYLog(@"post请求~~~~~~~~~~~~~~~~~~>%@?%@", fullURL, parameters);
    
    NSURLSessionDataTask *task = [mySession dataTaskWithRequest:request completionHandler:completionHandler];
    [task resume];
    
}

+ (void)sendNativeGetRequest:(NSString *)urlString
                   parameters:(id) parameters
            completionHandler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler
                    noNetWork:(void (^)(void))noNetwork
{
    if (![self connectedToNetwork]) {
        if (noNetwork) {
            //            [CommonUtil showAlertInfo:NSLocalizedString(PROMPT_NET_ERROR, nil)];
            noNetwork();
        }
    }
    NSURLSession *mySession = [NSURLSession sharedSession];
    
    NSURL *fullURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kURLRequest, urlString]];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:fullURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20.0];
    request.HTTPMethod = @"POST";
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [self addLanguageParamToHeaderNative:request];

    request.HTTPBody = [parameters dataUsingEncoding:NSUTF8StringEncoding];
    MYLog(@"post请求~~~~~~~~~~~~~~~~~~>%@?%@", fullURL, parameters);
    
    NSURLSessionDataTask *task = [mySession dataTaskWithRequest:request completionHandler:completionHandler];
    [task resume];
    
}

#pragma mark-发送post请求带data
+ (void)sendPostRequestWithdata:(NSString *)URLString
                    parameters:(NSDictionary *) parameters
     constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                       success:(void (^)(NSURLSessionDataTask *operation, id responseObject))_success
                       failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))_failure
                     noNetWork:(void (^)(void))noNetwork
{
    
    NSString *postString =  [self parseParams:parameters];
    
    MYLog(@"post请求~~~~~~~~~~~~~~~~~~>%@?%@",URLString,postString);
    
    if (![self connectedToNetwork]) {
        if (noNetwork) {
            noNetwork();
            
        }
        return;
    }
    AFHTTPSessionManager *manager = [self getManager];
    manager.requestSerializer.timeoutInterval = 60.0f;

    [manager POST:URLString parameters:parameters constructingBodyWithBlock:block progress:nil success:_success failure:_failure];
    
}

+ (void)downloadFileWithUrl:(NSString *)urlStr
                   progress:(void (^)(NSProgress * _Nonnull))downloadProgress
          completionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    NSString  *fullPath = [CommonUtil getVideoCachePath:urlStr isTmp:YES];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionDownloadTask *task =
    [manager downloadTaskWithRequest:request
                            progress:downloadProgress destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
                                NSString *cachesPath = [CommonUtil getVideoCachePath:urlStr isTmp:YES];
                                NSString *path = [cachesPath stringByAppendingPathComponent:response.suggestedFilename];
                                return [NSURL fileURLWithPath:path];
                            }
                   completionHandler:completionHandler];
    [task resume];
}

+ (AFHTTPSessionManager *)getManager
{
    
//    AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
//    [securityPolicy setAllowInvalidCertificates:YES];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
//        manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    //json请求
//    [manager setSecurityPolicy:securityPolicy];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    
    //http请求
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    /*
     // 返回XML类型
     manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
     // 图片类型
     manager.responseSerializer = [AFImageResponseSerializer serializer];
     // json类型
     manager.responseSerializer = [AFJSONResponseSerializer serializer];
     // plist类型
     manager.responseSerializer = [AFPropertyListResponseSerializer serializer];
     */
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];

    [self addLanguageParamToHeader:manager];
    
    /*
     这里因为在接口里需要传sign拼接各个参数，所以这些设备号等固定参数都需要在后面传
     NSString *username = @"";
     if (UseridGet) {
     username = UseridGet;
     }
     NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
     // 当前应用名称
     __unused NSString *appCurName = [infoDictionary objectForKey:@"CFBundleDisplayName"];
     // 当前应用软件版本  比如：1.0.1
     __unused NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
     // 当前应用版本号码   int类型 比如：12
     NSString *appCurVersionNum = [infoDictionary objectForKey:@"CFBundleVersion"];
     UIDevice *device = [UIDevice currentDevice];
     [manager.requestSerializer setValue:username forHTTPHeaderField:@"username" ];
     [manager.requestSerializer setValue:@"4" forHTTPHeaderField:@"appType"];
     [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"deviceType"];
     [manager.requestSerializer setValue:appCurVersionNum forHTTPHeaderField:@"versionCode"];
     [manager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"os"];
     [manager.requestSerializer setValue:device.systemVersion forHTTPHeaderField:@"osVersion" ];
     [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"protocolVersion"];
     [manager.requestSerializer setValue:@"0" forHTTPHeaderField:@"isForgetCache"];
     */
    return manager;
    
}

+ (AFHTTPSessionManager *)getHttpManager
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    return manager;
    
}

+ (BOOL)connectedToNetwork
{
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        printf("Error. Could not recover network reachability flags\n");
        return NO;
    }
    
    BOOL isReachable = ((flags & kSCNetworkFlagsReachable) != 0);
    BOOL needsConnection = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
    return (isReachable && !needsConnection) ? YES : NO;
}

//把NSDictionary解析成post格式的NSString字符串
+ (NSString *)parseParams:(NSDictionary *)params{
    NSString *keyValueFormat;
    NSMutableString *result = [[NSMutableString alloc] init];
    //实例化一个key枚举器用来存放dictionary的key
    NSEnumerator *keyEnum = [params keyEnumerator];
    id key;
    while (key = [keyEnum nextObject]) {
        keyValueFormat = [NSString stringWithFormat:@"%@=%@&",key,[params valueForKey:key]];
        [result appendString:keyValueFormat];
    }
    //    NSLog(@"post方法参数解析结果1：%@",result);
    NSString * result1 = [NSString stringWithFormat:@"%@",[result substringToIndex:result.length-1]];//去掉最后一个&
    //    NSLog(@"post方法参数解析结果2：%@",result);
    return result1;
}

//在header中添加语言参数  AFNetworking
+ (void)addLanguageParamToHeader:(AFHTTPSessionManager *)manager
{
    NSString *language = [CommonUtil getPreferredLanguage];
    if ([language hasPrefix:LANGUAGE_ZH])
    {
        [manager.requestSerializer setValue:LANGUAGE_ZH forHTTPHeaderField:@"LANG"];
    }
    else
    {
        [manager.requestSerializer setValue:LANGUAGE_EN forHTTPHeaderField:@"LANG"];
    }
}

+ (void)addLanguageParamToHeaderNative:(NSMutableURLRequest *)request
{
    NSString *language = [CommonUtil getPreferredLanguage];
    if ([language hasPrefix:LANGUAGE_ZH])
    {
        [request setValue:LANGUAGE_ZH forHTTPHeaderField:@"LANG"];
    }
    else
    {
        [request setValue:LANGUAGE_EN forHTTPHeaderField:@"LANG"];
    }
}




@end
