//
//  MQPhotoController.m
//  MQPhotoDemo
//
//  Created by mengmeng on 2017/4/8.
//  Copyright © 2017年 mengmeng. All rights reserved.
//

#import "MQPhotoController.h"
#import <Photos/Photos.h>

@interface MQPhotoController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation MQPhotoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"相册";
    
//    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init]
    [self getImageFromIpc];
    
    
}

#pragma mark - 获取单张图片: 从系统自带的App(照片\相机)中获得图片
-(void) getImageFromIpc{
    // 判断相册是否可以打开
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        return;
    }
    UIImagePickerController *pickerVC = [[UIImagePickerController alloc] init];
    // 打开照片相册类型(显示所有相簿)
    pickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pickerVC.delegate = self;
    [self presentViewController:pickerVC animated:YES completion:^{
        
    }];
}

#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    // 销毁控制器
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    UIImage *img = info[UIImagePickerControllerOriginalImage];
    NSLog(@"img = %@",img);
}





@end
