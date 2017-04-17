//
//  UIView+RoundedCorners.m
//  MQTool
//
//  Created by mengmeng on 2017/4/8.
//  Copyright © 2017年 mengmeng. All rights reserved.
//

#import "UIView+RoundedCorners.h"

@implementation UIView (RoundedCorners)

/*
 设置圆角 性能优化：
 第一种：
 aImageView.layer.cornerRadius = aImageView.frame.size.width/2.0;
 aImageView.layer.masksToBounds = YES;
 第二种：
 CAShapeLayer *layer = [CAShapeLayer layer];
 UIBezierPath *aPath = [UIBezierPath bezierPathWithOvalInRect:aImageView.bounds];
 layer.path = aPath.CGPath;
 aImageView.layer.mask = layer;
 结论：layer.cornerRadius 性能 > layer.mask.
 原因：拖慢帧率是Off-Screen Rendering（离屏渲染）的原因。离屏渲染是个好东西，但频繁发生离屏渲染是非常耗时的。
    （一次mask发生了两次离屏渲染和一次主屏渲染）；
 优化：
 self.layer.shouldRasterize = YES; // 会使视图渲染内容被缓存起来，下次绘制的时候可以直接显示缓存，当然要在视图内容不改变的情况下
 self.layer.rasterizationScale = [UIScreen mainScreen].scale;
 注意：建议采取预先生成圆角图片并缓存是比较好的手段。预处理圆角图片可以在后台处理，处理完毕后缓存起来，再在主线程显示，这就避免了不必要的离屏渲染
 
 
 */


/****************************** 设置圆角 ******************************/
// corners 将要设置圆角的位置、radius 圆角度数
-(void)setRoundedCorners:(UIRectCorner)corners radius:(CGFloat)radius {
    CGRect rect = self.bounds;
    
    // Create the path
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];
    
    // Create the shape layer and set its path
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = rect;
    maskLayer.path = maskPath.CGPath;
    
    // Set the newly created shape layer as the mask for the view's layer
    self.layer.mask = maskLayer;
}

/****************************** 设置边框 ******************************/
-(void)setViewBorderWhich:(ViewBorder)borderWhich{

    CGFloat borderW = self.layer.borderWidth;
    CGColorRef borderC = self.layer.borderColor;
    if (borderWhich == 0) {
        return;
    }

    if (self.layer.borderWidth > 1000 || self.layer.borderWidth == 0) {
        borderW = 1;
    }
    if (borderWhich & ViewBorderTop) {
        CALayer *border = [CALayer layer];
        border.frame = CGRectMake(0, 0, self.frame.size.width, borderW);
        border.backgroundColor = borderC;
        [self.layer addSublayer:border];
    }
    if (borderWhich & ViewBorderBottom){
        CALayer *border = [CALayer layer];
        border.frame = CGRectMake(0, self.frame.size.height-borderW, self.frame.size.width, borderW);
        border.backgroundColor = borderC;
        [self.layer addSublayer:border];
    }
    if (borderWhich & ViewBorderLeft){
        CALayer *border = [CALayer layer];
        border.frame = CGRectMake(0, 0, borderW, self.frame.size.height);
        border.backgroundColor = borderC;
        [self.layer addSublayer:border];
    }
    if (borderWhich & ViewBorderRight){
        CALayer *border = [CALayer layer];
        border.frame = CGRectMake(self.frame.size.width-borderW, 0, borderW, self.frame.size.height);
        border.backgroundColor = borderC;
        [self.layer addSublayer:border];
    }
    self.layer.borderWidth = 0;
}


@end
