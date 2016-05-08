//
//  UIView+HHExtension.h
//
//  Created by hjl on 16/3/30.
//  Copyright © 2016年 hjl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HHExtension)
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;


- (BOOL)isShowingOnkeywindow;

+ (instancetype)viewFromXib;
@end