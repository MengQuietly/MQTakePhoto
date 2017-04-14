//
//  MQAuthorAccessTool.h
//  MQPhotoDemo
//
//  Created by mengmeng on 2017/4/10.
//  Copyright © 2017年 mengmeng. All rights reserved.
//  是否有权限

#import <Foundation/Foundation.h>

// 权限认证状态
typedef NS_ENUM(NSInteger, MQAuthorAccessStatus) {
    MQAuthorAccessStatusAllow = 0, // 认证状态
    MQAuthorAccessStatusUnknown, // 未作出选择，需提示用户选择
    MQAuthorAccessStatusNotAllow, // 不允许访问/已拒绝此访问,需提示打开访问开关(Denied)
    MQAuthorAccessStatusInUse, // 使用时授权（定位）
};

// AVCaptureDevice 的MediaType
typedef NS_ENUM(NSInteger, MQMediaType) {
    MQMediaTypeVideo = 0, // 相机 权限
    MQMediaTypeAudio, // 麦克风 权限
};

// 推送
typedef NS_OPTIONS(NSUInteger, MQNotificationType) {
    MQNotificationTypeNone    = 0,      // the application may not present any UI upon a notification being received
    MQNotificationTypeBadge   = 1 << 0, // the application may badge its icon upon a notification being received
    MQNotificationTypeSound   = 1 << 1, // the application may play a sound upon a notification being received
    MQNotificationTypeAlert   = 1 << 2, // the application may display an alert upon a notification being received
};

// 日历／备忘录 的 EntityType
typedef NS_ENUM(NSInteger, MQEntityType) {
    MQEntityTypeCalendar = 0, // 日历 权限
    MQEntityTypeReminder, // 备忘录 权限
};


@interface MQAuthorAccessTool : NSObject

/****************************** 打开设置界面 ******************************/
+(void) openSystemSetting ;

/****************************** 检查联网权限(APP启动) ******************************/
+(void) networkingWithNetCheck:(void (^)(MQAuthorAccessStatus authorAccessStatusResult)) finishBlock ;
/****************************** 检查联网功能(APP启动) ******************************/
+(void) networkingWithAuthCheck:(void (^)(MQAuthorAccessStatus authorAccessStatusResult)) finishBlock ;


/****************************** 检查相册权限 ******************************/
+(void) photoLibraryWithAuthCheck:(void (^)(MQAuthorAccessStatus authorAccessStatusResult)) finishBlock ;
/****************************** 设置相册权限 ******************************/
+ (void)photoLibraryWithAuthSet:(void (^)(BOOL setAuthResult)) finishBlock ;


/****************************** 检查相机/麦克风权限 ******************************/
+(void) captureWithAuthCheck:(MQMediaType) mediaType finishBlock:(void (^)(MQAuthorAccessStatus authorAccessStatusResult)) finishBlock ;
/****************************** 设置相机/麦克风权限 ******************************/
+ (void)captureWithAuthSet:(MQMediaType) mediaType finishBlock:(void (^)(BOOL setAuthResult)) finishBlock ;

/****************************** 检查通讯录权限 ******************************/
+(void) contactWithAuthCheck:(void (^)(MQAuthorAccessStatus authorAccessStatusResult)) finishBlock ;
/****************************** 设置通讯录权限 ******************************/
+ (void)contactWithAuthSet:(void (^)(BOOL setAuthResult)) finishBlock ;

/****************************** 检查日历／备忘录权限 ******************************/
+(void) calendarWithAuthCheck:(MQEntityType) entityType finishBlock:(void (^)(MQAuthorAccessStatus authorAccessStatusResult)) finishBlock ;
/****************************** 设置日历／备忘录权限 ******************************/
+ (void) calendarWithAuthSet:(MQEntityType) entityType finishBlock:(void (^)(BOOL setAuthResult)) finishBlock ;





/****************************** 检查定位权限 ******************************/
+(void) locationWithAuthCheck:(void (^)(MQAuthorAccessStatus authorAccessStatusResult)) finishBlock ;

/****************************** 检查推送权限 ******************************/
+(void) notificationWithAuthCheck:(void (^)(MQNotificationType authorAccessStatusResult)) finishBlock ;
/****************************** 设置推送权限 ******************************/
+ (void) notificationWithAuthSet:(void (^)(BOOL setAuthResult)) finishBlock ;

@end
