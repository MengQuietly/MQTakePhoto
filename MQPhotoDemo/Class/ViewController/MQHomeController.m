//
//  MQHomeController.m
//  MQPhotoDemo
//
//  Created by mengmeng on 2017/4/7.
//  Copyright © 2017年 mengmeng. All rights reserved.
//

#import "MQHomeController.h"


@interface MQHomeController ()

@end

@implementation MQHomeController

-(void) setupNav{
    // 功能按键
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"backIcon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backtoself)];
    
    // 自定义功能按键
    // 调整间距
    UIBarButtonItem * spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = -5.0;
    // 返回
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    backBtn.frame = CGRectMake(0, 0, 22, 22);
    [backBtn setImage:[[UIImage imageNamed:@"backIcon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backtoself) forControlEvents:UIControlEventTouchUpInside];
    // 关闭
    UIButton * closeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    closeBtn.frame = CGRectMake(0, 0, 44, 22);
    [closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
    closeBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [closeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    UIBarButtonItem * closeItem = [[UIBarButtonItem alloc] initWithCustomView:closeBtn];
    self.navigationItem.leftBarButtonItems = @[backItem,closeItem];
}

-(void)backtoself{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"--h--%lf",APP_HEIGHT);
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSLog(@"----%lf",self.view.height);
    self.title = @"首页";

    UIButton *takeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    takeBtn.frame = CGRectMake(10, 10, 100, 44);
    [takeBtn setTitle:@"take" forState:UIControlStateNormal];
    [takeBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    takeBtn.backgroundColor = [UIColor lightGrayColor];
    [takeBtn addTarget:self action:@selector(takeBtnClick) forControlEvents:UIControlEventTouchUpOutside];
    [self.view addSubview:takeBtn];
    
    UIButton *photoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    photoBtn.frame = CGRectMake(10, CGRectGetMaxY(takeBtn.frame)+15, 100, 44);
    [photoBtn setTitle:@"photo" forState:UIControlStateNormal];
    [photoBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    photoBtn.backgroundColor = [UIColor lightGrayColor];
    [photoBtn addTarget:self action:@selector(photoBtnClick) forControlEvents:UIControlEventTouchUpOutside];
    [self.view addSubview:photoBtn];
}

-(void) takeBtnClick{
    
}


-(void) photoBtnClick{
    
}


@end
