//
//  HHTweet.h
//  图书馆
//
//  Created by hjl on 16/4/30.
//  Copyright © 2016年 hjl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HHTweet : NSObject

/** name */
@property (nonatomic, strong) NSString *name;
/** name */
@property (nonatomic, strong) NSString *username;
/** text */
@property (nonatomic, strong) NSString *text;
/** iconUrl */
@property (nonatomic, strong) NSString *iconUrl;

/** noName */
@property (nonatomic, strong) NSString *noName;
/** time */
@property (nonatomic, strong) NSString *time;
/** cellHeight, 辅助计算cell高度 */
@property (nonatomic, assign) CGFloat cellHeight;
@end
