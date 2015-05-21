//
//  YVAddCityView.h
//  WeatherTest
//
//  Created by Юрий Воскресенский on 19.05.15.
//  Copyright (c) 2015 Юрий Воскресенский. All rights reserved.
//

#import "YVBaseView.h"

/** View for adding city */
@interface YVAddCityView : YVBaseView

@property (weak, nonatomic) IBOutlet UITableView *tableView;

/** Get user entered text */
- (NSString *)textFromTextField;

@end
