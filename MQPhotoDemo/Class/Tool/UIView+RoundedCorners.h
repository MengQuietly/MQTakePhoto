//
//  UIView+RoundedCorners.h
//  MQTool
//
//  Created by mengmeng on 2017/4/8.
//  Copyright © 2017年 mengmeng. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 边框方向
typedef NS_OPTIONS(NSUInteger, ViewBorder) {
    ViewBorderTop = 1 << 0,
    ViewBorderLeft = 1 << 1,
    ViewBorderBottom = 1 << 2,
    ViewBorderRight = 1 << 3
};

@interface UIView (RoundedCorners)
/****************************** 设置指定位置的圆角:可设置多个位置 ******************************/
-(void)setRoundedCorners:(UIRectCorner)corners radius:(CGFloat)radius;

/****************************** 设置边框:可设置多边 ******************************/
-(void)setViewBorderWhich:(ViewBorder)borderWhich;
@end
