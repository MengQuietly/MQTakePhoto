//
//  MQPhotosAlbumModel.h
//  MQPhotoDemo
//
//  Created by mengmeng on 2017/4/9.
//  Copyright © 2017年 mengmeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MQPhotosAlbumModel : NSObject

@property (nonatomic,copy) NSString *photosAlumName;
@property (nonatomic,assign) NSUInteger photosNum;
@property (nonatomic,copy) NSArray *photoList;

@end
