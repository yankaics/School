//
//  HHNews.h
//  校园助手
//
//  Created by hjl on 16/5/13.
//  Copyright © 2016年 hjl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HHNews : NSObject

/** title */
@property (nonatomic, strong) NSString *title;

/** 内容 */
@property (nonatomic, strong) NSString *content;

/** 发布人 */
@property (nonatomic, strong) NSString *publisher;

/** 作者 */
@property (nonatomic, strong) NSString *author;

/** 时间 */
@property (nonatomic, strong) NSString *publishTime;

/** 行高 */
@property (nonatomic, assign) CGFloat cellHeight;
@end
