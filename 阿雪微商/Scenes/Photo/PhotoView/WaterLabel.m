//
//  WaterLabel.m
//  阿雪微商
//
//  Created by huchunyuan on 15/11/15.
//  Copyright © 2015年 LafreeTream. All rights reserved.
//

#import "WaterLabel.h"

@interface WaterLabel ()
@property (assign, nonatomic) BOOL Moved;
@property (assign, nonatomic) CGPoint beginPoint;
@end

@implementation WaterLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self changeText];
    }
    return self;
}
- (void)changeText{
    self.text = @"WECHAT:CloverY01";
    self.userInteractionEnabled = YES;
    self.textColor = [UIColor whiteColor];
    self.font = [UIFont systemFontOfSize:20];
//    self.shadowColor = [UIColor lightGrayColor];
//    self.shadowOffset = CGSizeMake(1, 1);
    
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    _Moved = NO;// 没移动过
    // 创建触摸对象
    UITouch *touch = [touches anyObject];
    _beginPoint = [touch locationInView:self];

}

/** 移动方法 */
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
     _Moved = YES;// 移动过了
    UITouch *touch = [touches anyObject];
    CGPoint currentPosition = [touch locationInView:self];
    // 偏移量
    float offsetX = currentPosition.x - _beginPoint.x;
    float offsetY = currentPosition.y - _beginPoint.y;
    // 移动后的中心坐标
    self.center = CGPointMake(self.center.x + offsetX,self.center.y+offsetY );
    
    
}
/** 触摸结束 */
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    // 如果是点击时间触发代理
    if (!_Moved) {
        /** 通知代理执行方法 */
        [_delegate selectAction];
        NSLog(@"点击");
    }
    //不加此句话，UIButton将一直处于按下状态
    [super touchesEnded:touches withEvent:event];
    
}

/** 对象方法 */
- (void)changeLabelWithLabel:(UILabel *)label{
    self.text = label.text;

}

@end
