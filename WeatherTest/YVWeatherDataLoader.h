//
//  YVWeatherDataLoader.h
//  WeatherTest
//
//  Created by Юрий Воскресенский on 20.05.15.
//  Copyright (c) 2015 Юрий Воскресенский. All rights reserved.
//

#import <Foundation/Foundation.h>

/** Completion handler for success download */
typedef void(^SuccessCompletion)(NSNumber *responseCode);

/** Completion handler for failure download */
typedef void(^FailureCompletion)(NSError *error);

/** Helper class for loading weather data */
@interface YVWeatherDataLoader : NSObject

/** Initializer */
- (instancetype)initWithCityName:(NSString *)cityName;

/** Load weather data for city */
- (void)getWeatherData:(SuccessCompletion)success failureCompletion:(FailureCompletion)failure;

@end