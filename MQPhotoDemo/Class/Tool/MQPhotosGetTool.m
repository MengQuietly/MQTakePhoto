//
//  MQPhotosGetTool.m
//  MQPhotoDemo
//
//  Created by mengmeng on 2017/4/14.
//  Copyright © 2017年 mengmeng. All rights reserved.
//

#import "MQPhotosGetTool.h"
#import "MQPhotosAlbumModel.h"
#import "MQPictureModel.h"

/*
 fetchAssetCollectionsWithType:
 PHAssetCollectionTypeAlbum: 从 iTunes 同步来的相册，以及用户在 Photos 中自己建立的相册
 PHAssetCollectionTypeSmartAlbum: 经由相机得来的相册
 PHAssetCollectionTypeMoment: Photos 为我们自动生成的时间分组的相册
 subtype:
 PHAssetCollectionSubtypeAlbumRegular: //用户在 Photos 中创建的相册，也就是我所谓的逻辑相册
 SmartAlbumPanoramas:  相机拍摄的全景照片
 SmartAlbumVideos: 相机拍摄的视频
 SmartAlbumFavorites: 收藏文件夹
 SmartAlbumTimelapses: 延时视频文件夹，同时也会出现在视频文件夹中
 SmartAlbumAllHidden: 包含隐藏照片或视频的文件夹
 SmartAlbumRecentlyAdded: 相机近期拍摄的照片或视频
 SmartAlbumBursts: 连拍模式拍摄的照片，在 iPad mini 上按住快门不放就可以了，但是照片依然没有存放在这个文件夹下，而是在相机相册里。
 SmartAlbumSlomoVideos: Slomo 是 slow motion 的缩写，高速摄影慢动作解析
 SmartAlbumUserLibrary: 相机相册，所有相机拍摄的照片或视频都会出现在该相册中，而且使用其他应用保存的照片也会出现在这里。
 Any //包含所有类型
 
 // 列出所有相册智能相册
 PHFetchResult *smartAlbumss = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
 NSLog(@"-----smartAlbumss----%ld",smartAlbumss.count);
 
 // 列出所有用户创建的相册
 PHFetchResult *topLevelUserCollections = [PHCollectionList fetchTopLevelUserCollectionsWithOptions:nil];
 
 NSLog(@"-----topLevelUserCollections----%ld",topLevelUserCollections.count);
 
 // 获取所有资源的集合，并按资源的创建时间排序
 PHFetchOptions *options = [[PHFetchOptions alloc] init];
 options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
 PHFetchResult *assetsFetchResults = [PHAsset fetchAssetsWithOptions:options];
 
 NSLog(@"-----assetsFetchResults----%ld",assetsFetchResults.count);
 
 */


@implementation MQPhotosGetTool

#pragma mark -  获得所有相簿:获取所有图片
+(NSArray *) getPhotoLibraryAllWithOriginal:(BOOL) original{
    
    NSMutableArray *photosModelList = [[NSMutableArray alloc] init];
    
    // smartAlbumsList：系统相册
    [MQPhotosGetTool enumerateAssetsInAssetCollectionWithFetchType:PHAssetCollectionTypeSmartAlbum original:original confirm:^(NSArray *photoList) {
        [photosModelList addObjectsFromArray:photoList];
    }];
    
    // albumList：用户自定义相册
    [MQPhotosGetTool enumerateAssetsInAssetCollectionWithFetchType:PHAssetCollectionTypeAlbum original:original confirm:^(NSArray *photoList) {
        [photosModelList addObjectsFromArray:photoList];
    }];
    
    return [photosModelList mutableCopy];
}

#pragma mark -  遍历系统相簿： 获取所有相薄
+(void) enumerateAssetsInAssetCollectionWithFetchType:(PHAssetCollectionType) fetchWithType original:(BOOL) original confirm:(void(^)(NSArray *photoList)) confirm {
    PHFetchResult<PHAssetCollection *> *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:fetchWithType subtype:PHAssetCollectionSubtypeAny options:nil];
    [smartAlbums enumerateObjectsUsingBlock:^(PHAssetCollection* assetCollection,NSUInteger index,BOOL* stop) {
        if ([assetCollection isKindOfClass:[PHAssetCollection class]]) {
            confirm([MQPhotosGetTool enumerateAssetsInAssetCollection:assetCollection original:original]);
        } else {
            NSAssert1(NO, @"Fetch collection not PHCollection: %@", assetCollection);
        }
    }];
}

#pragma mark - 遍历相簿：获取所有图片
+(NSArray *) enumerateAssetsInAssetCollection:(PHAssetCollection *) assetCollection original:(BOOL)original{
    NSMutableArray *tempList = [[NSMutableArray alloc] init];
    PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
    if (fetchResult.count > 0) {
        
        PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
        // 同步获得图片, 只会返回1张图片
        options.synchronous = YES;
        
        NSMutableArray *imgList = [NSMutableArray arrayWithCapacity:fetchResult.count];
        
        for (PHAsset *asset in fetchResult) {
            // 是否要原图
            CGSize size =  original?CGSizeMake(asset.pixelWidth, asset.pixelHeight):CGSizeZero;
            // 从asset中获得图片
            [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                
                if ((result) && (asset.mediaType == PHAssetMediaTypeImage)) {
                    
                    MQPictureModel *pictureModel = [[MQPictureModel alloc] init];
                    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
                    formatter.dateFormat = @"yyyy:MM:dd HH:mm:ss";
                    formatter.timeZone = [NSTimeZone localTimeZone];
                    NSString * pictureTime = [formatter stringFromDate:asset.creationDate];
                    
                    pictureModel.pictureDate = pictureTime;
                    pictureModel.pictureImg = result;
                    
                    MQPictureModelType type = (asset.mediaType == PHAssetMediaTypeImage)? MQPictureModelTypeImage:((asset.mediaType == PHAssetMediaTypeAudio)?MQPictureModelTypeAudio:MQPictureModelTypeVideo);
                    pictureModel.pictureType = type;
                    
                    [imgList addObject:pictureModel];
                }
            }];
        }
        
        // 添加 photosName、photo
        MQPhotosAlbumModel *photosAlbumModel = [[MQPhotosAlbumModel alloc] init];
        photosAlbumModel.photosAlumName =assetCollection.localizedTitle;
        
        NSLog(@"title = %@,%ld",assetCollection.localizedTitle,assetCollection.assetCollectionType);
        
        photosAlbumModel.photosNum = fetchResult.count;
        photosAlbumModel.photoList = [imgList mutableCopy];
        if (([assetCollection.localizedTitle isEqual:@"Videos"]) || ([assetCollection.localizedTitle isEqual:@"视频"])) {
        }else{
            [tempList addObject:photosAlbumModel];
        }
    }
    return [tempList mutableCopy];
}

@end
