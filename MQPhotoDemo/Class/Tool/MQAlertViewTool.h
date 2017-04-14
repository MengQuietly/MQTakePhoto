//
//  MQAlertViewTool.h
//  MQPhotoDemo
//
//  Created by mengmeng on 2017/4/12.
//  Copyright © 2017年 mengmeng. All rights reserved.
//  alertTool

#import <Foundation/Foundation.h>

// 取消按钮的Index是cancelIndex -1

@interface MQAlertViewTool : NSObject

/****************************** msgAlert:自动消失 ******************************/
+ (void)showAlertWithMessage:(NSString *)message dismissAfterDelay:(CGFloat)afterDelay ;

/****************************** Alert：title\msg\cancelTitle\titleArray\vc ******************************/
+ (void) showAlertWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle titleArray:(NSArray *)titleArray vc:(UIViewController *)vc confirm:(void(^)(NSInteger btnTag))confirm ;

/****************************** sheetAlert：title\msg\cancelTitle\titleArray\vc ******************************/
+ (void) showSheetWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle titleArray:(NSArray *)titleArray vc:(UIViewController *)vc confirm:(void(^)(NSInteger btnTag))confirm ;

/****************************** Alert：title\msg\cancelTitle\vc\btnTitles ******************************/
+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle viewController:(UIViewController *)vc confirm:(void(^)(NSInteger btnTag))confirm buttonTitles:(NSString *)buttonTitles, ... NS_REQUIRES_NIL_TERMINATION;

/****************************** sheetAlert：title\msg\cancelTitle\vc\btnTitles ******************************/
+ (void)showSheetWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle viewController:(UIViewController *)vc confirm:(void(^)(NSInteger btnTag))confirm buttonTitles:(NSString *)buttonTitles, ... NS_REQUIRES_NIL_TERMINATION;



@end
