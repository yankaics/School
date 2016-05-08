//
//  HHMeController.m
//  图书馆
//
//  Created by hjl on 16/4/21.
//  Copyright © 2016年 hjl. All rights reserved.
//

#import "HHMeController.h"
#import "HHNavigationController.h"
#import "HHLoginController.h"
#import <AFNetworking.h>
#import "LrdOutputView.h"
#import <AssetsLibrary/ALAsset.h>
#import <AssetsLibrary/ALAssetsLibrary.h>
#import <AssetsLibrary/ALAssetsGroup.h>
#import <AssetsLibrary/ALAssetRepresentation.h>
#import <UIImageView+WebCache.h>
#import <UIButton+WebCache.h>
#import "HHEditMeInfoController.h"
@interface HHMeController () <LrdOutputViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) LrdOutputView *outputView;
/** 头像按钮 */
@property (nonatomic, strong) UIButton *iconBtn;

/** uiiimage */
@property (nonatomic, strong) UIImage *iconimage;

/** BmobUser */
@property (nonatomic, strong) BmobUser *bUser;

@end

@implementation HHMeController

// 页面加载完毕时, 判断是否跳转
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    BmobUser *bUser = [BmobUser getCurrentUser];
    if (bUser) {
        [self.iconBtn sd_setImageWithURL:[NSURL URLWithString:[bUser objectForKey:@"iconUrl"]] forState:UIControlStateNormal];
        [self.tableView reloadData];
        // 移除蒙版
    }else{
        //对象为空时，可打开用户注册界面
        [self loginClick];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavItem];
    [self setupTableViewHeader];
    // 获取缓存账户
    BmobUser *bUser = [BmobUser getCurrentUser];
    self.bUser = bUser;
    // 设置头像
    self.tableView.rowHeight = 50;
    [self.tableView reloadData];
    [self setupModel];
}
// 设置导航栏
- (void)setupNavItem{
    self.navigationItem.title = @"我的信息";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_setting" highImage:@"navigationbar_setting" target:self action:@selector(settingItemClick:)];
}

// model数据
- (void)setupModel {
    //几个model
    //LrdCellModel *one = [[LrdCellModel alloc] initWithTitle:@"退出软件"];
    LrdCellModel *two = [[LrdCellModel alloc] initWithTitle:@"修改资料"];
    LrdCellModel *three = [[LrdCellModel alloc] initWithTitle:@"注销登录"];
    LrdCellModel *four = [[LrdCellModel alloc] initWithTitle:@"分享软件"];
    LrdCellModel *five = [[LrdCellModel alloc] initWithTitle:@"清除缓存"];
    self.dataArr = @[two, four, five, three];
}

// 顶部视图
- (void)setupTableViewHeader {
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, HHWidth, 200)];
    bottomView.backgroundColor = [UIColor clearColor];
    
    UIView *tableViewHeader = [[UIView alloc] init];
    tableViewHeader.frame = CGRectMake(0, 0, HHWidth, 160);
    tableViewHeader.backgroundColor = [UIColor redColor];
    
    [bottomView addSubview:tableViewHeader];
    self.tableView.tableHeaderView = bottomView;
    
    UIButton *iconBtn = [[UIButton alloc] init];
    CGFloat iconBtnX = (HHWidth - 80) / 2;
    CGFloat iconBtnY = 30;
    iconBtn.frame = CGRectMake(iconBtnX, iconBtnY, 80, 80);
    iconBtn.backgroundColor = [UIColor grayColor];
    iconBtn.layer.cornerRadius = 40;
    iconBtn.layer.masksToBounds = YES;
    [iconBtn setImage:[UIImage imageNamed:@"icon"] forState:UIControlStateNormal];
    [iconBtn addTarget:self action:@selector(setupIconImage) forControlEvents:UIControlEventTouchUpInside];    
    self.iconBtn = iconBtn;
    [tableViewHeader addSubview:iconBtn];
}

