//
//  YVBaseView.m
//  WeatherTest
//
//  Created by Юрий Воскресенский on 19.05.15.
//  Copyright (c) 2015 Юрий Воскресенский. All rights reserved.
//

#import "YVBaseView.h"

@interface YVBaseView ()

- (void)loadViewCustomization;

@end

@implementation YVBaseView

- (instancetype)init
{
    NSArray *xib = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
    [self loadViewCustomization];
    return xib[0];
}

- (void)loadViewCustomization
{
    
}

@end
