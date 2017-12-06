//
//  BaseViewController.h
//  dalaoshuo
//
//  Created by 邵义珑 on 2017/7/25.
//  Copyright © 2017年 邵义珑. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"


@interface BaseViewController : UIViewController <MBProgressHUDDelegate,UIAlertViewDelegate>
{
    NSMutableDictionary *dataDic;
    MBProgressHUD *HUD;
}
@property (nonatomic, retain) MBProgressHUD *HUD;
@property (retain,nonatomic) NSMutableDictionary *dataDic;

//MBHUD提示框
- (void)showNetWaiting;

- (void)showNetWaitingWithView:(UIView *)view;

- (void)setNetwaitingContent:(NSString *)content;

- (void)setNetWitingStyle;

- (void)showDiyNetWaitingWithView:(UIView *)view;

- (void)closeNetWaiting;

- (void)showInfo:(NSString *)info;

- (void)showInfo:(NSString *)info withView:(UIView *)view offset:(CGFloat)offset;

- (void)showInfoWithCloseView:(NSString *)info;

- (void)showInfoWithPopToRootView:(NSString *)info;

- (void)showProgressWaiting:(float)progress;

//system提示框
- (void) systemAlert:(NSString *)alertInfo withButtonName:(NSString *)btnName
          cancelName: (NSString *) cancelName tagId:(NSInteger) tagId;

- (void)systemTextFieldAlert:(NSString *)title withButtonName:(NSString *)btnName
                  cancelName: (NSString *) cancelName tagId:(NSInteger) tagId keyBoardType:(NSInteger)keyType message:(NSString *)message placeholder:(NSString *)placeholder;

- (void)systemAlert:(NSString *)alertInfo withButtonName:(NSString *)btnName
         cancelName: (NSString *) cancelName tagId:(NSInteger) tagId title:(NSString *)title;


#pragma mark -- no net button
- (void)showNoNetButton;
- (void)noNetButtonClick:(UIButton *)sender;

@end
