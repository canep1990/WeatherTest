//
//  YVDetailedWeatherInfoView.h
//  WeatherTest
//
//  Created by Юрий Воскресенский on 20.05.15.
//  Copyright (c) 2015 Юрий Воскресенский. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YVWeatherModel.h"
#import "YVBaseView.h"

/** View for displaying detailed weather info */
@interface YVDetailedWeatherInfoView : YVBaseView

@property (weak, nonatomic) IBOutlet UITableView *tableView;

/** Current weather model */
@property (strong, nonatomic) YVWeatherModel *weatherModel;

/** Fetch limit for data */
@property (unsafe_unretained, nonatomic) NSInteger fetchLimit;

@end
