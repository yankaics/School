//
//  HHHomeController.m
//  校园助手
//
//  Created by hjl on 16/5/8.
//  Copyright © 2016年 hjl. All rights reserved.
//

#import "HHHomeController.h"
#import "HHFirstScrollView.h"
@interface HHHomeController ()

@end

@implementation HHHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = HHBackgroundColor;
    
    //让视图内的scrollViewAdjusts
    self.automaticallyAdjustsScrollViewInsets = NO;
    HHFirstScrollView *firstView = [[HHFirstScrollView alloc]initWithFrame:CGRectMake(0, 0, HHWidth, scrollHeight)];
    [self.view addSubview:firstView];
    
}



@end
