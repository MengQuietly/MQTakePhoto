//
//  MQPictureChooseController.m
//  MQPhotoDemo
//
//  Created by mengmeng on 2017/4/17.
//  Copyright © 2017年 mengmeng. All rights reserved.
//

#import "MQPictureChooseController.h"
#import "MQPictureChooseCell.h"

#define ItemInterSpacing 5
#define ItemW ((APP_WIDTH - ItemInterSpacing * 5) / 4)

@interface MQPictureChooseController () <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UICollectionViewFlowLayout *layout;

@end

@implementation MQPictureChooseController

-(UICollectionViewFlowLayout *)layout{
    if (_layout == nil) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        // 头部大小
        _layout.headerReferenceSize = CGSizeMake(self.view.width, 10);
        // 每个 collectionView 边间距
        _layout.sectionInset = UIEdgeInsetsMake(ItemInterSpacing, ItemInterSpacing, ItemInterSpacing, ItemInterSpacing);
        _layout.itemSize = CGSizeMake(ItemW, ItemW);
        _layout.minimumLineSpacing = ItemInterSpacing;
        _layout.minimumInteritemSpacing = ItemInterSpacing;
    }
    return _layout;
}

-(UICollectionView *)collectionView{
    if (_collectionView == nil) {
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate= self;
        _collectionView.dataSource = self;
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        [_collectionView registerClass:[MQPictureChooseCell class] forCellWithReuseIdentifier:@"MQPictureChooseCellID"];
        
    }
    return _collectionView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"选择照片";
    [self.view addSubview:self.collectionView];
    
}

#pragma mark - UICollectionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.photosList.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MQPictureChooseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MQPictureChooseCellID" forIndexPath:indexPath];
    if (self.photosList.count > 0) {
        cell.pictureModel = self.photosList[indexPath.item];
    }
    return cell;
}


@end
