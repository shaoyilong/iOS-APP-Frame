//
//  MainRequest.m
//  dalaoshuo
//
//  Created by 邵义珑 on 2017/7/28.
//  Copyright © 2017年 邵义珑. All rights reserved.
//

#import "MainRequest.h"

@implementation MainRequest

SINGLETON_IMPLEMENTATION(MainRequest)

//首页接口
- (void)getMainViewInfoSuccess:(void (^)(MainViewModel *))success
                       failure:(void (^)(NSError *))failure
                     noNetWork:(void (^)(void))noNetwork
{
    [MainRequest sendGetRequest:[NSString stringWithFormat:@"%@/elite/feeds",kURLRequest] parameters:@{} success:^(NSURLSessionDataTask * _Nonnull operation, id  _Nonnull responseObject) {
        DDLogInfo(@"%@", responseObject);
        
        MainViewModel *mainModel = [MainViewModel mj_objectWithKeyValues:responseObject];
        
        success(mainModel);
        
    } failure:^(NSURLSessionDataTask * _Nonnull operation, NSError * _Nonnull error) {
        
        failure(error);
        
    } noNetWork:noNetwork];
}


@end
