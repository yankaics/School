//
//  HHStatusController.m
//  图书馆
//
//  Created by hjl on 16/4/30.
//  Copyright © 2016年 hjl. All rights reserved.
//

#import "HHStatusController.h"
#import "HHTweetController.h"
@interface HHStatusController ()<UIScrollViewDelegate>

/** contentView */
@property (weak, nonatomic) UIScrollView *contentView;

/** 选中的titleView中的按钮 */
@property (weak, nonatomic) UIButton *selectedButton;

/** 标题框 */
@property (weak, nonatomic) UIView *titleView;

/** 红色指示器 */
@property (weak, nonatomic) UIView *indicatorView;

@end

@implementation HHStatusController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = HHBackgroundColor;
    
    // 设置子控制器
    [self setupChild];
    
    // 设置titleview
    [self setupTitleView];
    
    [self setupContentView];
}
// 设置子控制器
- (void)setupChild{
    
    HHTweetController *all = [[HHTweetController alloc] init];
    all.title = @"全部内容";
    all.type = 1;
    [self addChildViewController:all];
    
    HHTweetController *me = [[HHTweetController alloc] init];
    me.title = @"我的树洞";
    me.type = 2;
    [self addChildViewController:me];
}


// 设置titleview
- (void)setupTitleView{
    // 设置标题框
    UIView *titleView = [[UIView alloc]init];
    CGFloat titleViewX = 0;
    CGFloat titleViewY = 64;
    CGFloat titleViewH = 35;
    CGFloat titleViewW = HHWidth;
    titleView.frame = CGRectMake(titleViewX, titleViewY, titleViewW, titleViewH);
    titleView.backgroundColor = [UIColor whiteColor];
    self.titleView = titleView;
    [self.view addSubview:titleView];
    
    // 底部的红色指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.height = 2;
    indicatorView.y = titleViewH - 2;
    indicatorView.backgroundColor = HHtitleColor;
    self.indicatorView = indicatorView;
    
    
    // 设置按钮
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnH = 35;
    CGFloat btnW = self.view.width / self.childViewControllers.count;
    
    for (NSInteger i = 0; i < self.childViewControllers.count; i++){
        UIButton *btn = [[UIButton alloc]init];
        btnX = i * btnW;
        btn.tag = i;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitle:self.childViewControllers[i].title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor: HHtitleColor forState:UIControlStateDisabled];
        [titleView addSubview:btn];
        
        if(i == 0){
            btn.enabled = NO;
            self.selectedButton = btn;
            [btn.titleLabel sizeToFit];
            self.indicatorView.width = btn.titleLabel.width;
            self.indicatorView.centerX = btn.centerX;
        }
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self.titleView addSubview:self.indicatorView];
}


// 设置ContentView
- (void)setupContentView{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 创建
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.frame = self.view.bounds;
    // 禁止弹簧效果
    contentView.bounces = NO;
    // 属性赋值
    self.contentView = contentView;
    // 添加到控制器底部
    [self.view insertSubview:contentView atIndex:0];
    // 设置代理
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    
    contentView.contentSize = CGSizeMake(self.childViewControllers.count * self.view.width, 0);
    [self scrollViewDidEndScrollingAnimation:contentView];
}

// 点击导航栏下方2个按钮时调用
- (void)btnClick:(UIButton *)button{
    
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.centerX = button.centerX;
    }];
    
    CGPoint offset =  self.contentView.contentOffset;
    
    offset.x = button.tag * self.view.width;
    
    [self.contentView setContentOffset:offset animated:YES];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    int index = scrollView.contentOffset.x / self.view.width;
    
    UIViewController *vc = self.childViewControllers[index];
    CGFloat vcX = scrollView.contentOffset.x;
    CGFloat vcY = 0;
    CGFloat vcH = self.view.height;
    CGFloat vcW = self.view.width;
    vc.view.frame = CGRectMake(vcX, vcY, vcW, vcH);
    [scrollView addSubview:vc.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGPoint offset = scrollView.contentOffset;
    
    NSInteger index = offset.x / self.view.width;
    
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    [self btnClick:self.titleView.subviews[index]];
}
@end
