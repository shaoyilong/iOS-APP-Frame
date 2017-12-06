//
//  UITabBarController+myAutoRotate.m
//  WipaceApp
//
//  Created by 邵义珑 on 2016/11/4.
//  Copyright © 2016年 邵义珑. All rights reserved.
//

#import "UITabBarController+myAutoRotate.h"

@implementation UITabBarController (myAutoRotate)

- (BOOL)shouldAutorotate
{
    return [[self.viewControllers objectAtIndex:(int)self.selectedIndex] shouldAutorotate];
}

- (NSUInteger)supportedInterfaceOrientations
{
    return [[self.viewControllers objectAtIndex:(int)self.selectedIndex] supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [[self.viewControllers objectAtIndex:(int)self.selectedIndex] preferredInterfaceOrientationForPresentation];
}

@end
