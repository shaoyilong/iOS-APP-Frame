//
//  AppDelegate.m
//  dalaoshuo
//
//  Created by 邵义珑 on 2017/7/25.
//  Copyright © 2017年 邵义珑. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "BossViewController.h"
#import "MySettingViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    NSLog(@"wwwwwwwwwww");
    [self creatMainView];
    [self addDDLog];
    NSLog(@"aaaaaa");
    NSLog(@"bbbbbbbb");
    
    return YES;
}

- (void)addDDLog
{
    
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
    
    DDLogError(@"错误信息");
    DDLogWarn(@"警告");
    DDLogInfo(@"提示信息");
    DDLogVerbose(@"详细信息");
}

- (void)creatMainView
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    
    MainViewController *vc1 = [[MainViewController alloc] init];
    BossViewController *vc2 = [[BossViewController alloc] init];
    MySettingViewController *vc3 = [[MySettingViewController alloc] init];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:vc1];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:vc2];
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:vc3];

    tabBarController.viewControllers = [NSArray arrayWithObjects:nav1,nav2,nav3, nil];

    
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:tabBarController];
    
    self.window.rootViewController = tabBarController;
    
    [self.window makeKeyAndVisible];

    NSArray *titleArray = @[@"主页",@"大佬",@"我的"];
    //设置选中图片和未选中图片
    NSArray *selectArray = @[@"main_0",@"boss_0",@"my_0"];
    NSArray *unSelectArray = @[@"main_1",@"boss_1",@"my_1"];
    
    for (int i=0; i < tabBarController.viewControllers.count; i++)
    {
        //找出对应的item
        UITabBarItem*item = tabBarController.tabBar.items[i];
        
//        [item setImageInsets:UIEdgeInsetsMake(5, 0, -5, 0)];
        
        item.image = [[UIImage imageNamed:unSelectArray[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        item.selectedImage = [[UIImage imageNamed:selectArray[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        item.title = titleArray[i];
    }
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
