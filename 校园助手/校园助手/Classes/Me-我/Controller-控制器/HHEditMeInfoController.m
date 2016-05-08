//
//  HHEditMeInfoController.m
//  图书馆
//
//  Created by hjl on 16/4/29.
//  Copyright © 2016年 hjl. All rights reserved.
//

#import "HHEditMeInfoController.h"
@interface HHEditMeInfoController ()
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UITextField *sexText;
@property (weak, nonatomic) IBOutlet UITextField *phoneText;
@property (weak, nonatomic) IBOutlet UITextField *emailText;
- (IBAction)sureClick:(id)sender;

@end

@implementation HHEditMeInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavBar];
    BmobUser *bUser = [BmobUser getCurrentUser];
    self.nameText.text = [bUser objectForKey:@"name"];
    self.sexText.text = [bUser objectForKey:@"sex"];
    self.phoneText.text = [bUser objectForKey:@"phone"];
    self.emailText.text = [bUser objectForKey:@"email"];
}

- (void)setupNavBar{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(backClick)];
}

- (void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)sureClick:(id)sender {
    // 获取缓存账户, 修改数据
    BmobUser *bbUser = [BmobUser getCurrentUser];
    [bbUser setObject:self.nameText.text forKey:@"name"];
    [bbUser setObject:self.sexText.text forKey:@"sex"];
    [bbUser setObject:self.phoneText.text forKey:@"phone"];
    [bbUser setObject:self.emailText.text forKey:@"email"];
    //[bUser updateInBackground];
    [bbUser updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            [SVProgressHUD showSuccessWithStatus:@"保存成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
                // 回调
                [self backClick];
            });
         } else if (error){
            //HHLog(@"%@", error);
            [SVProgressHUD showSuccessWithStatus:@"邮箱地址无效, 请重新输入"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
        } else {
            HHLog(@"失败");
        }
    }];
}
@end
