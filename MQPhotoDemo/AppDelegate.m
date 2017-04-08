//
//  AppDelegate.m
//  MQPhotoDemo
//
//  Created by mengmeng on 2017/4/7.
//  Copyright © 2017年 mengmeng. All rights reserved.
//

#import "AppDelegate.h"
#import "MQHomeController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    MQHomeController * viewController= [[MQHomeController alloc] init];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewController];
    
    [self setupAppearance];
    
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];

    
    return YES;
}

-(void) setupAppearance{
    
    [UITabBar appearance].tintColor = [UIColor orangeColor];
    UINavigationBar * navigationBar = [UINavigationBar appearance];
    // 透明
    navigationBar.translucent = NO;
    // 导航栏颜色(透明时候会有透明效果)
    navigationBar.barTintColor = [UIColor orangeColor];
    // 导航栏背景色
    navigationBar.backgroundColor = [UIColor yellowColor];
    // 导航条的标题颜色:[navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    dictM[NSForegroundColorAttributeName] = [UIColor whiteColor];
    dictM[NSFontAttributeName] = [UIFont systemFontOfSize:20];
    [navigationBar setTitleTextAttributes:dictM];
    // 导航栏背景图片
    [navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    // 导航栏阴影
    navigationBar.shadowImage = [[UIImage alloc] init];
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
