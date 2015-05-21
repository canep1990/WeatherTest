//
//  YVBaseSelectableTableViewCell.m
//  WeatherTest
//
//  Created by Юрий Воскресенский on 19.05.15.
//  Copyright (c) 2015 Юрий Воскресенский. All rights reserved.
//

#import "YVBaseSelectableTableViewCell.h"
#import "YVWeatherModel.h"

@implementation YVBaseSelectableTableViewCell


- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    if (highlighted)
    {
        self.backgroundColor = [UIColor lightGrayColor];
    }
    else
    {
        [UIView animateWithDuration:0.3 animations:^{
            self.backgroundColor = [UIColor whiteColor];
        }];
    }
}

@end
