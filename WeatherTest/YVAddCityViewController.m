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

static NSString * const kTitle = @"Добавить город";
static NSString * const kOKButtonTitle = @"OK";
static NSString * const kCancelButtonTitle = @"Cancel";
static NSString * const kSaveButtonTitle = @"Save";
static NSString * const kErrorMessage = @"Ошибка";
static NSString * const kErrorMessageDescription = @"Заполните поле ввода или введите верное название города";
static NSString * const kStringForCharacterSet = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZйцукенгшщзхъёфывапролджэячсмитьбюЙЦУКЕНГШЩЗХЪЁФЫВАПРОЛДЖЭЯЧСМИТЬБЮ";

@implementation YVAddCityViewController

- (void)loadView
{
    YVAddCityView *view = [[YVAddCityView alloc] init];
    self.view = view;
}

- (void)viewDidLoad
{
    self.title = kTitle;
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:kCancelButtonTitle style:UIBarButtonItemStyleDone target:self action:@selector(didCancel:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:kSaveButtonTitle style:UIBarButtonItemStyleDone target:self action:@selector(didSave:)];
    self.navigationItem.rightBarButtonItem = saveButton;
}

- (void)didSave:(id)sender
{
    YVAddCityView *view = (YVAddCityView *)self.view;
    NSString *cityName = view.textFromTextField;
    if (cityName != nil && ![cityName isEqualToString:@""] && [self validateTextInput:cityName]) {
        self.createdModel.cityName = view.textFromTextField;
        if (self.delegate)
        {
            [self.delegate addCityViewDidAddCity];
        }
    } else {
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:kErrorMessage message:kErrorMessageDescription preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:kOKButtonTitle style:UIAlertActionStyleCancel handler:nil];
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

- (BOOL)validateTextInput:(NSString *)string
{
    BOOL isValid = NO;
    NSCharacterSet *s = [NSCharacterSet characterSetWithCharactersInString:kStringForCharacterSet];
    NSCharacterSet *illegalCharacterSet = [s invertedSet];
    NSRange range = [string rangeOfCharacterFromSet:illegalCharacterSet];
    if (range.location == NSNotFound)
    {
        isValid = YES;
    }
    return isValid;
}

@end
