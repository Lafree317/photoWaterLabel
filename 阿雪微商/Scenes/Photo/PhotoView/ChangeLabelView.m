//
//  ChangeLabelView.m
//  阿雪微商
//
//  Created by huchunyuan on 15/11/15.
//  Copyright © 2015年 LafreeTream. All rights reserved.
//

#import "ChangeLabelView.h"

@interface ChangeLabelView ()
@property (strong, nonatomic) IBOutlet UIView *view;


@end

@implementation ChangeLabelView


- (void)awakeFromNib{

}

- (void)setup{
    [[NSBundle mainBundle] loadNibNamed:@"ChangeLabelView" owner:self options:nil];
    self.view.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self addSubview:self.view];
}



#pragma mark - buttonAction

- (IBAction)cancaleAction:(UIButton *)sender {
    NSLog(@"%@",sender.titleLabel.text);
}


@end
