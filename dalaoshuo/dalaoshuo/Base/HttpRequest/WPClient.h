//
//  WPClient.h
//  WipaceApp
//
//  Created by 邵义珑 on 16/5/10.
//  Copyright © 2016年 邵义珑. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface WPClient : NSObject



NS_ASSUME_NONNULL_BEGIN

//+ (AFHTTPSessionManager *)getManager;
+ (BOOL)connectedToNetwork;

#pragma mark-发送get请求
+ (void)sendGetRequest:(NSString *)URLString
            parameters:(NSDictionary *) parameters
               success:(void (^)(NSURLSessionDataTask *operation, id responseObject))_success
               failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))_failure
             noNetWork:(void (^)(void))noNetwork;
#pragma mark-发送post请求
+ (void)sendPostRequest:(NSString *)URLString
             parameters:(id) parameters
                success:(void (^)(NSURLSessionDataTask *operation, id responseObject))_success
                failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))_failure
              noNetWork:(void (^)(void))noNetwork;

//#pragma mark-发送post请求带data
//+ (void)sendPostRequestWithdata:(NSString *)URLString
//                    parameters:(NSDictionary *) parameters
//     constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
//                       success:(void (^)(NSURLSessionDataTask *operation, id responseObject))_success
//                       failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))_failure
//                     noNetWork:(void (^)(void))noNetwork;

+ (void)downloadFileWithUrl:(NSString *)urlStr
                   progress:(void (^)(NSProgress * _Nonnull))downloadProgress
          completionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler;

#pragma mark-iOS原生请求
+ (void)sendNativePostRequest:(NSString *)urlString
                   parameters:(id) parameters
            completionHandler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler
                    noNetWork:(void (^)(void))noNetwork;
NS_ASSUME_NONNULL_END
@end
