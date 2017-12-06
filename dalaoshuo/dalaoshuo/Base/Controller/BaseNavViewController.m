//
//  BaseNavViewController.m
//  dalaoshuo
//
//  Created by 邵义珑 on 2017/7/25.
//  Copyright © 2017年 邵义珑. All rights reserved.
//

#import "BaseNavViewController.h"

@interface BaseNavViewController ()

@end

@implementation BaseNavViewController

- (void)viewDidLoad
{
    self.edgesForExtendedLayout = UIRectEdgeBottom|UIRectEdgeLeft|UIRectEdgeRight;
    self.automaticallyAdjustsScrollViewInsets = NO;//自动滚动调整，默认为YES
    
    //    _navBackGroundImage = ImageNamed(@"navbg");
    //    _navBackGroundColor = GetColorWithString(ConstColor_navBg);
    _navBackGroundImage = [CommonUtil createImageWithColor:GetColorWithString(ConstColor_navBg)];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 95, 30)];
    imageView.image = ImageNamed(@"navImg");
    
    self.navTitleView = imageView;
    
    //---------nav 标题设置-------------
    if (_navTitleName!=nil)
    {
        self.navigationItem.title=_navTitleName;
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        //        NSFontAttributeName:[UIFont systemFontOfSize:19]
        
    }
    else if(_navTitleView!=nil)
    {
        self.navigationItem.titleView=_navTitleView;
    }
    
    //---------nav 背景设置-------------
    if (_navBackGroundColor!=nil)
    {
        self.navigationController.navigationBar.barTintColor=_navBackGroundColor;
    }
    else if (_navBackGroundImage!=nil)
    {
        [self.navigationController.navigationBar setBackgroundImage:_navBackGroundImage forBarMetrics:UIBarMetricsDefault];
    }
    
    //---------nav 左按钮设置-------------
    if (_leftNavButtonName!=nil)
    {
        UIBarButtonItem *leftBackItem = [[UIBarButtonItem alloc] initWithTitle:_leftNavButtonName style:UIBarButtonItemStylePlain target:self action:@selector(leftNavButtonClick:)];
        self.navigationItem.leftBarButtonItem = leftBackItem;
    }
    else if (_leftNavButtonImage!=nil)
    {
        UIImage *image=[UIImage imageNamed:_leftNavButtonImage];
        UIButton*leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,image.size.width/2,image.size.height/2)];
        [leftButton setImage:image forState:UIControlStateNormal];
        [leftButton addTarget:self action:@selector(leftNavButtonClick:)forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem*leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
        self.navigationItem.leftBarButtonItem= leftItem;
        
    }
    else if (_leftNavButtonImageArr!=nil)
    {
        NSMutableArray *actionButtonItems=[[NSMutableArray alloc]initWithCapacity:1];
        for (int i=0; i<[_leftNavButtonImageArr count]; i++)
        {
            UIImage *image=[UIImage imageNamed:[_leftNavButtonImageArr objectAtIndex:i]];
            UIButton*leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,image.size.width/2,image.size.height/2)];
            [leftButton setImage:image forState:UIControlStateNormal];
            leftButton.tag=i;
            [leftButton addTarget:self action:@selector(leftNavButtonClick:)forControlEvents:UIControlEventTouchUpInside];
            UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
            [actionButtonItems addObject:barButtonItem];
        }
        self.navigationItem.leftBarButtonItems = actionButtonItems;
        
        
    }
    
    //---------nav 右按钮设置-------------
    if (_rightNavButtonName!=nil)
    {
        //        UIBarButtonItem *rightBackItem = [[UIBarButtonItem alloc] initWithTitle:_rightNavButtonName style:UIBarButtonItemStylePlain target:self action:@selector(rightNavButtonClick:)];
        //
        //        self.navigationItem.rightBarButtonItem = rightBackItem;
        
        UIButton *b;
        b = (UIButton*) [[UIButton alloc] init];
        //        [b setShowsTouchWhenHighlighted:YES];
        
        b.backgroundColor = [UIColor clearColor];
        b.titleLabel.font = font_mediumFont;
        [b setTitle:_rightNavButtonName forState:UIControlStateNormal];
        [b setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        CGSize size = [_rightNavButtonName sizeWithFont:b.titleLabel.font];
        CGSize size = [_rightNavButtonName sizeWithAttributes:@{NSFontAttributeName:b.titleLabel.font}];

        b.frame = CGRectMake(0, 0, size.width + 24, 32);
        [b addTarget:self action:@selector(rightNavButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightBackItem = [[UIBarButtonItem alloc] initWithCustomView:b];
        self.navigationItem.rightBarButtonItem = rightBackItem;
        
        
    }
    else if (_rightNavButtonImage!=nil)
    {
        UIImage *image=[UIImage imageNamed:_rightNavButtonImage];
        UIButton*rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,image.size.width/2,image.size.height/2)];
        [rightButton setImage:image forState:UIControlStateNormal];
        [rightButton addTarget:self action:@selector(rightNavButtonClick:)forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
        self.navigationItem.rightBarButtonItem= rightItem;
        
    }
    else if (_rightNavButtonImageArr!=nil)
    {
        NSMutableArray *actionButtonItems=[[NSMutableArray alloc]initWithCapacity:1];
        for (int i=0; i<[_rightNavButtonImageArr count]; i++)
        {
            UIImage *image=[UIImage imageNamed:[_rightNavButtonImageArr objectAtIndex:i]];
            UIButton*rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,image.size.width/2,image.size.height/2)];
            [rightButton setImage:image forState:UIControlStateNormal];
            rightButton.tag=i;
            [rightButton addTarget:self action:@selector(rightNavButtonClick:)forControlEvents:UIControlEventTouchUpInside];
            UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
            [actionButtonItems addObject:barButtonItem];
        }
        self.navigationItem.rightBarButtonItems = actionButtonItems;
    }
    
    if (dataDic == nil)
    {
        dataDic = [NSMutableDictionary dictionaryWithCapacity:0];
    }
    
    //因为左返回按钮是定制的  所以加上这句  实现边缘滑动返回
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }

    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/**
 *nav左按钮单击事件
 */
- (void)leftNavButtonClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *nav右按钮单击事件
 */
- (void)rightNavButtonClick:(UIButton *)button
{
    
}

/**
 *页面push   viewControllerName ：controller名称   dataDic：传递的字典数据  dataType: 1-传递  2-复制
 */
- (void)pushViewController:(NSString *)viewControllerName dataDic:(NSMutableDictionary *)dic dataType:(int)dataType
{
    BaseViewController *baseViewController = [[NSClassFromString(viewControllerName) alloc] init];
    
    if (dataType == 1)
    {
        if (dataDic == nil)
        {
            dataDic = [NSMutableDictionary dictionaryWithCapacity:0];
        }
        baseViewController.dataDic = dic;
    }
    else if (dataType == 2)
    {
        NSMutableDictionary *tempDic = [dic mutableCopy];
        baseViewController.dataDic = tempDic;
    }
    
    //跳转界面时隐藏tabbbars
    [baseViewController setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:baseViewController animated:YES];
    
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
