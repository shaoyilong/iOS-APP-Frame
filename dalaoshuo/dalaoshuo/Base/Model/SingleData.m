//
//  SingleData.m
//  WipaceApp
//
//  Created by 邵义珑 on 16/5/12.
//  Copyright © 2016年 邵义珑. All rights reserved.
//

#import "SingleData.h"

@implementation SingleData

SINGLETON_IMPLEMENTATION(SingleData)

- (UIInterfaceOrientationMask)interfaceOrientationMask
{
    if (self.viewRotateFlag)
    {
        return UIInterfaceOrientationMaskPortrait;
    }else {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    }
}
@end
