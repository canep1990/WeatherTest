//
//  YVDetailedWeatherInfoViewController.h
//  WeatherTest
//
//  Created by Юрий Воскресенский on 20.05.15.
//  Copyright (c) 2015 Юрий Воскресенский. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YVWeatherModel.h"

/** Controller for handling detailed weather info */
@interface YVDetailedWeatherInfoViewController : UIViewController

/** Current weather model */
@property (strong, nonatomic) YVWeatherModel *weatherModel;

/** Fetch limit for  */
@property (unsafe_unretained, nonatomic) NSInteger fetchLimit;

@end
