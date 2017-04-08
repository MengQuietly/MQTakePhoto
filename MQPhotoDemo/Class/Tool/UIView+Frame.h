//
//  UIView+Frame.h
//  MQTool
//
//  Created by mengmeng on 2017/4/8.
//  Copyright © 2017年 mengmeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

/****************************** X、Y、W、H ******************************/
@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

/****************************** centerX、centerY ******************************/
@property(nonatomic) CGFloat centerX;
@property(nonatomic) CGFloat centerY;

/****************************** origin、size ******************************/
@property(nonatomic) CGPoint origin;
@property(nonatomic) CGSize size;

/****************************** top、bottom、left、right ******************************/
@property(nonatomic) CGFloat top;
@property(nonatomic) CGFloat bottom;
@property(nonatomic) CGFloat left;
@property(nonatomic) CGFloat right;

@end
