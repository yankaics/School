//
//  HHPublishController.m
//  sinaWeibo
//
//  Created by hjl on 16/3/26.
//  Copyright © 2016年 hjl. All rights reserved.
//

#import "HHPublishController.h"
#import "HHPublishBar.h"

#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import "HHLoginController.h"
#import "HHNavigationController.h"

@interface HHPublishController () <UITextViewDelegate>
/**
 *  输入框
 */
@property (nonatomic, weak)  UITextView *inputView;

/** <#name#> */
@property (nonatomic, strong) HHPublishBar *bar;


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
    textView.frame = CGRectMake(0, 64, HHWidth, 200);
    textView.backgroundColor = [UIColor whiteColor];

    UITextView *inputView = [[UITextView alloc] init];
    inputView.frame = CGRectMake(10, 10, HHWidth - 20, 180);
    inputView.font = [UIFont systemFontOfSize:17];
    inputView.delegate = self;
    // UITextView默认是不可以滚动的,需要设置alwaysBounceVertical属性才可以竖值滚动
    inputView.alwaysBounceVertical = YES;
    self.inputView = inputView;
    [textView addSubview:inputView];
    [self.view addSubview:textView];
    
    HHPublishBar *bar = [[[NSBundle mainBundle] loadNibNamed:@"HHPublishBar" owner:nil options:nil]lastObject];
    bar.frame = CGRectMake(0, 201 + 64, HHWidth, 40);
    self.bar = bar;
    [self.view addSubview:bar];
}

- (void)close{
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 发送网络请求
- (void)publish {
    HHLog(@"%@", self.inputView.text);
    // 获取当前用户的  name, username, iconUrl,
    // 上传至bmob
    BmobUser *bUser = [BmobUser getCurrentUser];
    if (bUser) {
        //在tweets创建一条数据，如果当前没tweets表，则会创建tweets表
        BmobObject  *tweet = [BmobObject objectWithClassName:@"tweets"];
        // 设置数据,  ( 昵称, username(id), 头像, 文本)
        [tweet setObject:[bUser objectForKey:@"name"] forKey:@"name"];
        [tweet setObject:[bUser objectForKey:@"username"] forKey:@"username"];
        [tweet setObject:[bUser objectForKey:@"iconUrl"] forKey:@"iconUrl"];
        [tweet setObject:self.inputView.text forKey:@"text"];
        
        //self.bar.isSelectButton = @"0";
        
        if (self.bar.isSelectButton == nil) {
            self.bar.isSelectButton = @"0";
        }
        HHLog(@"!!!!!%@", self.bar.isSelectButton);
        [tweet setObject:self.bar.isSelectButton forKey:@"noName"];
        //[tweet setObject:self.tail forKey:@"tail"];
        //异步保存到服务器
        [tweet saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
            if (isSuccessful) {
                //创建成功后会返回objectId，updatedAt，createdAt等信息
                //创建对象成功，打印对象值
                //HHLog(@"%@",tweet);
                
                // 数据关联, 即发送人 和 tweet进行关联
                //获取要添加关联关系的用户
                NSString *bUserObjectId = [NSString stringWithFormat:@"%@", bUser.objectId];
                BmobObject *user = [BmobObject objectWithoutDatatWithClassName:@"_User" objectId:bUserObjectId];
                
                //新建relation对象
                BmobRelation *relation = [[BmobRelation alloc] init];
                // 把书本信息添加到 relation中
                [relation addObject:tweet];
                
                //添加关联关系到likes列中
                [user addRelation:relation forKey:@"tweets"];
                //异步更新obj的数据
                [user updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                    if (isSuccessful) {
                        NSLog(@"successful");
                    }else{
                        NSLog(@"error %@",[error description]);
                    }
                }];
                
                // 关闭
                [self close];
            } else if (error){
                //发生错误后的动作
                NSLog(@"%@",error);
            } else {
                NSLog(@"Unknow error");
            }
        }];
        
    }else{
        [SVProgressHUD showErrorWithStatus:@"您还未登录,前往登录!"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            HHLoginController *login = [[HHLoginController alloc] initWithNibName:@"HHLoginController" bundle:nil];
            HHNavigationController *nav = [[HHNavigationController alloc] initWithRootViewController:login];
            [self presentViewController:nav animated:YES completion:nil];
        });
        // 请先登录
    }
}
@end
