//
//  MQAuthorAccessTool.m
//  MQPhotoDemo
//
//  Created by mengmeng on 2017/4/10.
//  Copyright © 2017年 mengmeng. All rights reserved.
//

#import "MQAuthorAccessTool.h"
@import CoreTelephony; // 联网权限
@import Photos; // 相册权限
@import CoreLocation; // 定位权限
@import Contacts; // 通讯录权限
@import EventKit; // 日历／备忘录


#define SYSTEM_VERSION [UIDevice.currentDevice.systemVersion floatValue]

@implementation MQAuthorAccessTool

/****************************** 打开设置界面 ******************************/
+(void)openSystemSetting {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
}

/*
 Restricted:蜂窝数据限制
 NotRestricted:蜂窝数据不受限制
 Unknown:蜂窝数据限制状态未知
 */
/****************************** 检查联网权限(APP启动) ******************************/
+(void) networkingWithNetCheck:(void (^)(MQAuthorAccessStatus authorAccessStatusResult)) finishBlock {
    
    CTCellularData *cellularData = [[CTCellularData alloc]init];
    cellularData.cellularDataRestrictionDidUpdateNotifier =  ^(CTCellularDataRestrictedState state){
        //获取联网状态
        switch (state) {
            case kCTCellularDataRestricted:
                finishBlock(MQAuthorAccessStatusAllow);
                break;
            case kCTCellularDataNotRestricted:
                finishBlock(MQAuthorAccessStatusNotAllow);
                break;
            case kCTCellularDataRestrictedStateUnknown:
                finishBlock(MQAuthorAccessStatusUnknown);
                break;
            default:
                break;
        };
    };
}

/****************************** 检查联网功能(APP启动) ******************************/
+(void) networkingWithAuthCheck:(void (^)(MQAuthorAccessStatus authorAccessStatusResult)) finishBlock {
    
    CTCellularData *cellularData = [[CTCellularData alloc]init];
    CTCellularDataRestrictedState state = cellularData.restrictedState;
    //获取联网状态
    switch (state) {
        case kCTCellularDataRestricted:
            finishBlock(MQAuthorAccessStatusAllow);
            break;
        case kCTCellularDataNotRestricted:
            finishBlock(MQAuthorAccessStatusNotAllow);
            break;
        case kCTCellularDataRestrictedStateUnknown:
            finishBlock(MQAuthorAccessStatusUnknown);
            break;
        default:
            break;
    };
}

/*
 photoLibary权限，在iOS 9.0 废弃: <AssetsLibrary/AssetsLibrary.h> -> ALAssetsLibrary.authorizationStatus
 photoLibary权限，在iOS 8.0 启用: <Photos/Photos.h> -> PHPhotoLibrary.authorizationStatus
 
 PHAuthorizationStatus:
 Authorized： 已授权。
 Restricted: 家长控制,不允许访问
 Denied: 已拒绝此访问,需提示打开访问开关
 NotDetermined： 未作出选择
 */

/****************************** 检查相册权限 ******************************/
+(void) photoLibraryWithAuthCheck:(void (^)(MQAuthorAccessStatus authorAccessStatusResult)) finishBlock{
    
    PHAuthorizationStatus photoAuthorStatus = [PHPhotoLibrary authorizationStatus];
    switch (photoAuthorStatus) {
        case PHAuthorizationStatusAuthorized:
            finishBlock(MQAuthorAccessStatusAllow);
            break;
        case PHAuthorizationStatusDenied:
        case PHAuthorizationStatusRestricted:
            finishBlock(MQAuthorAccessStatusNotAllow);
            break;
        case PHAuthorizationStatusNotDetermined:
            finishBlock(MQAuthorAccessStatusUnknown);
            break;
        default:
            break;
    }
}

/****************************** 设置相册权限 ******************************/
+ (void)photoLibraryWithAuthSet:(void (^)(BOOL setAuthResult)) finishBlock {
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if(status == PHAuthorizationStatusAuthorized){
            finishBlock(YES);
        }else{
            finishBlock(NO);
        }
    }];
}


/****************************** 检查相机/麦克风权限 ******************************/
+(void) captureWithAuthCheck:(MQMediaType) mediaType finishBlock:(void (^)(MQAuthorAccessStatus authorAccessStatusResult)) finishBlock {
    
    NSString *mediaTypeStr = (mediaType == MQMediaTypeVideo)?@"AVMediaTypeVideo":@"AVMediaTypeAudio";
    AVAuthorizationStatus videoStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaTypeStr];
    switch (videoStatus) {
        case AVAuthorizationStatusAuthorized:
            finishBlock(MQAuthorAccessStatusAllow);
            break;
        case AVAuthorizationStatusDenied:
        case AVAuthorizationStatusRestricted:
            finishBlock(MQAuthorAccessStatusNotAllow);
            break;
        case AVAuthorizationStatusNotDetermined:
            finishBlock(MQAuthorAccessStatusUnknown);
            break;
        default:
            break;
    }
}

/****************************** 设置相机/麦克风权限 ******************************/
+ (void)captureWithAuthSet:(MQMediaType) mediaType finishBlock:(void (^)(BOOL setAuthResult)) finishBlock {
    NSString *mediaTypeStr = (mediaType == MQMediaTypeVideo)?@"AVMediaTypeVideo":@"AVMediaTypeAudio";
    [AVCaptureDevice requestAccessForMediaType:mediaTypeStr completionHandler:^(BOOL granted) {
        finishBlock(granted);
    }];
}

