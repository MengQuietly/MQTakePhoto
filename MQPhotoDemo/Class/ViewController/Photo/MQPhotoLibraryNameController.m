//
//  MQPhotoLibraryNameController.m
//  MQPhotoDemo
//
//  Created by mengmeng on 2017/4/14.
//  Copyright © 2017年 mengmeng. All rights reserved.
//

#import "MQPhotoLibraryNameController.h"
#import "MQPhotoLibraryNameCell.h"
#import "MQAuthorAccessTool.h"
#import "MQPhotosGetTool.h"
#import "MQAlertViewTool.h"
#import "MQPhotoLibraryWithColumnCell.h"

typedef NS_ENUM(NSInteger, MQSeeType) {
    MQSeeTypeLine = 0,
    MQSeeTypeCloumn,
};


#define ItemInterSpacing 5
#define ItemW ((APP_WIDTH - ItemInterSpacing * 3) * 0.5)
#define ItemH (ItemW * 4 / 3)

@interface MQPhotoLibraryNameController () <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *photoLibraryNameList;
@property (nonatomic,strong) UICollectionViewFlowLayout *layout;

@property (nonatomic) MQSeeType seeType;

@end

@implementation MQPhotoLibraryNameController

-(UICollectionViewFlowLayout *)layout{
    if (_layout == nil) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        // 头部大小
        _layout.headerReferenceSize = CGSizeMake(self.view.width, 10);
        // 每个 collectionView 边间距
        _layout.sectionInset = UIEdgeInsetsMake(0, ItemInterSpacing, 0, ItemInterSpacing);

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
        
        [_collectionView registerClass:[MQPhotoLibraryNameCell class] forCellWithReuseIdentifier:@"MQPhotoLibraryNameCellID"];
        [_collectionView registerClass:[MQPhotoLibraryWithColumnCell class] forCellWithReuseIdentifier:@"MQPhotoLibraryWithColumnCellID"];
        
    }
    return _collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"选择相册";
    
    self.photoLibraryNameList = [NSMutableArray arrayWithCapacity:0];
    
    // 功能按键
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"like"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarItemWithChangeClick)];
    
    [self getPhotosLibraryData];
    
    [self.view addSubview:self.collectionView];
}

-(void) rightBarItemWithChangeClick{
    NSLog(@"-------");
    self.seeType = (self.seeType == MQSeeTypeLine)?MQSeeTypeCloumn:MQSeeTypeLine;
    [self.collectionView reloadData];
}

#pragma mark - 获取数据
-(void) getPhotosLibraryData {
    
    __weak typeof(self) weakSelf = self;
    [MQAuthorAccessTool photoLibraryWithAuthCheck:^(MQAuthorAccessStatus authorAccessStatusResult) {
        if (authorAccessStatusResult == MQAuthorAccessStatusAllow) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            strongSelf.photoLibraryNameList = [NSMutableArray arrayWithArray:[MQPhotosGetTool getPhotoLibraryAllWithOriginal:NO]];
            [strongSelf.collectionView reloadData];
        }else if (authorAccessStatusResult == MQAuthorAccessStatusUnknown){
            [MQAuthorAccessTool photoLibraryWithAuthSet:^(BOOL setAuthResult) {
                if (setAuthResult == YES) {
                    __strong typeof(weakSelf) strongSelf = weakSelf;
                    strongSelf.photoLibraryNameList = [NSMutableArray arrayWithArray:[MQPhotosGetTool getPhotoLibraryAllWithOriginal:NO]];
                    [strongSelf.collectionView reloadData];
                }
            }];
        }else if (authorAccessStatusResult == MQAuthorAccessStatusNotAllow){
            [MQAlertViewTool showAlertWithMessage:@"请进入 设置 -> 隐私 -> 相册 开启权限" dismissAfterDelay:1.0];
        }
    }];
}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.seeType == MQSeeTypeCloumn) {
        self.layout.minimumLineSpacing = ItemInterSpacing;
        self.layout.minimumInteritemSpacing = ItemInterSpacing;
        return CGSizeMake(ItemW, ItemH);
    }
    self.layout.minimumLineSpacing = 0;
    self.layout.minimumInteritemSpacing = 0;
    return CGSizeMake(self.view.width, 80);
}

#pragma mark - UICollectionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.photoLibraryNameList.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.seeType == MQSeeTypeCloumn) {
        MQPhotoLibraryWithColumnCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MQPhotoLibraryWithColumnCellID" forIndexPath:indexPath];
        if (self.photoLibraryNameList.count > 0) {
            cell.photosAlbumModel = self.photoLibraryNameList[indexPath.item];
        }
        
        return cell;
    }
    
    MQPhotoLibraryNameCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MQPhotoLibraryNameCellID" forIndexPath:indexPath];
    if (self.photoLibraryNameList.count > 0) {
        cell.photosAlbumModel = self.photoLibraryNameList[indexPath.item];
    }
    return cell;
}

//// 头部显示内容
//-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
//    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderViewID" forIndexPath:indexPath];
//    return  headerView;
//}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"你选择了：%ld",indexPath.item);
}

@end
