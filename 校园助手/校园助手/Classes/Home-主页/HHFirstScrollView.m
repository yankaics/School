//
//  HHFirstScrollView.m
//  校园助手
//
//  Created by hjl on 16/5/8.
//  Copyright © 2016年 hjl. All rights reserved.
//

#import "HHFirstScrollView.h"
@interface HHFirstScrollView ()<UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView1;
@property (strong, nonatomic) UIPageControl *pageCtl;
@property (strong, nonatomic) NSTimer *timer;

@end

@implementation HHFirstScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.scrollView1];
        [self addSubview:self.pageCtl];
        [self addimage];
        [self addTimer];
        
    }
    return self;
}



#pragma mark 属性列表
- (UIScrollView *)scrollView1
{
    if (!_scrollView1) {
        _scrollView1 = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, HHWidth, scrollHeight)];
        _scrollView1.showsHorizontalScrollIndicator = NO;
        _scrollView1.pagingEnabled = YES;
        _scrollView1.bounces = YES;
        _scrollView1.delegate = self;
        _scrollView1.contentSize = CGSizeMake(HHWidth * imageCount, 0);
    }
    return _scrollView1;
}
- (UIPageControl *)pageCtl
{
    if (!_pageCtl) {
        _pageCtl = [[UIPageControl alloc]initWithFrame:CGRectMake(260, scrollHeight + 30, 120, 40)];
        _pageCtl.numberOfPages = imageCount;
        _pageCtl.pageIndicatorTintColor = [UIColor whiteColor];
        _pageCtl.currentPageIndicatorTintColor = [UIColor yellowColor];
    }
    return _pageCtl;
}


#pragma mark  自动调用的方法 滚动时就会调用该方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = (scrollView.contentOffset.x + HHWidth * 0.5)/HHWidth;
    self.pageCtl.currentPage = page;
}

#pragma mark 自定义方法

- (void)addimage
{
    for (int i = 0; i < imageCount; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(HHWidth * i, 0, HHWidth, scrollHeight)];
        NSString *stringName = [NSString stringWithFormat:@"home_%d.jpg",i+1];
        imageView.image = [UIImage imageNamed:stringName];
        [self.scrollView1 addSubview:imageView];
        
        self.scrollView1.contentOffset = CGPointMake(0, 0);
    }
}

- (void)NextImage
{
    int page = 0;
    if (self.pageCtl.currentPage == imageCount - 1) {
        page = 0;
        CGFloat offsetX = page * HHWidth;
        CGPoint offset = CGPointMake(offsetX, 0);
        [self.scrollView1 setContentOffset:offset animated:NO];
    }
    else{
        page = (int)self.pageCtl.currentPage + 1;
        CGFloat offsetX = page * HHWidth;
        CGPoint offset = CGPointMake(offsetX, 0);
        [self.scrollView1 setContentOffset:offset animated:YES];
    }
    
}

- (void)addTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(NextImage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
}


@end
