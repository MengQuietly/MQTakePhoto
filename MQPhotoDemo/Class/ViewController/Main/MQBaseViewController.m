//
//  MQBaseViewController.m
//  MQPhotoDemo
//
//  Created by mengmeng on 2017/4/8.
//  Copyright © 2017年 mengmeng. All rights reserved.
//

#import "MQBaseViewController.h"

@interface MQBaseViewController ()

@end

@implementation MQBaseViewController

-(void) setupNavItem{
    // 功能按键
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarItemWithBackClick)];
    
//    // 自定义功能按键
//    // 调整间距
//    UIBarButtonItem * spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//    spaceItem.width = -5.0;
//    // 返回
//    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeSystem];
//    backBtn.frame = CGRectMake(0, 0, 22, 22);
//    [backBtn setImage:[[UIImage imageNamed:@"backIcon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
//    [backBtn addTarget:self action:@selector(backtoself) forControlEvents:UIControlEventTouchUpInside];
//    // 关闭
//    UIButton * closeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
//    closeBtn.frame = CGRectMake(0, 0, 44, 22);
//    [closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
//    closeBtn.titleLabel.font = [UIFont systemFontOfSize:16];
//    [closeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [closeBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIBarButtonItem * backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
//    UIBarButtonItem * closeItem = [[UIBarButtonItem alloc] initWithCustomView:closeBtn];
//    self.navigationItem.leftBarButtonItems = @[backItem,closeItem];
}

-(void) leftBarItemWithBackClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupNavItem];
}

@end
