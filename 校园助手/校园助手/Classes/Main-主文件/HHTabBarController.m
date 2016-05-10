//
//  AppDelegate.m
//  校园助手
//
//  Created by hjl on 16/5/8.
//  Copyright © 2016年 hjl. All rights reserved.
//

#import "HHTabBarController.h"
#import "HHNavigationController.h"
#import "HHHomeController.h"
#import "HHActivityListController.h"
#import "HHPublishController.h"
#import "HHStatusController.h"
#import "HHMeController.h"
@interface HHTabBarController ()

@end

@implementation HHTabBarController

// 初始化
+ (void)initialize{
    
    UITabBarItem *item = [UITabBarItem appearance];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    [item setTitleTextAttributes:dict forState:UIControlStateNormal];
    
    NSMutableDictionary *dictSelected = [NSMutableDictionary dictionary];
    dictSelected[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    dictSelected[NSForegroundColorAttributeName] = HHtitleColor;
    [item setTitleTextAttributes:dictSelected forState:UIControlStateSelected];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置控制器
    [self setupController];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    UIView *plusView = [[UIView alloc] init];
    CGFloat fiveW = HHWidth / 5;
    
    plusView.frame = CGRectMake(fiveW * 2.1, 5, fiveW * 0.8, self.tabBar.height - 10);
    plusView.layer.cornerRadius = 5;
    plusView.layer.masksToBounds = YES;
    plusView.backgroundColor = HHRGBColor(63, 218, 149, 1);
    [self.tabBar addSubview:plusView];
    
    UIButton *btn = [[UIButton alloc] init];
    btn.frame = CGRectMake(HHWidth * 2 / 5, 0, HHWidth / 5, self.tabBar.height);
    [btn setImage:[UIImage imageNamed:@"tab_06_plus"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(publish) forControlEvents:UIControlEventTouchUpInside];
    [self.tabBar addSubview:btn];
}

- (void)publish {
    HHPublishController *pu = [[HHPublishController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:pu];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)setupController{

    // 新闻
    [self addChildViewController:[[HHHomeController alloc] init] title:@"新闻" image:@"tab_home_nor" selectedImage:@"tab_home_click"];
    
    // 活动
    [self addChildViewController:[[HHActivityListController alloc] init] title:@"活动" image:@"tab_find_nor" selectedImage:@"tab_find_click"];
    
    // 加号
    [self addChildViewController:[[UIViewController alloc] init] title:@"" image:nil            selectedImage:nil];
    
    // 树洞
    [self addChildViewController:[[HHStatusController alloc] init] title:@"树洞" image:@"tab_school_circle_nor" selectedImage:@"tab_school_circle"];
    
    // 我
    [self addChildViewController:[[HHMeController alloc] init] title:@"我" image:@"tab_message_nor" selectedImage:@"tab_message_click"];
}


- (void)addChildViewController:(UIViewController *)childController title:(NSString *)title image:(NSString *)image selectedImage:(NSString *) selectedImage{
    
    //childController.view.backgroundColor = HHBackgroundColor;
    if (image.length > 0) {
        childController.tabBarItem.image = [UIImage imageNamed:image];
    }
    if (selectedImage.length >0){
        childController.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    }
    childController.title = title;
    HHNavigationController *naga = [[HHNavigationController alloc] initWithRootViewController:childController];
    [self addChildViewController:naga];
}

- (void)addChildVcName:(NSString *)childVcName title:(NSString *)title image:(NSString *)image selectedImage:(NSString *) selectedImage{
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:childVcName bundle:nil];
    UIViewController *view = [sb instantiateInitialViewController];

    view.tabBarItem.image = [UIImage imageNamed:image];
    view.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    view.title = title;
    
    HHNavigationController *naga = [[HHNavigationController alloc] initWithRootViewController:view];
    
    [self addChildViewController:naga];
}

@end
