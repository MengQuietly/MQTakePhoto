//
//  MQAlertViewTool.m
//  MQPhotoDemo
//
//  Created by mengmeng on 2017/4/12.
//  Copyright © 2017年 mengmeng. All rights reserved.
//

#import "MQAlertViewTool.h"
#import "NSString+AttributedString.h"

#define ROOT_VC  UIApplication.sharedApplication.keyWindow.rootViewController

@interface MQAlertViewTool()

@end

@implementation MQAlertViewTool

/****************************** msgAlert:自动消失 ******************************/
+ (void)showAlertWithMessage:(NSString *)message dismissAfterDelay:(CGFloat)afterDelay {
    
    UIWindow *windows = [UIApplication sharedApplication].keyWindow;
    
    UIView *alertBgV = [[UIView alloc] initWithFrame:UIScreen.mainScreen.bounds];
    alertBgV.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.6];
    [windows addSubview:alertBgV];
    
    CGFloat alertW = alertBgV.width * 0.73;
    UIView *alertView = [[UIView alloc] init];
    alertView.backgroundColor = [UIColor whiteColor];
    alertView.layer.cornerRadius = 5.0;
    alertView.frame = CGRectMake(0, 0, alertW, 100);
    alertView.layer.position = alertBgV.center;
    [alertBgV addSubview:alertView];
    
    CGFloat msgX = 8;
    CGFloat msgY = 5;
    CGFloat msgW = alertView.width - msgX * 2;
    CGFloat msgH = [message heightWithParagraphSpeace:5 font:[UIFont systemFontOfSize:14] lineWidth:msgW];
    
    UILabel *msgLab = [[UILabel alloc] initWithFrame:CGRectMake(msgX, msgY, msgW, msgH)];
    msgLab.attributedText = [message stringWithParagraphlineSpeace:5 textColor:[UIColor darkGrayColor] font:[UIFont systemFontOfSize:14]];
    msgLab.numberOfLines = 0;
    msgLab.textAlignment = NSTextAlignmentCenter;
    [alertView addSubview:msgLab];
    
    alertView.height = msgLab.y * 2 + msgLab.height;
    alertView.layer.position = alertBgV.center;
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = afterDelay;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    NSMutableArray *values = @[].mutableCopy;
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [alertView.layer addAnimation:animation forKey:nil];
    
    [UIView animateWithDuration:afterDelay*0.2 animations:^{
        alertBgV.alpha = 0.7;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:afterDelay delay:1 options:UIViewAnimationOptionCurveLinear animations:^{
            alertBgV.alpha = 0.0;
        } completion:^(BOOL finished) {
            [alertBgV removeFromSuperview];
        }];
    }];
}

/****************************** Alert：title\msg\cancelTitle\titleArray\vc ******************************/
+ (void) showAlertWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle titleArray:(NSArray *)titleArray vc:(UIViewController *)vc confirm:(void(^)(NSInteger btnTag))confirm{
    if (!vc) vc = ROOT_VC;
    [MQAlertViewTool showAlertWithAlertStyle:UIAlertControllerStyleAlert title:title message:message cancelTitle:cancelTitle titleArray:titleArray viewController:vc confirm:confirm];
}

/****************************** sheetAlert：title\msg\cancelTitle\titleArray\vc ******************************/
+ (void) showSheetWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle titleArray:(NSArray *)titleArray vc:(UIViewController *)vc confirm:(void(^)(NSInteger btnTag))confirm {
    if (!vc) vc = ROOT_VC;
    [MQAlertViewTool showAlertWithAlertStyle:UIAlertControllerStyleActionSheet title:title message:message cancelTitle:cancelTitle titleArray:titleArray viewController:vc confirm:confirm];
}


/****************************** Alert：title\msg\cancelTitle\vc\btnTitles ******************************/
+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle viewController:(UIViewController *)vc confirm:(void(^)(NSInteger btnTag))confirm buttonTitles:(NSString *)buttonTitles, ... NS_REQUIRES_NIL_TERMINATION {
    
    // 读取可变参数里面的titles数组
    NSMutableArray *titleArray = [[NSMutableArray alloc] initWithCapacity:0];
    va_list list;
    if(buttonTitles) {
        //1.取得第一个参数的值(即是buttonTitles)
        [titleArray addObject:buttonTitles];
        //2.从第2个参数开始，依此取得所有参数的值
        NSString *otherTitle;
        va_start(list, buttonTitles);
        while ((otherTitle = va_arg(list, NSString*))) {
            [titleArray addObject:otherTitle];
        }
        va_end(list);
    }
    
    if (!vc) vc = ROOT_VC;
    
    
    [MQAlertViewTool showAlertWithAlertStyle:UIAlertControllerStyleAlert title:title message:message cancelTitle:cancelTitle titleArray:titleArray viewController:vc confirm:^(NSInteger btnTag) {
        if (confirm)confirm(btnTag);
    }];
}


/****************************** sheetAlert：title\msg\cancelTitle\vc\btnTitles ******************************/
+ (void)showSheetWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle viewController:(UIViewController *)vc confirm:(void(^)(NSInteger btnTag))confirm buttonTitles:(NSString *)buttonTitles, ... NS_REQUIRES_NIL_TERMINATION {
    
    // 读取可变参数里面的titles数组
    NSMutableArray *titleArray = [[NSMutableArray alloc] initWithCapacity:0];
    va_list list;
    if(buttonTitles) {
        //1.取得第一个参数的值(即是buttonTitles)
        [titleArray addObject:buttonTitles];
        //2.从第2个参数开始，依此取得所有参数的值
        NSString *otherTitle;
        va_start(list, buttonTitles);
        while ((otherTitle = va_arg(list, NSString*))) {
            [titleArray addObject:otherTitle];
        }
        va_end(list);
    }
    
    if (!vc) vc = ROOT_VC;
    
    [MQAlertViewTool showAlertWithAlertStyle:UIAlertControllerStyleActionSheet title:title message:message cancelTitle:cancelTitle titleArray:titleArray viewController:vc confirm:^(NSInteger btnTag) {
        if (confirm)confirm(btnTag);
    }];
    
}


/****************************** commonAlert  ******************************/
+ (void) showAlertWithAlertStyle:(UIAlertControllerStyle) alertStyle title:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle titleArray:(NSArray *)titleArray viewController:(UIViewController *)vc confirm:(void(^)(NSInteger btnTag))confirm{
    
    [vc.view endEditing:YES];
    
    UIAlertController *alerVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:alertStyle];
    
//    // 下面两行代码 是修改 title颜色和字体的代码
//    NSAttributedString *attributedMessage = [[NSAttributedString alloc] initWithString:title attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0f], NSForegroundColorAttributeName:[UIColor cyanColor]}];
//    [alerVC setValue:attributedMessage forKey:@"attributedTitle"];
    
    if (cancelTitle.length > 0) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (confirm) {
                confirm(-1);
            }
        }];
        // 此代码 可以修改按钮颜色
//        [cancelAction setValue:[UIColor redColor] forKey:@"titleTextColor"];
        [alerVC addAction:cancelAction];
    }
    
    if (titleArray.count == 0) {
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (confirm) {
                confirm(0);
            }
        }];
        [alerVC addAction:confirmAction];
    }else{
        for (NSInteger i = 0; i<titleArray.count; i++) {
            UIAlertAction *action = [UIAlertAction actionWithTitle:titleArray[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (confirm){
                    confirm(i);
                }
            }];
            [alerVC addAction:action];
        }
    }
    
    [vc presentViewController:alerVC animated:YES completion:^{
        
    }];
    
}


@end
