//
//  MQPhotosGetTool.h
//  MQPhotoDemo
//
//  Created by mengmeng on 2017/4/14.
//  Copyright © 2017年 mengmeng. All rights reserved.
//

#import <Foundation/Foundation.h>
@import Photos;

@interface MQPhotosGetTool : NSObject

#pragma mark -  获得所有相簿:获取所有图片
+(NSArray *) getPhotoLibraryAllWithOriginal:(BOOL) original ;

#pragma mark -  遍历相簿： 获取所有图片
+(void) enumerateAssetsInAssetCollectionWithFetchType:(PHAssetCollectionType) fetchWithType original:(BOOL) original confirm:(void(^)(NSArray *photoList)) confirm;

@end
