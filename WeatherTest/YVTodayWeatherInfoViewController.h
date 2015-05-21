//
//  YVTodayWeatherInfoViewController.h
//  WeatherTest
//
//  Created by Юрий Воскресенский on 19.05.15.
//  Copyright (c) 2015 Юрий Воскресенский. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YVWeatherModel;

/** Controller for handling today weather */
@interface YVTodayWeatherInfoViewController : UIViewController

/** Current weather model */
@property (strong, nonatomic) YVWeatherModel *weatherModel;

@end
