//
//  HHPublishController.m
//  sinaWeibo
//
//  Created by hjl on 16/3/26.
//  Copyright © 2016年 hjl. All rights reserved.
//

#import "HHPublishController.h"
//#import <AFNetworking.h>
//#import <SVProgressHUD.h>
//#import "HHLoginController.h"
//#import "HHNavigationController.h"

@interface HHPublishController () <UITextViewDelegate>
/**
 *  输入框
 */
@property (nonatomic, weak)  UITextView *inputView;

@end

@implementation HHPublishController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationItem];

    self.view.backgroundColor = HHBackgroundColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupInputView];
}


- (void)setupNavigationItem{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(close)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(publish)];
    self.navigationItem.title = @"发布内容";
}

- (void)setupInputView{
    UIView *textView = [[UIView alloc] init];
    textView.frame = CGRectMake(0, 64, HHWidth, HHHeight - 64);
    textView.backgroundColor = [UIColor whiteColor];

    UITextView *inputView = [[UITextView alloc] init];
    inputView.frame = CGRectMake(10, 10, HHWidth - 20, HHHeight - 84);
    inputView.font = [UIFont systemFontOfSize:17];
    inputView.delegate = self;
    // UITextView默认是不可以滚动的,需要设置alwaysBounceVertical属性才可以竖值滚动
    inputView.alwaysBounceVertical = YES;
    self.inputView = inputView;
    [textView addSubview:inputView];
    [self.view addSubview:textView];
}

- (void)close{
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 发送网络请求
- (void)publish {
}

@end
