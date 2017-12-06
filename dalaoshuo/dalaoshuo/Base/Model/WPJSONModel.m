//
//  WPJSONModel.m
//  WipaceApp
//
//  Created by 邵义珑 on 16/5/12.
//  Copyright © 2016年 邵义珑. All rights reserved.
//

#import "WPJSONModel.h"

@implementation WPJSONModel

- (id)init {
    if ((self = [super init])) {
        [JSONModel setGlobalKeyMapper:[
                                       [JSONKeyMapper alloc] initWithDictionary:@{@"errno" : @"errorCode",@"id" : @"categoryid"}]
         ];
    }
    
    return self;
}

@end
