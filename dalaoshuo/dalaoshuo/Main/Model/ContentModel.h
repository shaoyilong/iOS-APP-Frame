//
//  ContentModel.h
//  dalaoshuo
//
//  Created by 邵义珑 on 2017/7/28.
//  Copyright © 2017年 邵义珑. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContentModel : NSObject

@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *contentId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *duration;
@property (nonatomic, strong) NSString *size;
@property (nonatomic, strong) NSString *reads;
@property (nonatomic, strong) NSString *favorites;


@end
