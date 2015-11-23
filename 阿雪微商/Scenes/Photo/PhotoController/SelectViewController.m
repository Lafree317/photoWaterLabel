//
//  SelectViewController.m
//  阿雪微商
//
//  Created by huchunyuan on 15/11/12.
//  Copyright © 2015年 LafreeTream. All rights reserved.
//

#import "SelectViewController.h"
#import "PhotoViewController.h"

@interface SelectViewController ()

@end

@implementation SelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    PhotoViewController *photoVC = [segue destinationViewController];
    photoVC.hidesBottomBarWhenPushed = YES;

}


@end
