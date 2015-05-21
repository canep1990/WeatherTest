//
//  YVStartingCell.m
//  WeatherTest
//
//  Created by Юрий Воскресенский on 19.05.15.
//  Copyright (c) 2015 Юрий Воскресенский. All rights reserved.
//

#import "YVStartingCell.h"
#import "YVWeatherModel.h"

@implementation YVStartingCell

- (void)configureCellWithWeatherModel:(YVWeatherModel *)weatherModel
{
    [super configureCellWithWeatherModel:weatherModel];
    self.textLabel.text = weatherModel.cityName;
}

@end
