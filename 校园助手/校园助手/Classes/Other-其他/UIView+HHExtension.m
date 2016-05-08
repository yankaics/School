//
//  UIView+HHExtension.m
//
//  Created by hjl on 16/3/30.
//  Copyright © 2016年 hjl. All rights reserved.
//

#import "UIView+HHExtension.h"

@implementation UIView (HHExtension)
- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX{
    CGPoint point = self.center;
    point.x = centerX;
    self.center = point;
}

- (void)setCenterY:(CGFloat)centerY{
    CGPoint point = self.center;
    point.y = centerY;
    self.center = point;
}

- (CGFloat)centerX{
    return self.center.x;
}

- (CGFloat)centerY{
    return self.center.y;
}

- (BOOL)isShowingOnkeywindow{
    UIWindow *keyWin = [UIApplication sharedApplication].keyWindow;
    CGRect keyFrame = keyWin.bounds;
    CGRect currentFrame = [keyWin convertRect:self.frame fromView:self.superview];
    
    BOOL intersect = CGRectIntersectsRect(keyFrame, currentFrame);
    return !self.hidden && self.alpha > 0.01 && self.window == keyWin && intersect;
}

+ (instancetype)viewFromXib{
   return  [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}
@end
