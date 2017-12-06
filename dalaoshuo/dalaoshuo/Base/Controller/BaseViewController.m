//
//  BaseViewController.m
//  dalaoshuo
//
//  Created by 邵义珑 on 2017/7/25.
//  Copyright © 2017年 邵义珑. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController
@synthesize HUD,dataDic;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark MBProgressHUD

- (void)showNetWaiting
{
    if (HUD == nil)
    {
        HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD];
        HUD.delegate = self;
    }
    HUD.labelText = NSLocalizedString(@"加载中...", nil);
    [HUD show:YES];
}

- (void)showNetWaitingWithView:(UIView *)view
{
    if (HUD == nil)
    {
        //self.navigationController.view
        HUD = [[MBProgressHUD alloc] initWithView:view];
        [view addSubview:HUD];
        HUD.delegate = self;
    }
    HUD.labelText = NSLocalizedString(@"加载中...", nil);
    [HUD show:YES];
}

- (void)setNetwaitingContent:(NSString *)content
{
    if (HUD != nil)
    {
        HUD.labelText = content;
    }
}

- (void)setNetWitingStyle
{
    if (HUD != nil)
    {
        HUD.opacity = 0;
        HUD.labelText = @"";
    }
    
}

- (void)showDiyNetWaitingWithView:(UIView *)view
{
    if (HUD == nil)
    {
        //self.navigationController.view
        HUD = [[MBProgressHUD alloc] initWithView:view];
        HUD.mode = MBProgressHUDModeIndicatorGray;
        HUD.opacity = 0;
        
        [view addSubview:HUD];
        HUD.delegate = self;
    }
    [HUD show:YES];
}

- (void)closeNetWaiting
{
    if (HUD != nil)
    {
        [HUD hide:YES];
    }
}

- (void)showInfo:(NSString *)info
{
    if (HUD == nil)
    {
        //self.navigationController.view
        HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD];
        HUD.delegate = self;
    }
    HUD.mode = MBProgressHUDModeText;
    HUD.labelText = info;
    [HUD show:YES];
    [HUD hide:YES afterDelay:2];
}

- (void)showInfo:(NSString *)info withView:(UIView *)view offset:(CGFloat)offset
{
    if (HUD == nil)
    {
        //self.navigationController.view
        HUD = [[MBProgressHUD alloc] initWithView:view];
        HUD.yOffset = offset;
        [view addSubview:HUD];
        HUD.delegate = self;
    }
    HUD.mode = 5;
    HUD.labelText = info;
    [HUD show:YES];
    [HUD hide:YES afterDelay:3];
}

- (void)showInfoWithCloseView:(NSString *)info
{
    if (HUD == nil)
    {
        //self.navigationController.view
        HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD];
        HUD.delegate = self;
    }
    HUD.mode = 5;
    HUD.labelText = info;
    
    [HUD show:YES];
    [HUD hide:YES afterDelay:2];
    [self performSelector:@selector(closeView) withObject:nil afterDelay:2];
}

- (void)showProgressWaiting:(float)progress
{
    if (HUD == nil)
    {
        //self.navigationController.view
        HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD];
        HUD.delegate = self;
    }
    HUD.mode = MBProgressHUDModeAnnularDeterminate;
    HUD.progress = progress;
    [HUD show:YES];
}

- (void)closeView
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)showInfoWithPopToRootView:(NSString *)info
{
    if (HUD == nil)
    {
        //self.navigationController.view
        HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD];
        HUD.delegate = self;
    }
    HUD.mode = 5;
    HUD.labelText = info;
    [HUD show:YES];
    [HUD hide:YES afterDelay:2];
    [self performSelector:@selector(popToRootView) withObject:nil afterDelay:2];
}

- (void)popToRootView
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark systemAlert


- (void)systemTextFieldAlert:(NSString *)title withButtonName:(NSString *)btnName
                  cancelName: (NSString *) cancelName tagId:(NSInteger) tagId keyBoardType:(NSInteger)keyType message:(NSString *)message placeholder:(NSString *)placeholder
{
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancelName otherButtonTitles:btnName, nil];
    [alertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
    
    UITextField *tf = [alertView textFieldAtIndex:0];
    //UIKeyboardTypeDecimalPad
    if (keyType == 0)
    {
        [tf setKeyboardType:UIKeyboardTypeNumberPad];
    }
    [tf setKeyboardAppearance:UIKeyboardAppearanceDefault];
    tf.placeholder = placeholder;
    alertView.tag = tagId;
    [alertView show];
}

- (void)systemAlert:(NSString *)alertInfo withButtonName:(NSString *)btnName
         cancelName: (NSString *) cancelName tagId:(NSInteger) tagId
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:alertInfo message:nil delegate:self cancelButtonTitle:cancelName otherButtonTitles:btnName, nil];
    alert.tag = tagId;
    [alert show];
}

- (void)systemAlert:(NSString *)alertInfo withButtonName:(NSString *)btnName
         cancelName: (NSString *) cancelName tagId:(NSInteger) tagId title:(NSString *)title
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:alertInfo delegate:self cancelButtonTitle:cancelName otherButtonTitles:btnName, nil];
    alert.tag = tagId;
    [alert show];
}

#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD was hidded
    [HUD removeFromSuperview];
    HUD = nil;
}


#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
}

#pragma mark -- no net button
- (void)showNoNetButton
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    view.backgroundColor = [UIColor whiteColor];
    view.tag = 9526;
    [self.view addSubview:view];
    
    UIButton *img = [UIButton buttonWithType:UIButtonTypeCustom];
    [img setImage:ImageNamed(@"nonet") forState:UIControlStateNormal];
    img.frame = CGRectMake(0, 0, 60, 45);
    img.centerX = self.view.centerX;
    img.centerY = self.view.centerY -60;
    [img addTarget:self action:@selector(noNetButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:img];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 200, 40);
    button.centerX = self.view.centerX;
    button.centerY = img.centerY + 40;
    [button setTitle:NSLocalizedString(@"加载失败", nil) forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    button.titleLabel.font = font_smallFont;
    
    button.tag = 9527;
    [button addTarget:self action:@selector(noNetButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
}

- (void)noNetButtonClick:(UIButton *)sender
{
    [[self.view viewWithTag:9526] removeFromSuperview];
    //    [[self.view viewWithTag:9528] removeFromSuperview];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
