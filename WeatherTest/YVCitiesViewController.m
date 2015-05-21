//
//  YVCitiesViewController.m
//  WeatherTest
//
//  Created by Юрий Воскресенский on 19.05.15.
//  Copyright (c) 2015 Юрий Воскресенский. All rights reserved.
//

#import "YVCitiesViewController.h"
#import "YVCitiesView.h"
#import "YVWeatherModel.h"
#import "YVAddCityViewController.h"
#import "YVTodayWeatherInfoViewController.h"

static NSString * const kTitleString = @"Города";
static NSString * const kButtonTitle = @"Edit";

@interface YVCitiesViewController () <YVAddCityViewControllerDelegate, YVCitiesViewDelegate>

@end

@implementation YVCitiesViewController

- (void)loadView
{
    YVCitiesView *view = [[YVCitiesView alloc] init];
    view.delegate = self;
    self.view = view;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = kTitleString;
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(didAddEntity:)];
    self.navigationItem.rightBarButtonItem = addButton;
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithTitle:kButtonTitle style:UIBarButtonItemStyleDone target:self action:@selector(didChangeTableStyle:)];
    self.navigationItem.leftBarButtonItem = editButton;
}

- (void)didAddEntity:(id)sender
{
    YVAddCityViewController *addCityVC = [[YVAddCityViewController alloc] init];
    addCityVC.createdModel = [YVWeatherModel MR_createEntity];
    addCityVC.delegate = self;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:addCityVC];
    [self presentViewController:navController animated:YES completion:nil];
}

- (void)didChangeTableStyle:(id)sender
{
    YVCitiesView *view = (YVCitiesView *)self.view;
    [view changeTableViewEditingStyle];
}

#pragma mark - YVAddCityViewControllerDelegate

- (void)addCityViewDidCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addCityViewDidAddCity
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    YVCitiesView *view = (YVCitiesView *)self.view;
    [view reloadTableData];
}

#pragma mark - YVCitiesViewDelegate

- (void)didSelectModel:(YVWeatherModel *)model
{
    YVTodayWeatherInfoViewController *weatherVC = [[YVTodayWeatherInfoViewController alloc] init];
    weatherVC.weatherModel = model;
    [self.navigationController pushViewController:weatherVC animated:YES];
}

@end
