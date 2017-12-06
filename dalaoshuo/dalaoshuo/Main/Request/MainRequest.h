//
//  MainRequest.h
//  dalaoshuo
//
//  Created by 邵义珑 on 2017/7/28.
//  Copyright © 2017年 邵义珑. All rights reserved.
//

#import "WPClient.h"
#import "MainViewModel.h"

@interface MainRequest : WPClient

SINGLETON_INTERFACE(MainRequest)

//首页接口
- (void)getMainViewInfoSuccess:(void (^)(MainViewModel *model))success
                       failure:(void (^)(NSError *error))failure
                     noNetWork:(void (^)(void))noNetwork;
@end
