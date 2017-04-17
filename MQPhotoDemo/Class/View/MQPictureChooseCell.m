//
//  MQPictureChooseCell.m
//  MQPhotoDemo
//
//  Created by mengmeng on 2017/4/17.
//  Copyright © 2017年 mengmeng. All rights reserved.
//

#import "MQPictureChooseCell.h"
#import "MQPictureModel.h"

@interface MQPictureChooseCell()

@property (nonatomic, strong) UIImageView *pictureIcon;

@end

@implementation MQPictureChooseCell


-(void)setPictureModel:(MQPictureModel *)pictureModel{
    _pictureModel = pictureModel;
    _pictureIcon.image = pictureModel.pictureImg;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        
        NSLog(@"-----height:%lf",frame.size.width);
        
        self.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.8];
//        CGSize viewS = frame.size;
//        self.contentView.layer.cornerRadius = 5;
//        self.contentView.layer.masksToBounds = YES;
        
//        CGFloat contentMarginTop = 10;
//        CGFloat contentMarginLeft = 8;
//        CGFloat nameMarginTop = 5;
//        
//        CGFloat nameH = viewS.height * 0.15;//25;
//        CGFloat numH = viewS.height * 0.13; //20;
//        
//        CGFloat iconH = viewS.height - contentMarginTop * 2 - nameMarginTop - nameH - numH;
//        CGFloat iconW = viewS.width - contentMarginLeft * 2;
//        iconH = (iconH < iconW)?iconH:iconW;
        
        self.pictureIcon = [[UIImageView alloc] initWithFrame:self.bounds];
//                self.libraryIcon.backgroundColor = [UIColor orangeColor];
        
        [self.contentView addSubview:self.pictureIcon];
    }
    return self;
}



-(void)layoutSubviews{
    [super layoutSubviews];
}


@end
