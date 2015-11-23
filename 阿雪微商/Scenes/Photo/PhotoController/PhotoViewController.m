//
//  PhotoViewController.m
//  阿雪微商
//
//  Created by huchunyuan on 15/11/12.
//  Copyright © 2015年 LafreeTream. All rights reserved.
//

#import "PhotoViewController.h"
#import "PhotoCell.h"
#import "MLSelectPhotoPickerViewController.h"
#import "MLSelectPhotoAssets.h"
#import "PhotoEditViewController.h"

@interface PhotoViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
/** 展示图片 */
@property (strong, nonatomic) UICollectionView *collection;
@property (strong, nonatomic) UICollectionViewFlowLayout *layout;

/** 存储照片数组 */
@property (strong, nonatomic) NSMutableArray *assets;
@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 搭建容器视图
    [self layoutSelfCollection];
    /** 选择图片 */
    [self selectImageView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    
}
#pragma mark - 搭建容器视图
/** 搭建容器视图 */
- (void)layoutSelfCollection{
    /** 关闭视图控制器的偏移量 */
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 初始化
    _layout = [[UICollectionViewFlowLayout alloc] init];
    _collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64) collectionViewLayout:self.layout];
    [self.view addSubview:_collection];
    _collection.delegate = self;
    _collection.dataSource = self;
    // 注册cell
    [_collection registerNib:[UINib nibWithNibName:@"PhotoCell" bundle:nil] forCellWithReuseIdentifier:kPhotoCell];
}
- (void)selectImageView{
    // 创建控制器
    MLSelectPhotoPickerViewController *pickerVC = [[MLSelectPhotoPickerViewController alloc] init];
    // 默认显示相册里面的内容SavePhotos
    pickerVC.maxCount = 10;
    pickerVC.status = PickerViewShowStatusCameraRoll;
    [pickerVC showPickerVc:self];
    __weak typeof(self) weakSelf = self;
    pickerVC.callBack = ^(NSArray *assects){
        [weakSelf.assets addObjectsFromArray:assects];
        [weakSelf.collection reloadData];
    };
}
#pragma mark - CollectionDelegate&dataSource
// 分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

// item数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _assets.count;
}

// 设置cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    PhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kPhotoCell forIndexPath:indexPath];
    // 判断类型来获取image
    MLSelectPhotoAssets *asset = self.assets[indexPath.row];
    cell.photoImage.image = asset.thumbImage;
    return cell;
}

// item大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return CGSizeMake((kScreenWidth-40)/3, (kScreenWidth-40)/3);
}

// 设置item左右间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

// collectionView边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - item点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    PhotoEditViewController *EditVC = [self.storyboard instantiateViewControllerWithIdentifier:@"123"];
    EditVC.dataArr = self.assets;
    EditVC.index = indexPath.row;
    [self showViewController:EditVC sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    PhotoEditViewController *EditVC = [segue destinationViewController];
    EditVC.view = EditVC.view;
    
}

/** 数组懒加载 */
- (NSMutableArray *)assets{
    if (!_assets) {
        _assets = [NSMutableArray array];
    }
    return _assets;
}
@end
