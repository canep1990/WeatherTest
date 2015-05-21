//
//  YVAddCityViewController.h
//  WeatherTest
//
//  Created by Юрий Воскресенский on 19.05.15.
//  Copyright (c) 2015 Юрий Воскресенский. All rights reserved.
//

#import <UIKit/UIKit.h>

/** Protocol for callbacks */
@protocol YVAddCityViewControllerDelegate <NSObject>

/** Callback method. Indicates that user canceled city addition */
- (void)addCityViewDidCancel;
/** Callback method. Indicates that user added city to the list */
- (void)addCityViewDidAddCity;

@end

@class YVWeatherModel;

/** Controller for adding a city */
@interface YVAddCityViewController : UIViewController

/** Delegate property */
@property (weak, nonatomic) id <YVAddCityViewControllerDelegate> delegate;

/** Currently created model */
@property (strong, nonatomic) YVWeatherModel *createdModel;

@end