// 更换头像
- (void)setupIconImage{
    // 创建图片选择器控制器
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    // 设置代理
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}
#pragma mark - <UIImagePickerControllerDelegate>
// 点击取消按钮的时候调用
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
// 选中图片的时候调用
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    // 相册图片的基本信息
    UIImage *newIconImage =  info[UIImagePickerControllerOriginalImage];
    //压缩图片UIImageJPEGRepresentation(imageNew, 0.0001)
    NSData *fileData = UIImageJPEGRepresentation(newIconImage, 0.1);
    // 上传图片信息,也就是设置iamge的值
    //BmobObject *obj = [[BmobObject alloc] initWithClassName:@"iconImage"];
    BmobFile *file1 = [[BmobFile alloc] initWithFileName:@"111.png" withFileData:fileData];
    [file1 saveInBackground:^(BOOL isSuccessful, NSError *error) {
        //如果文件保存成功，则把文件添加到filetype列
        if (isSuccessful) {
//            [obj setObject:file1  forKey:@"iconFile"];
//            [obj saveInBackground];
            HHLog(@"图片上传成功");
            //打印file文件的url地址
            [self.bUser setObject:file1.url forKey:@"iconUrl"];
            [self.bUser updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                if (isSuccessful) {
                    HHLog(@"file1 url %@",[self.bUser objectForKey:@"iconUrl"]);
                    // 设置到本地
                    [self.iconBtn sd_setImageWithURL:[NSURL URLWithString:[self.bUser objectForKey:@"iconUrl"]] forState:UIControlStateNormal];
                    [self.tableView reloadData];
                } else if (error){
                    HHLog(@"错误%@", error);
                } else {
                    HHLog(@"上传url失败, 不知名错误");
                }
            }];
            // 设置到本地
            [self.iconBtn sd_setImageWithURL:[NSURL URLWithString:[self.bUser objectForKey:@"iconUrl"]] forState:UIControlStateNormal];
        }else{
            //进行处理
            HHLog(@"+++%@", error);
        }
    }];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

// 设置按钮
- (void)settingItemClick:(UIButton *)btn{
    CGFloat x = btn.center.x + 20;
    CGFloat y = btn.frame.origin.y + 60;
    
    _outputView = [[LrdOutputView alloc] initWithDataArray:self.dataArr origin:CGPointMake(x, y) width:100 height:44 direction:kLrdOutputViewDirectionRight];
    _outputView.delegate = self;
    _outputView.dismissOperation = ^(){
        //设置成nil，以防内存泄露
        _outputView = nil;
    };
    [_outputView pop];
}

- (void)didSelectedAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            [self editMeInfo];
            break;
        case 1:
            
            break;
        case 2:
            
            break;
        case 3:
            [self logout];
            break;
        default:
            break;
    }
}

// 登录
- (void)loginClick{
    HHLoginController *login = [[HHLoginController alloc] initWithNibName:@"HHLoginController" bundle:nil];
    login.block = ^(){
        [self viewDidLoad];
        [self viewDidAppear:YES];
        //[self.tableView reloadData];
        
    };
    HHNavigationController *nav = [[HHNavigationController alloc] initWithRootViewController:login];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)editMeInfo {
    HHEditMeInfoController *edit = [[HHEditMeInfoController alloc] initWithNibName:@"HHEditMeInfoController" bundle:nil];
    [self.navigationController pushViewController:edit animated:YES];
}

// 注销
- (void)logout {
    [BmobUser logout];
    //对象为空时，可打开用户注册界面
    [self loginClick];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    } else{
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BmobUser *bUser = [BmobUser getCurrentUser];
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    NSInteger section = indexPath.section;
    if (section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = [NSString stringWithFormat:@"账号: %@", bUser.username];
        }else if (indexPath.row == 1){
            NSString *name = [bUser objectForKey:@"name"];
            if (name == nil){
                cell.textLabel.text = [NSString stringWithFormat:@"昵称: 未填写"];
            }else{
                cell.textLabel.text = [NSString stringWithFormat:@"昵称: %@", name];
            }
        }else{
            NSString *sex = [bUser objectForKey:@"sex"];
            if (sex == nil){
                cell.textLabel.text = [NSString stringWithFormat:@"性别: 未填写"];
            }else{
                cell.textLabel.text = [NSString stringWithFormat:@"性别: %@", sex];
            }
        }
    } else{
        if (indexPath.row == 0) {
            NSString *mobilePhoneNumber = [bUser objectForKey:@"phone"];
            if (mobilePhoneNumber == nil){
                cell.textLabel.text = [NSString stringWithFormat:@"手机: 未填写"];
            }else{
                cell.textLabel.text = [NSString stringWithFormat:@"手机: %@", mobilePhoneNumber];
            }
        }else{
            NSString *email = [bUser objectForKey:@"email"];
            if (email == nil){
                cell.textLabel.text = [NSString stringWithFormat:@"邮箱: 未填写"];
            }else{
                cell.textLabel.text = [NSString stringWithFormat:@"邮箱: %@", email];
            }
        }
    }
    return cell;
}
@end
