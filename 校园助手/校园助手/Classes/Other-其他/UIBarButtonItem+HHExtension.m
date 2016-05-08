//
//  UIBarButtonItem+HHExtension.m
//  图书馆
//
//  Created by hjl on 16/4/20.
//  Copyright © 2016年 hjl. All rights reserved.
//

#import "UIBarButtonItem+HHExtension.h"

@implementation UIBarButtonItem (HHExtension)
+ (UIBarButtonItem *)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    btn.size = btn.currentImage.size;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc] initWithCustomView:btn];
}
@end
