//
//  MQPictureModel.h
//  MQPhotoDemo
//
//  Created by mengmeng on 2017/4/17.
//  Copyright © 2017年 mengmeng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MQPictureModelType) {
    MQPictureModelTypeImage = 0,
    MQPictureModelTypeVideo,
    MQPictureModelTypeAudio,
};

@interface MQPictureModel : NSObject

@property (nonatomic,copy) NSString *pictureName;
@property (nonatomic,copy) NSString *pictureDate;
@property (nonatomic,strong) UIImage *pictureImg;
@property (nonatomic) MQPictureModelType pictureType;

@end
