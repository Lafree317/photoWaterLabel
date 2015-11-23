//
//  PhotoEditViewController.m
//  阿雪微商
//
//  Created by huchunyuan on 15/11/14.
//  Copyright © 2015年 LafreeTream. All rights reserved.
//

#import "PhotoEditViewController.h"
#import "MLSelectPhotoAssets.h"
#import "WaterLabel.h"
#import "ChangeLabelView.h"
#import "MBProgressHUD+MJ.h"

@interface PhotoEditViewController ()<WaterLabelDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet ChangeLabelView *changeLabelView;
@property (strong, nonatomic) WaterLabel * waterLabel;


@property (strong, nonatomic) UIImageView *imageView;
@property (assign, nonatomic) CGFloat change;
/** 编辑界面 */


@property (weak, nonatomic) IBOutlet UILabel *ChangeLabel;
@property (weak, nonatomic) IBOutlet UITextField *changeField;
@property (weak, nonatomic) IBOutlet UISlider *redSlider;
@property (weak, nonatomic) IBOutlet UISlider *yelloSlider;
@property (weak, nonatomic) IBOutlet UISlider *blueSlider;
@property (weak, nonatomic) IBOutlet UISlider *fontSizeSlider;


@end

@implementation PhotoEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutEveryThing];
  
    self.changeLabelView.hidden = YES;

    
    [self.view addSubview:self.waterLabel];
    
}
- (WaterLabel *)waterLabel{
    if (!_waterLabel) {
        _waterLabel = [[WaterLabel alloc] initWithFrame:CGRectMake(100, 100, 180, 24)];
        

        
        self.waterLabel.delegate = self;
        _waterLabel.center = self.view.center;
       
    }
    return _waterLabel;
}
- (void)layoutEveryThing{
    
    self.changeField.delegate = self;
    _imageView = [[UIImageView alloc] init];
    [self.view addSubview:_imageView];
    _change = 1;
    _imageView.contentMode = UIViewContentModeScaleToFill;
    [self changeImage];
}

- (CGSize)backSizeWithImage:(UIImage *)image{
    CGFloat imageH = image.size.height;
    CGFloat imageW = image.size.width;
    while (imageW*_change > (self.view.frame.size.width-20) || imageH*_change > (self.view.frame.size.height - 100)){
        _change = _change - 0.05;
    }
    return CGSizeMake(imageW*_change, imageH*_change);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)changeImage{
    _change = 1;
    MLSelectPhotoAssets *asset = self.dataArr[_index];
    CGSize imagesize = [self backSizeWithImage:asset.originImage];
    _imageView.image = asset.originImage;
    _imageView.frame = CGRectMake(0, 0,imagesize.width , imagesize.height);
    _imageView.center = self.view.center;
}

#pragma mark - button点击事件
- (IBAction)lastOne:(id)sender {
    _index--;
    if (_index < 0) {
        _index = _dataArr.count - 1;
    }
    [self changeImage];
}
- (IBAction)nextOne:(id)sender {
    _index++;
    if (_index > _dataArr.count - 1) {
        _index = 0;
    }
    [self changeImage];
}
- (IBAction)saveAction:(id)sender {
    CGFloat waterX = self.waterLabel.frame.origin.x - self.imageView.frame.origin.x;
    CGFloat waterY = self.waterLabel.frame.origin.y - self.imageView.frame.origin.y;
    
    CGRect rect = CGRectMake(waterX * (1/_change), waterY*(1/_change), _waterLabel.frame.size.width*(1/_change), _waterLabel.frame.size.height*(1/_change));
    
    self.imageView.image = [self addImage:self.imageView.image maskRect:rect];
    
    
    // 保存图片
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, nil, NULL);
    [MBProgressHUD showSuccess:@"保存成功"];
    
    [self.dataArr removeObjectAtIndex:_index];
    if (_dataArr.count == 0) {
        [MBProgressHUD showSuccess:@"已处理完所有图片"];
        [self.navigationController popToRootViewControllerAnimated:YES];
        return;
    }
    
    [self nextOne:nil];
    
}

- (UIImage *)addImage:(UIImage *)useImage
             maskRect:(CGRect)rect{
    
    UIGraphicsBeginImageContext(useImage.size);
    [useImage drawInRect:CGRectMake(0, 0, useImage.size.width, useImage.size.height)];
    // 字体字典
    NSDictionary *attr = @{
                           NSFontAttributeName :[UIFont boldSystemFontOfSize:_fontSizeSlider.value *(1/_change)],
                           NSForegroundColorAttributeName : _waterLabel.textColor
                           };
    // 写入
    [_waterLabel.text drawInRect:rect withAttributes:attr];

    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}
// 截屏
-(UIImage *)saveImage:(UIView *)view{
    CGRect mainRect = [[UIScreen mainScreen] bounds];
    UIGraphicsBeginImageContext(CGSizeMake(375,667));
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextFillRect(context, mainRect);
    [view.layer renderInContext:context];
    
    
    [_waterLabel.layer renderInContext:context];
    
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndPDFContext();
    return newImage;

}

- (IBAction)addWather:(id)sender {
    _waterLabel.hidden = NO;
    _waterLabel.center = self.view.center;
    
}
- (void)selectAction{
    
    _changeLabelView.hidden = NO;
    [self.view bringSubviewToFront:_changeLabelView];
    _changeLabelView.alpha = 1;
}



#pragma mark - 编辑页面
- (IBAction)changeButton:(id)sender {
    
    _waterLabel.text = _ChangeLabel.text;
    _waterLabel.font = _ChangeLabel.font;
    _waterLabel.textColor = _ChangeLabel.textColor;
    
    _changeLabelView.hidden = YES;
}
- (IBAction)labelFont:(UISlider *)sender {
    _ChangeLabel.font = [UIFont systemFontOfSize:sender.value];
}
/** 改变颜色 */
- (IBAction)red:(UISlider *)sender {
    self.ChangeLabel.textColor = [UIColor colorWithRed:_redSlider.value green:_yelloSlider.value blue:_blueSlider.value alpha:1];
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    self.ChangeLabel.text = textField.text;
    
    CGSize size = CGSizeMake(100,100);
    self.ChangeLabel.numberOfLines = 0;
    UIFont *font = [UIFont fontWithName:@"Arial" size:20];
    CGSize labelSize = [self.ChangeLabel.text sizeWithFont:font constrainedToSize:size];
    CGPoint labelCenter = self.ChangeLabel.center;
    [self.ChangeLabel setFrame:CGRectMake(0, 0, labelSize.width, labelSize.height)];
    self.ChangeLabel.center = labelCenter;
    
    
    
    [self.changeField resignFirstResponder];
    
    return YES;
}






@end
