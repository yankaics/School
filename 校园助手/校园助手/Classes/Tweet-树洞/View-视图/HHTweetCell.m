//
//  HHTweetCell.m
//  图书馆
//
//  Created by hjl on 16/4/30.
//  Copyright © 2016年 hjl. All rights reserved.
//

#import "HHTweetCell.h"
#import "HHTweet.h"
#import <UIImageView+WebCache.h>
@interface HHTweetCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentTextLabel;

@end

@implementation HHTweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setFrame:(CGRect)frame{
    CGFloat margin = 10;
    
    frame.size.height -= margin;
    frame.origin.y += margin;
    
    [super setFrame:frame];
}

- (void)setTweet:(HHTweet *)tweet{
    _tweet = tweet;
    //HHLog(@"---->%@", tweet.noName);
    
    self.timeLabel.text = tweet.time;
    self.contentTextLabel.text = tweet.text;
    self.height = tweet.cellHeight;
    // 匿名
    if ([tweet.noName isEqualToString:@"1"]) {
        [self.iconImage sd_setImageWithURL:[NSURL URLWithString:@"http://bmob-cdn-871.b0.upaiyun.com/2016/04/30/02547f9134304c6c99dcdb9b124436b1.png"] placeholderImage:[UIImage imageNamed:@"icon"]];
        //HHLog(@"ni");
        self.nameLabel.text = @"某同学";
    }else{
        [self.iconImage sd_setImageWithURL:[NSURL URLWithString:tweet.iconUrl] placeholderImage:[UIImage imageNamed:@"icon"]];
        //HHLog(@"xian");
        self.nameLabel.text = tweet.name;
    }
}

@end
