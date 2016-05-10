//
//  HHActivityCell.m
//  校园助手
//
//  Created by hjl on 16/5/8.
//  Copyright © 2016年 hjl. All rights reserved.
//

#import "HHActivityCell.h"
#import <UIImageView+WebCache.h>
#import "HHActivity.h"
@interface HHActivityCell ()
@property (weak, nonatomic) IBOutlet UIImageView *picView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *unitLabel;
@property (weak, nonatomic) IBOutlet UILabel *siteLabel;

@end

@implementation HHActivityCell

- (void)setFrame:(CGRect)frame{
    CGFloat margin = 10;
    
    frame.size.height -= margin;
    frame.origin.y += margin;
    
    [super setFrame:frame];
}

- (void)setActivity:(HHActivity *)activity{
    _activity = activity;
    
    [self.picView sd_setImageWithURL:[NSURL URLWithString:activity.picture] placeholderImage:[UIImage imageNamed:@"icon"]];
    
    self.titleLabel.text = activity.title;
    self.timeLabel.text = activity.time;
    self.unitLabel.text = activity.unit;
    self.siteLabel.text = activity.site;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
