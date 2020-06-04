//
//  BossViewController.m
//  dalaoshuo
//
//  Created by 邵义珑 on 2017/7/26.
//  Copyright © 2017年 邵义珑. All rights reserved.
//

#import "BossViewController.h"

@interface BossViewController ()

@end

@implementation BossViewController

- (void)viewDidLoad {
    self.navTitleName = @"大佬";
    self.view.backgroundColor = [UIColor grayColor];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel *label = [UILabel new];
    label.frame = CGRectMake(100, 100, 100, 100);
    label.text = @"1111111";
    label.backgroundColor = [UIColor redColor];
    label.font = [UIFont systemFontOfSize:18];
    label.numberOfLines = 0;
    [self.view addSubview:label];
    
    
    UIButton *button = [UIButton new];
    UIButton *button2 = [UIButton new];
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
