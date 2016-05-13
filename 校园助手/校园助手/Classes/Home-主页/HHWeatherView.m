//
//  HHWeatherView.m
//  校园助手
//
//  Created by hjl on 16/5/12.
//  Copyright © 2016年 hjl. All rights reserved.
//

#import "HHWeatherView.h"
#import "HHWeather.h"
#import <UIImageView+WebCache.h>
@interface HHWeatherView ()
@property (weak, nonatomic) IBOutlet UIImageView *weatherImage;
@property (weak, nonatomic) IBOutlet UILabel *tmpLabel;
@property (weak, nonatomic) IBOutlet UILabel *condtxtLabel;
@property (weak, nonatomic) IBOutlet UILabel *locLabel;

@end

@implementation HHWeatherView

- (void)setWeather:(HHWeather *)weather {
    _weather = weather;
    [self.weatherImage sd_setImageWithURL:[NSURL URLWithString:weather.code]];
    self.tmpLabel.text = [NSString stringWithFormat:@"温度: %@ ℃", weather.tmp];
    self.condtxtLabel.text = weather.condtxt;
    self.locLabel.text = [NSString stringWithFormat:@"%@ 更新", weather.loc];
}


@end
