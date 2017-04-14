//
//  UIViewController+TopViewController.m
//  MQPhotoDemo
//
//  Created by mengmeng on 2017/4/13.
//  Copyright © 2017年 mengmeng. All rights reserved.
//

#import "UIViewController+TopViewController.h"
#import "AppDelegate.h"

@implementation UIViewController (TopViewController)

/****************************** topVC ******************************/
+ (UIViewController *)topViewController{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return [self topViewControllerWithRootViewController:delegate.window.rootViewController];
}

+ (UIViewController *)topViewControllerWithRootViewController:(UIViewController *)rootViewController{
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController *presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}

@end
