//
//  HHNews.m
//  校园助手
//
//  Created by hjl on 16/5/13.
//  Copyright © 2016年 hjl. All rights reserved.
//

#import "HHNews.h"

@implementation HHNews

- (CGFloat)cellHeight{
    if(!_cellHeight){
        CGFloat margin = 10;
        if(self.content){
            CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 2 * margin, MAXFLOAT);
            
            CGFloat cententLableH = [self.content boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
            _cellHeight = cententLableH;
        }
    }
    return _cellHeight + 1 + 148;
}

@end
