//
//  NSString+AttributedString.m
//  MQTool
//
//  Created by mengmeng on 2017/4/7.
//  Copyright © 2017年 mengmeng. All rights reserved.
//

#import "NSString+AttributedString.h"

@implementation NSString (AttributedString)

/****************************** 设置段落样式(行高、字色／体) ******************************/
-(NSAttributedString *)stringWithParagraphlineSpeace:(CGFloat)lineSpacing textColor:(UIColor *)textcolor font:(UIFont *)font{
    
    return [self stringWithParagraphlineSpeace:lineSpacing textColor:textcolor textFont:font compated:nil];
}

/****************************** (Old)设置含关键字的富文本(行高、字属性、关键字／属性) ******************************/
-(NSAttributedString *)stringWithParagraphlineSpeace:(CGFloat)lineSpacing textColor:(UIColor *)textcolor textFont:(UIFont *)font withKeyTextColor:(UIColor *)KeyColor keyFont:(UIFont *)KeyFont keyWords:(NSArray *)KeyWords MQAddititonsDeprecated("使用stringWithParagraphlineSpeace: NormalAttributeFC: withKeyTextColor:KeyAttributeFC:"){
    
    NSAttributedString * AttributeString = [self stringWithParagraphlineSpeace:lineSpacing textColor:textcolor textFont:font compated:^(NSMutableAttributedString *attriStr) {
        NSDictionary * KeyattriBute = @{NSForegroundColorAttributeName:KeyColor,NSFontAttributeName:KeyFont};
        for (NSString * item in KeyWords) {
            NSRange  range = [self rangeOfString:item options:(NSCaseInsensitiveSearch)];
            [attriStr addAttributes:KeyattriBute range:range];
        }
    }];
    return AttributeString;
}

/****************************** (NEW)设置含关键字的富文本(行高、字属性、关键字／属性) ******************************/
-(NSAttributedString *)stringWithParagraphlineSpeace:(CGFloat)lineSpacing NormalAttributeFC:(NSDictionary *)NormalFC withKeyTextColor:(NSArray *)KeyWords KeyAttributeFC:(NSDictionary *)keyFC{
    
    NSAttributedString * AttributeString = [self stringWithParagraphlineSpeace:lineSpacing attributeFC:NormalFC compated:^(NSMutableAttributedString *attriStr) {
        for (NSString * item in KeyWords) {
            NSRange  range = [self rangeOfString:item options:(NSCaseInsensitiveSearch)];
            [attriStr addAttributes:keyFC range:range];
        }
    }];
    return AttributeString;
}

/****************************** (Old)设置含关键字的富文本(行高、字属性、回调文本) ******************************/
-(NSAttributedString *)stringWithParagraphlineSpeace:(CGFloat)lineSpacing textColor:(UIColor *)textcolor textFont:(UIFont *)font compated:(void(^)(NSMutableAttributedString * attriStr))compalted {
    // 设置段落
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpacing;
    // NSKernAttributeName字体间距
    NSDictionary *attributes = @{ NSParagraphStyleAttributeName:paragraphStyle,NSKernAttributeName:@1.5f};
    NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:self attributes:attributes];
    // 创建文字属性
    NSDictionary * attriBute = @{NSForegroundColorAttributeName:textcolor,NSFontAttributeName:font};
    [attriStr addAttributes:attriBute range:NSMakeRange(0, self.length)];
    if (compalted) {
        compalted(attriStr);
    }
    return attriStr;
}

/****************************** (NEW)设置含关键字的富文本(行高、字属性、回调文本) ******************************/
-(NSAttributedString *)stringWithParagraphlineSpeace:(CGFloat)lineSpacing attributeFC:(NSDictionary *)attributeFC compated:(void(^)(NSMutableAttributedString * attriStr))compalted {
    // 设置段落
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpacing;
    // NSKernAttributeName字体间距
    NSDictionary *attributes = @{ NSParagraphStyleAttributeName:paragraphStyle,NSKernAttributeName:@.5f};
    NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:self attributes:attributes];
    // 创建文字属性
    //NSDictionary * attriBute = @{NSForegroundColorAttributeName:textcolor,NSFontAttributeName:font};
    
    [attriStr addAttributes:attributeFC range:NSMakeRange(0, self.length)];
    if (compalted) {
        compalted(attriStr);
    }
    return attriStr;
}

/****************************** 计算富文本字体高度(行高、字体、行宽) ******************************/
-(CGFloat)heightWithParagraphSpeace:(CGFloat)lineSpeace font:(UIFont*)font lineWidth:(CGFloat)lineWidth{
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    /** 行高 */
    paraStyle.lineSpacing = lineSpeace;
    // NSKernAttributeName字体间距
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f };
    CGSize size = [self boundingRectWithSize:CGSizeMake(lineWidth,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height;
}

@end
