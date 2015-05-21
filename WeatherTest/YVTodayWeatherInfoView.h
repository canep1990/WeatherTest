//
//  YVTodayWeatherInfoView.h
//  WeatherTest
//
//  Created by Юрий Воскресенский on 19.05.15.
//  Copyright (c) 2015 Юрий Воскресенский. All rights reserved.
//

#import "YVBaseView.h"

@class YVWeatherDescriptionModel, YVWeatherModel;

/** Protocol for callbacks */
@protocol YVTodayWeatherInfoViewDelegate <NSObject>

/** Callback for selected model at index */
- (void)didSelectModel:(YVWeatherDescriptionModel *)model atIndex:(NSInteger)index;

@end

/** View for displaying the weather for today */
@interface YVTodayWeatherInfoView : YVBaseView

@property (weak, nonatomic) IBOutlet UITableView *tableView;

/** Delegate property */
@property (weak, nonatomic) id <YVTodayWeatherInfoViewDelegate> delegate;

/** Current weather model */
@property (strong, nonatomic) YVWeatherModel *weatherModel;

/** Method for reloading table data */
- (void)reloadTableData;

@end
