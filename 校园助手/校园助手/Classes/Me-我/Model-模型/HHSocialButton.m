//
//  HHSocialButton.m
//  图书馆
//
//  Created by hjl on 16/4/27.
//  Copyright © 2016年 hjl. All rights reserved.
//

#import "HHSocialButton.h"

@implementation HHSocialButton

- (void)setup{
    self.imageView.contentMode = UIViewContentModeCenter;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self setTitleColor:HHRGBColor(80, 80, 80, 1.0) forState:UIControlStateNormal];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)awakeFromNib{
    [self setup];
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = 50;
    
    self.titleLabel.x = 0;
    self.titleLabel.y = 50;
    self.titleLabel.width = self.width;
    self.titleLabel.height = 30;
}

@end
