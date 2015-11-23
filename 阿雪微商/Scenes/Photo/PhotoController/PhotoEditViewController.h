//
//  PhotoEditViewController.h
//  阿雪微商
//
//  Created by huchunyuan on 15/11/14.
//  Copyright © 2015年 LafreeTream. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoEditViewController : UIViewController
/** 数据数组 */
@property (strong, nonatomic) NSMutableArray *dataArr;
/** 当前下标 */
@property (assign, nonatomic) NSInteger index;
@end