/****************************** 检查通讯录权限 ******************************/
+(void) contactWithAuthCheck:(void (^)(MQAuthorAccessStatus authorAccessStatusResult)) finishBlock {
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    switch (status) {
        case CNAuthorizationStatusAuthorized:
            NSLog(@"Authorized:");
            finishBlock(MQAuthorAccessStatusAllow);
            break;
        case CNAuthorizationStatusDenied:
        case CNAuthorizationStatusRestricted:
            NSLog(@"Denied");
            finishBlock(MQAuthorAccessStatusNotAllow);
            break;
        case CNAuthorizationStatusNotDetermined:
            NSLog(@"NotDetermined");
            finishBlock(MQAuthorAccessStatusUnknown);
            break;
        default:
            break;
    }
}
/****************************** 设置通讯录权限 ******************************/
+ (void)contactWithAuthSet:(void (^)(BOOL setAuthResult)) finishBlock {
    CNContactStore *contactStore = [[CNContactStore alloc] init];
    [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
        finishBlock(granted);
    }];
}

/****************************** 检查日历／备忘录权限 ******************************/
+(void) calendarWithAuthCheck:(MQEntityType) entityType finishBlock:(void (^)(MQAuthorAccessStatus authorAccessStatusResult)) finishBlock {
    EKEntityType entityTypeStr = (entityType == MQEntityTypeCalendar) ? EKEntityTypeEvent : EKEntityTypeReminder;
    EKAuthorizationStatus EKstatus = [EKEventStore  authorizationStatusForEntityType:entityTypeStr];
    switch (EKstatus) {
        case EKAuthorizationStatusAuthorized:
            NSLog(@"Authorized");
            finishBlock(MQAuthorAccessStatusAllow);
            break;
        case EKAuthorizationStatusDenied:
        case EKAuthorizationStatusRestricted:
            NSLog(@"Denied'");
            finishBlock(MQAuthorAccessStatusNotAllow);
            break;
        case EKAuthorizationStatusNotDetermined:
            NSLog(@"not Determined");
            finishBlock(MQAuthorAccessStatusUnknown);
            break;
        default:
            break;
    }
}
/****************************** 设置日历／备忘录权限 ******************************/
+ (void) calendarWithAuthSet:(MQEntityType) entityType finishBlock:(void (^)(BOOL setAuthResult)) finishBlock {
    EKEntityType entityTypeStr = (entityType == MQEntityTypeCalendar) ? EKEntityTypeEvent : EKEntityTypeReminder;
    EKEventStore *store = [[EKEventStore alloc]init];
    [store requestAccessToEntityType:entityTypeStr completion:^(BOOL granted, NSError * _Nullable error) {
        finishBlock(granted);
    }];
}










/****************************** 检查定位权限 ******************************/
+(void) locationWithAuthCheck:(void (^)(MQAuthorAccessStatus authorAccessStatusResult)) finishBlock {
    
    /*
    NSLocationWhenUseUsageDescription 在使用时获取定位信息
    NSLocationAlwaysUsageDescription 一直获取定位信息
     
     CLLocationManager *manager = [[CLLocationManager alloc] init];
     [manager requestAlwaysAuthorization];//一直获取定位信息
     [manager requestWhenInUseAuthorization];//使用的时候获取定位信息
    */
    BOOL isLocation = [CLLocationManager locationServicesEnabled];
    if (!isLocation) {
        NSLog(@"not turn on the location:"); // 不打开位置
        finishBlock(MQAuthorAccessStatusNotAllow);
    }
    CLAuthorizationStatus CLstatus = [CLLocationManager authorizationStatus];
    switch (CLstatus) {
        case kCLAuthorizationStatusAuthorizedAlways:
            finishBlock(MQAuthorAccessStatusAllow);
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            finishBlock(MQAuthorAccessStatusInUse);
            break;
        case kCLAuthorizationStatusDenied:
        case kCLAuthorizationStatusRestricted:
            finishBlock(MQAuthorAccessStatusNotAllow);
            break;
        case kCLAuthorizationStatusNotDetermined:
            finishBlock(MQAuthorAccessStatusUnknown);
            break;
        default:
            break;
    }
}


/****************************** 检查推送权限 ******************************/
+(void) notificationWithAuthCheck:(void (^)(MQNotificationType authorAccessStatusResult)) finishBlock {
    
    UIUserNotificationSettings *settings = [[UIApplication sharedApplication] currentUserNotificationSettings];
    switch (settings.types) {
        case UIUserNotificationTypeNone:
            NSLog(@"None");
            finishBlock(MQNotificationTypeNone);
            break;
        case UIUserNotificationTypeAlert:
            NSLog(@"Alert Notification");
            finishBlock(MQNotificationTypeAlert);
            break;
        case UIUserNotificationTypeBadge:
            NSLog(@"Badge Notification");
            finishBlock(MQNotificationTypeBadge);
            break;
        case UIUserNotificationTypeSound:
            NSLog(@"sound Notification'");
            finishBlock(MQNotificationTypeSound);
            break;
        default:
            break;
    }
}

/****************************** 检查推送权限 ******************************/
+ (void) notificationWithAuthSet:(void (^)(BOOL setAuthResult)) finishBlock {
    UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:setting];
}



@end
