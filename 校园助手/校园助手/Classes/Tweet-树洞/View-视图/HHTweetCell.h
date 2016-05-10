//
//  HHTweetCell.h
//  图书馆
//
//  Created by hjl on 16/4/30.
//  Copyright © 2016年 hjl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HHTweet;
@interface HHTweetCell : UITableViewCell

/** tweet模型 */
@property (nonatomic, strong) HHTweet *tweet;

@end
