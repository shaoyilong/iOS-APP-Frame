//
//  BaseNavViewController.h
//  dalaoshuo
//
//  Created by 邵义珑 on 2017/7/25.
//  Copyright © 2017年 邵义珑. All rights reserved.
//

#import "BaseViewController.h"
#import "MBProgressHUD.h"

@interface BaseNavViewController : BaseViewController <UIGestureRecognizerDelegate>

@property (strong,nonatomic) NSString *navTitleName; //nav 标题
@property (strong,nonatomic) UIView  *navTitleView;//nav 标题view

@property (strong,nonatomic) UIColor *navBackGroundColor; //nav背景色
@property (strong,nonatomic) UIImage *navBackGroundImage; //nav背景图片

@property (strong,nonatomic) NSString *leftNavButtonName; //左边按钮名称
@property (strong,nonatomic) NSString *leftNavButtonImage; //左边按钮图片
@property (strong,nonatomic) NSArray *leftNavButtonImageArr; //左边按钮图片组

@property (strong,nonatomic) NSString *rightNavButtonName; //右边按钮名称
@property (strong,nonatomic) NSString *rightNavButtonImage; //右边按钮图片
@property (strong,nonatomic) NSArray *rightNavButtonImageArr; //右边按钮图片组

@end
