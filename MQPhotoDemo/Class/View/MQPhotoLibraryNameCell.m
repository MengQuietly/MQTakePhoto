//
//  MQPhotoLibraryNameCell.m
//  MQPhotoDemo
//
//  Created by mengmeng on 2017/4/14.
//  Copyright © 2017年 mengmeng. All rights reserved.
//

#import "MQPhotoLibraryNameCell.h"
#import "MQPhotosAlbumModel.h"
#import "MQPictureModel.h"

@interface MQPhotoLibraryNameCell()

@property (nonatomic, strong) UIImageView *libraryIcon;
@property (nonatomic, strong) UILabel *libraryName;
@property (nonatomic, strong) UILabel *libraryNum;
@property (nonatomic, strong) UIView *cellLine;

@end

@implementation MQPhotoLibraryNameCell

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
        
        self.backgroundColor = [UIColor whiteColor];
        
        CGSize viewS = frame.size;
        
        CGFloat contentMarginTop = 10;
        CGFloat contentMarginLeft = 8;
        
        CGFloat iconH = viewS.height - contentMarginTop * 2;
        CGFloat nameH = 30;
        CGFloat numH = 25;
        
        self.libraryIcon = [[UIImageView alloc] initWithFrame:CGRectMake(PADDINT_LEFT, contentMarginTop, iconH, iconH)];
//        self.libraryIcon.backgroundColor = [UIColor orangeColor];
        
        CGFloat nameX = CGRectGetMaxX(self.libraryIcon.frame) + contentMarginLeft;
        CGFloat nameW = frame.size.width - nameX - PADDINT_LEFT;
        CGFloat nameY = self.libraryIcon.centerY - nameH;
        self.libraryName = [[UILabel alloc] initWithFrame:CGRectMake(nameX, nameY, nameW, nameH)];
        
        self.libraryName.font = [UIFont boldSystemFontOfSize:15];
        self.libraryName.textColor = [UIColor darkGrayColor];
//        self.libraryName.backgroundColor = [UIColor yellowColor];
        
        CGFloat numY = self.libraryName.bottom;
        self.libraryNum = [[UILabel alloc] initWithFrame:CGRectMake(self.libraryName.x, numY, self.libraryName.width, numH)];
        self.libraryNum.font = [UIFont systemFontOfSize:13];
        self.libraryNum.textColor = [UIColor darkGrayColor];
//        self.libraryNum.backgroundColor = [UIColor orangeColor];

        self.cellLine = [[UIView alloc] initWithFrame:CGRectMake(PADDINT_LEFT, viewS.height - 0.5, viewS.width - PADDINT_LEFT * 2, 0.5)];
        self.cellLine.backgroundColor = [UIColor redColor];
        
        [self.contentView addSubview:self.libraryIcon];
        [self.contentView addSubview:self.libraryName];
        [self.contentView addSubview:self.libraryNum];
        [self.contentView addSubview:self.cellLine];
    }
    return self;
}



-(void)layoutSubviews{
    [super layoutSubviews];
    
    
}

@end
