//
//  YVWeatherDescriptionModel.h
//  WeatherTest
//
//  Created by Юрий Воскресенский on 20.05.15.
//  Copyright (c) 2015 Юрий Воскресенский. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreData+MagicalRecord.h"

@interface YVWeatherDescriptionModel : NSManagedObject

@property (nonatomic, retain) NSString * cityName;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * morningTemperature;
@property (nonatomic, retain) NSNumber * nightTemperature;
@property (nonatomic, retain) NSNumber * eveningTemperature;
@property (nonatomic, retain) NSNumber * dayTemperature;
@property (nonatomic, retain) NSNumber * humidity;
@property (nonatomic, retain) NSString * weatherMain;
@property (nonatomic, retain) NSString * weatherDescription;

@end
