//
//  MQPhotoLibraryWithColumnCell.m
//  MQPhotoDemo
//
//  Created by mengmeng on 2017/4/14.
//  Copyright © 2017年 mengmeng. All rights reserved.
//

#import "MQPhotoLibraryWithColumnCell.h"
#import "MQPhotosAlbumModel.h"
#import "MQPictureModel.h"

@interface MQPhotoLibraryWithColumnCell()

@property (nonatomic, strong) UIImageView *libraryIcon;
@property (nonatomic, strong) UILabel *libraryName;
@property (nonatomic, strong) UILabel *libraryNum;

@end
@implementation MQPhotoLibraryWithColumnCell
-(void)setPhotosAlbumModel:(MQPhotosAlbumModel *)photosAlbumModel{
    _photosAlbumModel = photosAlbumModel;
    
    MQPictureModel *model = photosAlbumModel.photoList.lastObject;
    _libraryIcon.image = model.pictureImg;
    _libraryName.text = photosAlbumModel.photosAlumName;
    _libraryNum.text = [NSString stringWithFormat:@"%ld",photosAlbumModel.photosNum];
    
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        
        NSLog(@"-----height:%lf",frame.size.width);
        
        self.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.8];
        
        CGSize viewS = frame.size;
        
        self.contentView.layer.cornerRadius = 5;
        self.contentView.layer.masksToBounds = YES;
        
        CGFloat contentMarginTop = 10;
        CGFloat contentMarginLeft = 8;
        CGFloat nameMarginTop = 5;
        
        CGFloat nameH = viewS.height * 0.15;//25;
        CGFloat numH = viewS.height * 0.13; //20;
        
        CGFloat iconH = viewS.height - contentMarginTop * 2 - nameMarginTop - nameH - numH;
        CGFloat iconW = viewS.width - contentMarginLeft * 2;
        iconH = (iconH < iconW)?iconH:iconW;
        
        self.libraryIcon = [[UIImageView alloc] initWithFrame:CGRectMake(contentMarginLeft, contentMarginTop, iconH, iconH)];
//        self.libraryIcon.backgroundColor = [UIColor orangeColor];
        self.libraryIcon.centerX = viewS.width * 0.5;
        
        CGFloat nameY = CGRectGetMaxY(self.libraryIcon.frame) + nameMarginTop;
        CGFloat nameW = viewS.width - contentMarginLeft * 2;
        self.libraryName = [[UILabel alloc] initWithFrame:CGRectMake(contentMarginLeft, nameY, nameW, nameH)];
        
        self.libraryName.font = [UIFont boldSystemFontOfSize:15];
        self.libraryName.textColor = [UIColor darkGrayColor];
//                self.libraryName.backgroundColor = [UIColor yellowColor];
        
        CGFloat numY = self.libraryName.bottom;
        self.libraryNum = [[UILabel alloc] initWithFrame:CGRectMake(self.libraryName.x, numY, self.libraryName.width, numH)];
        self.libraryNum.font = [UIFont systemFontOfSize:13];
        self.libraryNum.textColor = [UIColor darkGrayColor];
//                self.libraryNum.backgroundColor = [UIColor orangeColor]; 
        
        [self.contentView addSubview:self.libraryIcon];
        [self.contentView addSubview:self.libraryName];
        [self.contentView addSubview:self.libraryNum];
    }
    return self;
}



-(void)layoutSubviews{
    [super layoutSubviews];
}

@end
