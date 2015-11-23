//
//  WaterLabel.h
//  阿雪微商
//
//  Created by huchunyuan on 15/11/15.
//  Copyright © 2015年 LafreeTream. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol WaterLabelDelegate <NSObject>

- (void)selectAction;

@end

@interface WaterLabel : UILabel
// 代理
@property (assign, nonatomic)id<WaterLabelDelegate>delegate;

- (void)changeLabelWithLabel:(UILabel *)label;


@end
