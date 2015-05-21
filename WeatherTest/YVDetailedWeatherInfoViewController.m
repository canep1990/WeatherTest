//
//  YVDetailedWeatherInfoViewController.m
//  WeatherTest
//
//  Created by Юрий Воскресенский on 20.05.15.
//  Copyright (c) 2015 Юрий Воскресенский. All rights reserved.
//

#import "YVDetailedWeatherInfoViewController.h"
#import "YVDetailedWeatherInfoView.h"

@interface YVDetailedWeatherInfoViewController ()

@end

@implementation YVDetailedWeatherInfoViewController

- (void)loadView
{
    self.title = self.weatherModel.cityName;
    YVDetailedWeatherInfoView *view = [[YVDetailedWeatherInfoView alloc] init];
    view.weatherModel = self.weatherModel;
    view.fetchLimit = self.fetchLimit;
    self.view = view;
}

@end
