//
//  AppDelegate.m
//  校园助手
//
//  Created by hjl on 16/5/8.
//  Copyright © 2016年 hjl. All rights reserved.
//

#import "HHNavigationController.h"
#import "HHNavigationBar.h"
@interface HHNavigationController ()

@end

@implementation HHNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNavigationBar];
}

- (void)setupNavigationBar{
    HHNavigationBar *bar = [[HHNavigationBar alloc]init];
    [self setValue:bar forKey:@"NavigationBar"];
}


@end
