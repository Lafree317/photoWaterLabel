//
//  ChangeLabelView.h
//  阿雪微商
//
//  Created by huchunyuan on 15/11/15.
//  Copyright © 2015年 LafreeTream. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ChangeLabelViewDelegate <NSObject>

/** 代理方法 是否保存 */
- (void)buttonClickWithBool:(BOOL)Saved;

@end

@interface ChangeLabelView : UIView
@property (assign, nonatomic) id<ChangeLabelViewDelegate>delegate;
@end
