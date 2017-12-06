//
//  MainViewModel.m
//  dalaoshuo
//
//  Created by 邵义珑 on 2017/7/28.
//  Copyright © 2017年 邵义珑. All rights reserved.
//

#import "MainViewModel.h"

@implementation MainViewModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"posters" : @"PosterModel",
             @"elites" : @"EliteModel",
             @"feeds" : @"FeedModel"
             };
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"errCode":@"errno"
             };
}

@end
