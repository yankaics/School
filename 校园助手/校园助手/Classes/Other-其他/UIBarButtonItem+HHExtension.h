//
//  UIBarButtonItem+HHExtension.h
//  图书馆
//
//  Created by hjl on 16/4/20.
//  Copyright © 2016年 hjl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (HHExtension)
+ (UIBarButtonItem *)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;
@end
