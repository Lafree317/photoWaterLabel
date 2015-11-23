//
//  ShareViewController.m
//  阿雪微商
//
//  Created by huchunyuan on 15/10/31.
//  Copyright © 2015年 LafreeTream. All rights reserved.
//

#import "ShareViewController.h"
#import "ShareImageCell.h"


@interface ShareViewController ()<UITextViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *placeholderLabel;
@property (weak, nonatomic) IBOutlet UILabel *collectionPlacehoderLabel;

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *imageArr;
@end

@implementation ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 搭建视图
    [self layoutSelfView];
}
/** 搭建视图 */
- (void)layoutSelfView{
    /** 关闭视图控制器的偏移量 */
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.textView.delegate = self;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [_textView layoutIfNeeded];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(_textView.frame) , kScreenWidth, 100) collectionViewLayout:layout];

    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
//    [self.view addSubview:self.collectionView];
    // 注册cell
    [_collectionView registerNib:[UINib nibWithNibName:@"ShareImageCell" bundle:nil] forCellWithReuseIdentifier:kShareCell];
    
}

#pragma mark - UICollectionViewDataSource & UICollectionViewDelegate
// 分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

// item数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3;
}

// 设置cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ShareImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kShareCell forIndexPath:indexPath];
    
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
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if (![text isEqualToString:@""])
    
    {
    _placeholderLabel.hidden = YES;
    }
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1)
    {
        _placeholderLabel.hidden = NO;

    }
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSMutableArray *)imageArr{
    if (!_imageArr) {
        _imageArr = [NSMutableArray new];
    }
    return _imageArr;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
