//
//  YVWeatherDataLoader.m
//  WeatherTest
//
//  Created by Юрий Воскресенский on 20.05.15.
//  Copyright (c) 2015 Юрий Воскресенский. All rights reserved.
//

#import "YVWeatherDataLoader.h"
#import <AFNetworking/AFNetworking.h>
#import "YVWeatherDescriptionModel.h"

static NSString *const kURLString = @"http://api.openweathermap.org/data/2.5/forecast/daily";
static NSInteger const kOKResponseStatusCode = 200;

@interface YVWeatherDataLoader()

@property (copy, nonatomic) NSString *cityName;

@end

@implementation YVWeatherDataLoader

- (instancetype)initWithCityName:(NSString *)cityName
{
    self = [super init];
    if (self)
    {
        self.cityName = cityName;
    }
    return self;
}

- (void)getWeatherData:(SuccessCompletion)success failureCompletion:(FailureCompletion)failure
{
    NSString *url = [NSString stringWithFormat:@"%@?q=%@&cnt=7&lang=ru", kURLString, self.cityName];
    NSString *encoded = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[AFHTTPRequestOperationManager manager] GET:encoded  parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *response = (NSDictionary *)responseObject;
        NSNumber *responseCode = [response objectForKey:@"cod"];
        if (responseCode.intValue == kOKResponseStatusCode)
        {
            NSArray *weatherArray = [response objectForKey:@"list"];
            [YVWeatherDescriptionModel MR_deleteAllMatchingPredicate:[NSPredicate predicateWithFormat:@"cityName == %@", self.cityName]];
            for (NSDictionary *dictionary in weatherArray)
            {
                NSNumber *dateNumber = [dictionary objectForKey:@"dt"];
                NSDate *date = [NSDate dateWithTimeIntervalSince1970:dateNumber.doubleValue];
                NSDictionary *temp = [dictionary objectForKey:@"temp"];
                NSNumber *dayTemperature = [temp objectForKey:@"day"];
                NSNumber *morningTemperature = [temp objectForKey:@"morn"];
                NSNumber *eveningTemperature = [temp objectForKey:@"eve"];
                NSNumber *nightTemperature = [temp objectForKey:@"night"];
                NSNumber *humidity = [dictionary objectForKey:@"humidity"];
                NSDictionary *weather = [dictionary objectForKey:@"weather"][0];
                NSString *weatherMain = [weather objectForKey:@"main"];
                NSString *weatherDescription = [weather objectForKey:@"description"];
                
                YVWeatherDescriptionModel *model = [YVWeatherDescriptionModel MR_createEntity];
                
                model.date = date;
                model.cityName = self.cityName;
                model.dayTemperature = dayTemperature;
                model.morningTemperature = morningTemperature;
                model.nightTemperature = nightTemperature;
                model.eveningTemperature = eveningTemperature;
                model.humidity = humidity;
                model.weatherMain = weatherMain;
                model.weatherDescription = weatherDescription;
            }
            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        }
        if (success)
        {
            success(responseCode);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure)
        {
            failure(error);
        }
    }];
}

@end
