//
//  UINavigationController+myAutoRotate.m
//  WipaceApp
//
//  Created by 邵义珑 on 2016/11/4.
//  Copyright © 2016年 邵义珑. All rights reserved.
//

#import "UINavigationController+myAutoRotate.h"

@implementation UINavigationController (myAutoRotate)

- (BOOL)shouldAutorotate
{
    return self.topViewController.shouldAutorotate;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return self.topViewController.supportedInterfaceOrientations;
}

@end
