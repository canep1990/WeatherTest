//
//  YVWeatherModel.h
//  WeatherTest
//
//  Created by Юрий Воскресенский on 19.05.15.
//  Copyright (c) 2015 Юрий Воскресенский. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreData+MagicalRecord.h"

@interface YVWeatherModel : NSManagedObject

@property (nonatomic, retain) NSString * cityName;

@end
