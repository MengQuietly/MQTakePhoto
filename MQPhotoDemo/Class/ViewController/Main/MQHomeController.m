//
//  MQHomeController.m
//  MQPhotoDemo
//
//  Created by mengmeng on 2017/4/7.
//  Copyright © 2017年 mengmeng. All rights reserved.
//

#import "MQHomeController.h"
#import "MQTakePhotoController.h"
#import "MQPhotoController.h"

@interface MQHomeController ()

@end

@implementation MQHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"首页";

    UIButton *takeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    takeBtn.frame = CGRectMake(10, 10, 100, 44);
    [takeBtn setTitle:@"take" forState:UIControlStateNormal];
    [takeBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    takeBtn.backgroundColor = [UIColor lightGrayColor];
    [takeBtn addTarget:self action:@selector(takeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:takeBtn];
    
    UIButton *photoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    photoBtn.frame = CGRectMake(10, CGRectGetMaxY(takeBtn.frame)+15, 100, 44);
    [photoBtn setTitle:@"photo" forState:UIControlStateNormal];
    [photoBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    photoBtn.backgroundColor = [UIColor lightGrayColor];
    [photoBtn addTarget:self action:@selector(photoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:photoBtn];
}

-(void) takeBtnClick{
    MQTakePhotoController *takeVC = [[MQTakePhotoController alloc] init];
    [self.navigationController pushViewController:takeVC animated:YES];
}


-(void) photoBtnClick{
    MQPhotoController *photoVC = [[MQPhotoController alloc] init];
    [self.navigationController pushViewController:photoVC animated:YES];
}


@end
