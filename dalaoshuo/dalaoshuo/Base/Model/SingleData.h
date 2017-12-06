//
//  SingleData.h
//  WipaceApp
//
//  Created by 邵义珑 on 16/5/12.
//  Copyright © 2016年 邵义珑. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingleData : NSObject


@property (nonatomic, assign) BOOL viewRotateFlag;

SINGLETON_INTERFACE(SingleData)

- (UIInterfaceOrientationMask)interfaceOrientationMask;

@end
