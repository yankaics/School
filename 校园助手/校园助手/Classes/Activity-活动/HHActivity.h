//
//  HHActivity.h
//  校园助手
//
//  Created by hjl on 16/5/8.
//  Copyright © 2016年 hjl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HHActivity : NSObject

/** 活动类型 */
@property (nonatomic, strong) NSString *publisher;

/** 组织单位 */
@property (nonatomic, strong) NSString *unit;

/** title */
@property (nonatomic, strong) NSString *title;


/** 时间 */
@property (nonatomic, strong) NSString *time;

/** 内容 */
@property (nonatomic, strong) NSString *content;

/** 图片 */
@property (nonatomic, strong) NSString *picture;

/** 活动地点 */
@property (nonatomic, strong) NSString *site;

/** 行高 */
@property (nonatomic, assign) CGFloat cellHeight;

@end