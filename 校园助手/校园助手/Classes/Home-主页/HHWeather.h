//
//  HHWeather.h
//  校园助手
//
//  Created by hjl on 16/5/12.
//  Copyright © 2016年 hjl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HHWeather : NSObject
/** 城市名称 */
@property (nonatomic, strong) NSString *city;

/** 数据更新的当地时间 basic / update / loc */
@property (nonatomic, strong) NSString *loc;

/** 当前温度(摄氏度) now / tmp */
@property (nonatomic, strong) NSString *tmp;

/** 天气描述 now / cond / txt*/
@property (nonatomic, strong) NSString *condtxt;

/** 天气代码 now / cond / code    用来获取天气图标, 已转成http */
//http://files.heweather.com/cond_icon/100.png
@property (nonatomic, strong) NSString *code;

@end
