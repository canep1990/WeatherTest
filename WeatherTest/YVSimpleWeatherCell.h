//
//  YVSimpleWeatherCell.h
//  WeatherTest
//
//  Created by Юрий Воскресенский on 20.05.15.
//  Copyright (c) 2015 Юрий Воскресенский. All rights reserved.
//

#import "YVBaseSelectableTableViewCell.h"

@interface YVSimpleWeatherCell : YVBaseSelectableTableViewCell

- (void)configureCellWithWeatherModel:(YVWeatherModel *)weatherModel;

@end
