//
//  NSString+AttributedString.h
//  MQTool
//
//  Created by mengmeng on 2017/4/7.
//  Copyright © 2017年 mengmeng. All rights reserved.
//  富文本编辑

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

// 过期提醒
#define MQAddititonsDeprecated(instead) NS_DEPRECATED(1_0, 1_0, 2_0, 2_0, instead)

@interface NSString (AttributedString)

/****************************** 设置段落样式(行高、字色／体) ******************************/

/**
 设置段落样式

 @param lineSpacing 行高
 @param textcolor 字体颜色
 @param font 字体
 @return 包含关键字的富文本编辑
 */
-(NSAttributedString *)stringWithParagraphlineSpeace:(CGFloat)lineSpacing textColor:(UIColor *)textcolor font:(UIFont *)font;

/****************************** (Old)设置含关键字的富文本(行高、字属性、关键字／属性) ******************************/

/**
 返回包含关键字的富文本编辑(建议使用 下一个方法 “stringWithParagraphlineSpeace: NormalAttributeFC: withKeyTextColor:KeyAttributeFC:”)

 @param lineSpacing 行高
 @param textcolor 字体颜色
 @param font 字体
 @param KeyColor 关键字字体颜色
 @param KeyFont 关键字字体
 @param KeyWords 关键字数组
 @return 关键字的富文本编辑
 */
-(NSAttributedString *)stringWithParagraphlineSpeace:(CGFloat)lineSpacing textColor:(UIColor *)textcolor textFont:(UIFont *)font withKeyTextColor:(UIColor *)KeyColor keyFont:(UIFont *)KeyFont keyWords:(NSArray *)KeyWords MQAddititonsDeprecated("使用stringWithParagraphlineSpeace: NormalAttributeFC: withKeyTextColor:KeyAttributeFC:");

/****************************** (NEW)设置含关键字的富文本(行高、字属性、关键字／属性) ******************************/

/**
 返回包含关键字的富文本编辑

 @param lineSpacing 行高
 @param NormalFC 普通文字的属性字典
 @param KeyWords 关键字数组
 @param keyFC 关键字的属性字典
 @return 包含关键字的富文本编辑
 */
-(NSAttributedString *)stringWithParagraphlineSpeace:(CGFloat)lineSpacing NormalAttributeFC:(NSDictionary *)NormalFC withKeyTextColor:(NSArray *)KeyWords KeyAttributeFC:(NSDictionary *)keyFC;

/****************************** (Old)设置含关键字的富文本(行高、字属性、回调文本) ******************************/

/**
 返回包含关键字的富文本编辑
 
 @param lineSpacing 行高
 @param textcolor 字体颜色
 @param font 字体
 @param compalted 回调富文本
 @return 包含关键字的富文本编辑
 */
-(NSAttributedString *)stringWithParagraphlineSpeace:(CGFloat)lineSpacing textColor:(UIColor *)textcolor textFont:(UIFont *)font compated:(void(^)(NSMutableAttributedString * attriStr))compalted;

/****************************** (NEW)设置含关键字的富文本(行高、字属性、回调文本) ******************************/

/**
 返回包含关键字的富文本编辑
 
 @param lineSpacing 行高
 @param attributeFC 普通文字的属性字典
 @param compalted 回调富文本
 @return 包含关键字的富文本编辑
 */
-(NSAttributedString *)stringWithParagraphlineSpeace:(CGFloat)lineSpacing attributeFC:(NSDictionary *)attributeFC compated:(void(^)(NSMutableAttributedString * attriStr))compalted;

/****************************** 计算富文本字体高度(行高、字体、行宽) ******************************/

/**
 计算富文本字体高度

 @param lineSpeace 行高
 @param font 字体
 @param lineWidth 字体所占宽度
 @return 富文本高度
 */
-(CGFloat)heightWithParagraphSpeace:(CGFloat)lineSpeace font:(UIFont *)font lineWidth:(CGFloat)lineWidth;

@end
