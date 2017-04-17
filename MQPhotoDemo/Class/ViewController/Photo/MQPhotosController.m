//
//  MQPhotosController.m
//  MQPhotoDemo
//
//  Created by mengmeng on 2017/4/9.
//  Copyright © 2017年 mengmeng. All rights reserved.
//

#import "MQPhotosController.h"
#import "MQAuthorAccessTool.h"
#import "MQPhotosAlbumModel.h"
#import "MQAlertViewTool.h"

#import "MQPhotosGetTool.h"

/*
导入头文件#import <Photos/Photos.h>
PHAsset : 一个资源, 比如一张图片\一段视频
PHAssetCollection : 一个相簿
PHImageManager 图片管理者,是单例,发送请求才能从asset获取图片
PHImageRequestOptions图片请求选项
注意:这个类是iOS8开始推广,iOS9开始废弃之前的方法
系统适配iOS8之前,用<AssetsLibrary/AssetsLibrary.h>库里面的API
*/

@interface MQPhotosController ()
@property (nonatomic,strong) NSMutableArray *titleList;
@end

@implementation MQPhotosController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"所有相册";
    
    self.titleList = [[NSMutableArray alloc] init];
    [self getPhotosLibraryData];
}

#pragma mark - 获取数据
-(void) getPhotosLibraryData {
    __weak typeof(self) weakSelf = self;
    [MQAuthorAccessTool photoLibraryWithAuthCheck:^(MQAuthorAccessStatus authorAccessStatusResult) {
        if (authorAccessStatusResult == MQAuthorAccessStatusAllow) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            strongSelf.titleList = [NSMutableArray arrayWithArray:[MQPhotosGetTool getPhotoLibraryAllWithOriginal:NO]];
        }else if (authorAccessStatusResult == MQAuthorAccessStatusUnknown){
            [MQAuthorAccessTool photoLibraryWithAuthSet:^(BOOL setAuthResult) {
                if (setAuthResult == YES) {
                    __strong typeof(weakSelf) strongSelf = weakSelf;
                    strongSelf.titleList = [NSMutableArray arrayWithArray:[MQPhotosGetTool getPhotoLibraryAllWithOriginal:NO]];
                }
            }];
        }else if (authorAccessStatusResult == MQAuthorAccessStatusNotAllow){
            [MQAlertViewTool showAlertWithMessage:@"请进入 设置 -> 隐私 -> 相册 开启权限" dismissAfterDelay:1.0];
        }
    }];
}

@end
