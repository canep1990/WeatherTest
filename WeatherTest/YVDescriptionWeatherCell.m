//
//  YVDesctiptionWeatherCell.m
//  WeatherTest
//
//  Created by Юрий Воскресенский on 20.05.15.
//  Copyright (c) 2015 Юрий Воскресенский. All rights reserved.
//

#import "YVDescriptionWeatherCell.h"

static float const kKelvinNumberToConvertToCelsius = 273.15;
static NSString * const kDateFormat = @"dd.MM.yyyy";

@interface YVDescriptionWeatherCell()

@property (weak, nonatomic) IBOutlet UILabel *morningTempLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayTempLabel;
@property (weak, nonatomic) IBOutlet UILabel *nightTempLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *weatherDescriptionLabel;

@end

@implementation YVDescriptionWeatherCell

- (void)configureCellWithWeatherDescriptionModel:(YVWeatherDescriptionModel *)weatherModel
{
    self.morningTempLabel.text = [NSString stringWithFormat:@"Утро: %.2f °C", [weatherModel.morningTemperature floatValue] - kKelvinNumberToConvertToCelsius];
    self.dayTempLabel.text = [NSString stringWithFormat:@"День: %.2f °C", [weatherModel.dayTemperature floatValue] - kKelvinNumberToConvertToCelsius];
    self.nightTempLabel.text = [NSString stringWithFormat:@"Ночь: %.2f °C", [weatherModel.nightTemperature floatValue] - kKelvinNumberToConvertToCelsius];
    NSDateFormatter *_formatter=[[NSDateFormatter alloc]init];
    [_formatter setDateFormat:kDateFormat];
    NSString *date2=[_formatter stringFromDate:weatherModel.date];
    self.dateLabel.text = date2;
    self.weatherDescriptionLabel.text = weatherModel.weatherDescription;
}

@end
