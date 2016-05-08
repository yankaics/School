//
//  HHLoginController.m
//  图书馆
//
//  Created by hjl on 16/4/24.
//  Copyright © 2016年 hjl. All rights reserved.
//

#import "HHLoginController.h"
#import <AFNetworking.h>
#import "HHTabBarController.h"
@interface HHLoginController ()
@property (weak, nonatomic) IBOutlet UITextField *userTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UITextField *userRegisterTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdRegisterTextField;
@property (weak, nonatomic) IBOutlet UIView *registerView;
@property (weak, nonatomic) IBOutlet UIView *loginView;
- (IBAction)loginClick:(id)sender;
- (IBAction)nowRegisterClick:(id)sender;
- (IBAction)forgetPwdClick:(id)sender;
- (IBAction)registerClick:(id)sender;
- (IBAction)backLoginClick:(id)sender;
- (IBAction)noRegisterClick:(id)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewLeft;
- (IBAction)weixinClick:(id)sender;
- (IBAction)sinaClick:(id)sender;
- (IBAction)tenxunClick:(id)sender;

@end

@implementation HHLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavItem];
    
    //
}

- (void)setupNavItem{
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(noRegisterClick:)];
    self.navigationItem.leftBarButtonItem = barItem;
}

// 用户登录, 并判断能否登录成功
- (IBAction)loginClick:(id)sender {
    [BmobUser loginWithUsernameInBackground:self.userTextField.text password:self.pwdTextField.text block:^(BmobUser *user, NSError *error) {
        if (user) {
            [SVProgressHUD showSuccessWithStatus:@"登录成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
                [self back];
            });
        }
        if (error) {
            [SVProgressHUD showErrorWithStatus:@"用户名或者密码错误"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
        }
    }];
}
- (void) back{
    [self dismissViewControllerAnimated:YES completion:nil];
    if (_block) {
        _block();
    }
}

// 注册
- (IBAction)registerClick:(id)sender {
    NSString *iconUrl = @"http://bmob-cdn-871.b0.upaiyun.com/2016/04/30/02547f9134304c6c99dcdb9b124436b1.png";
    
    BmobUser *bUser = [[BmobUser alloc] init];
    [bUser setUsername:self.userRegisterTextField.text];
    [bUser setPassword:self.pwdRegisterTextField.text];
    [bUser signUpInBackgroundWithBlock:^ (BOOL isSuccessful, NSError *error){
        if (isSuccessful){
            [bUser setObject:iconUrl forKey:@"iconUrl"];
            [bUser updateInBackground];
            
            [SVProgressHUD showSuccessWithStatus:@"注册成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
                //自动登录
                [BmobUser loginWithUsernameInBackground:self.userRegisterTextField.text password:self.pwdRegisterTextField.text];
                //返回
                [self back];
            });
        } else {
            [SVProgressHUD showSuccessWithStatus:@"注册失败,用户名已存在"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
        }
    }];
}
// 跳转到注册
- (IBAction)nowRegisterClick:(id)sender {
    self.loginViewLeft.constant = -self.view.width;
    [self.view layoutIfNeeded];
}
// 跳转到登录
- (IBAction)backLoginClick:(id)sender {
    self.loginViewLeft.constant = 0;
    [self.view layoutIfNeeded];
}
// 忘记密码
- (IBAction)forgetPwdClick:(id)sender {
    HHLog(@"忘记密码");
}
// 暂不注册
- (IBAction)noRegisterClick:(id)sender {
    HHTabBarController *tb = [[HHTabBarController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tb;
}

- (IBAction)weixinClick:(id)sender {
}

- (IBAction)sinaClick:(id)sender {
}

- (IBAction)tenxunClick:(id)sender {
}
@end
