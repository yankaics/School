//
//  HHNavigationBar.m
//  图书馆
//
//  Created by hjl on 16/4/27.
//  Copyright © 2016年 hjl. All rights reserved.
//

#import "HHNavigationBar.h"

@implementation HHNavigationBar

+ (void)initialize
{
    UINavigationBar *bar = [UINavigationBar appearance];
    // 设置导航栏为红色
    bar.barTintColor = HHtitleColor;
    bar.tintColor = [UIColor whiteColor];
    //bar.backgroundColor = HHtitleColor;
    //bar.alpha = 1;
    // 设置导航栏文字的大小和颜色
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    md[NSFontAttributeName] = [UIFont systemFontOfSize:20];
    md[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [bar setTitleTextAttributes:md];
}

@end
