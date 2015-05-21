//
//  YVAddCityViewController.m
//  WeatherTest
//
//  Created by Юрий Воскресенский on 19.05.15.
//  Copyright (c) 2015 Юрий Воскресенский. All rights reserved.
//

#import "YVAddCityViewController.h"
#import "YVAddCityView.h"
#import "YVWeatherModel.h"



@implementation YVAddCityViewController

- (void)loadView
{
    YVAddCityView *view = [[YVAddCityView alloc] init];
    self.view = view;
}

- (void)viewDidLoad
{
    self.title = @"Добавить город";
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(didCancel:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(didSave:)];
    self.navigationItem.rightBarButtonItem = saveButton;
}

- (void)didSave:(id)sender
{
    YVAddCityView *view = (YVAddCityView *)self.view;
    NSString *cityName = view.textFromTextField;
    if (cityName != nil && ![cityName isEqualToString:@""]) {
        self.createdModel.cityName = view.textFromTextField;
        if (self.delegate)
        {
            [self.delegate addCityViewDidAddCity];
        }
    } else {
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Ошибка" message:@"Заполните поле ввода названия города" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        [controller addAction:action];
        [self presentViewController:controller animated:YES completion:nil];
    }
}

- (void)didCancel:(id)sender
{
    [self.createdModel MR_deleteEntity];
    if (self.delegate)
    {
        [self.delegate addCityViewDidCancel];
    }
}

@end
