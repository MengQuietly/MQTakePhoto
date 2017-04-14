//
//  MQTakePhotoController.m
//  MQPhotoDemo
//
//  Created by mengmeng on 2017/4/8.
//  Copyright © 2017年 mengmeng. All rights reserved.
//

#import "MQTakePhotoController.h"
#import <Photos/Photos.h>

#import "MQAuthorAccessTool.h"
@import CoreLocation;

@interface MQTakePhotoController ()

@end

@implementation MQTakePhotoController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.title = @"么么哒";
    
    
    
//    [MQAuthorAccessTool calendarWithAuthCheck:MQEntityTypeReminder finishBlock:^(MQAuthorAccessStatus authorAccessStatusResult) {
//        NSLog(@"-----result--%ld",authorAccessStatusResult);
//        
//        switch (authorAccessStatusResult) {
//            case MQAuthorAccessStatusAllow:{
//                NSLog(@"打开相册");
////                CLLocationManager *manager = [[CLLocationManager alloc] init];
////                [manager requestAlwaysAuthorization];//一直获取定位信息
//            }
//                break;
//            case MQAuthorAccessStatusNotAllow:
//                NSLog(@"拒绝相册");
//                break;
//            case MQAuthorAccessStatusInUse:
//                NSLog(@"使用");
//                break;
//            case MQAuthorAccessStatusUnknown:{
//                NSLog(@"未知");
//                [MQAuthorAccessTool calendarWithAuthSet:MQEntityTypeReminder finishBlock:^(BOOL setAuthResult) {
//                    if (setAuthResult == YES) {
//                        NSLog(@"打开相册");
//                    }else{
//                        NSLog(@"拒绝授权相册");
//                    }
//                }];
//
//                
////                CLLocationManager *manager = [[CLLocationManager alloc] init];
////                [manager requestWhenInUseAuthorization];//一直获取定位信息
//            }
//                break;
//            default:
//                break;
//        }
//                
////        CLLocationManager *manager = [[CLLocationManager alloc] init];
////        [manager requestAlwaysAuthorization];//一直获取定位信息
////        [manager requestWhenInUseAuthorization];//使用的时候获取定位信息
//        
//    }];
    
    
    
//    [self getAuth];
//    [MQAuthorAccessTool captureVideoWithAuthcheck:^(MQAuthorAccessStatus authorAccessStatusResult) {
//        
//        switch (authorAccessStatusResult) {
//            case MQAuthorAccessStatusAuthorized:
//                NSLog(@"打开相册");
//                break;
//            case MQAuthorAccessStatusNotDetermined:
//                [MQAuthorAccessTool captureVideoWithAuthSet:^(BOOL setAuthResult) {
//                    if (setAuthResult == YES) {
//                        NSLog(@"打开相册");
//                    }else{
//                        NSLog(@"拒绝授权相册");
//                    }
//                }];
//                break;
//            case MQAuthorAccessStatusDenied:
//                NSLog(@"请进入 设置 -> 隐私 -> 相册 开启权限");
//                break;
//            default:
//                break;
//        }
//    }];
}

@end
