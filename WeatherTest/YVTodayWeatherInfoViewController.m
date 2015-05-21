//
//  YVTodayWeatherInfoViewController.m
//  WeatherTest
//
//  Created by Юрий Воскресенский on 19.05.15.
//  Copyright (c) 2015 Юрий Воскресенский. All rights reserved.
//

#import "YVTodayWeatherInfoViewController.h"
#import "YVTodayWeatherInfoView.h"
#import <AFNetworking/AFNetworking.h>
#import "YVWeatherDataLoader.h"
#import "YVWeatherModel.h"
#import "YVDetailedWeatherInfoViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>

static NSInteger const kOKResponseStatusCode = 200;

static NSInteger const kIndexForFetchLimit = 2;

static NSInteger const kFetchLimitMedium = 3;

static NSInteger const kFetchLimitMaximum = 7;

static NSString * const kErrorMessageString = @"Ошибка";

static NSString * const kErrorMessageDescriptionString = @"Не удалось загрузить данные о погоде";

static NSString * const kOKButtonTitle = @"OK";

@interface YVTodayWeatherInfoViewController () <YVTodayWeatherInfoViewDelegate>

@end

@implementation YVTodayWeatherInfoViewController

- (void)loadView
{
    YVTodayWeatherInfoView *view = [[YVTodayWeatherInfoView alloc] init];
    view.weatherModel = self.weatherModel;
    view.delegate = self;
    self.view = view;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = self.weatherModel.cityName;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    YVWeatherDataLoader *weatherLoader = [[YVWeatherDataLoader alloc] initWithCityName:self.weatherModel.cityName];
    [weatherLoader getWeatherData:^(NSNumber *responseCode) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        YVTodayWeatherInfoView *view = (YVTodayWeatherInfoView *)self.view;
        [view reloadTableData];
        if (responseCode.intValue != kOKResponseStatusCode)
        {
            UIAlertController *controller = [UIAlertController alertControllerWithTitle:kErrorMessageString message:kErrorMessageDescriptionString preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:kOKButtonTitle style:UIAlertActionStyleCancel handler:nil];
            [controller addAction:action];
            [self presentViewController:controller animated:YES completion:nil];
        }
    } failureCompletion:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:kErrorMessageString message: [NSString stringWithFormat:@"%@. %@", kErrorMessageDescriptionString, error.localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:kOKButtonTitle style:UIAlertActionStyleCancel handler:nil];
        [controller addAction:action];
        [self presentViewController:controller animated:YES completion:nil];
    }];
}

#pragma mark - YVTodayWeatherInfoViewDelegate

- (void)didSelectModel:(YVWeatherDescriptionModel *)model atIndex:(NSInteger)index
{
    YVDetailedWeatherInfoViewController *infoVC = [[YVDetailedWeatherInfoViewController alloc] init];
    infoVC.weatherModel = self.weatherModel;
    if (index == kIndexForFetchLimit)
    {
        infoVC.fetchLimit = kFetchLimitMedium;
    }
    else
    {
        infoVC.fetchLimit = kFetchLimitMaximum;
    }
    [self.navigationController pushViewController:infoVC animated:YES];
}

@end
