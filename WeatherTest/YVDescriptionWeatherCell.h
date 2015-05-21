//
//  YVDesctiptionWeatherCell.h
//  WeatherTest
//
//  Created by Юрий Воскресенский on 20.05.15.
//  Copyright (c) 2015 Юрий Воскресенский. All rights reserved.
//

#import "YVBaseTableViewCell.h"
#import "YVWeatherDescriptionModel.h"

@interface YVDescriptionWeatherCell : YVBaseTableViewCell

- (void)configureCellWithWeatherDescriptionModel:(YVWeatherDescriptionModel *)weatherModel;

@end
