//
//  UINavigationController+myAutoRotate.h
//  WipaceApp
//
//  Created by 邵义珑 on 2016/11/4.
//  Copyright © 2016年 邵义珑. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (myAutoRotate)

-(BOOL)shouldAutorotate;
- (NSUInteger)supportedInterfaceOrientations;

@end
