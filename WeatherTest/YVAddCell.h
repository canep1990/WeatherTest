//
//  YVAddCell.h
//  WeatherTest
//
//  Created by Юрий Воскресенский on 19.05.15.
//  Copyright (c) 2015 Юрий Воскресенский. All rights reserved.
//

#import "YVBaseTableViewCell.h"

@interface YVAddCell : YVBaseTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleForCell;
@property (weak, nonatomic) IBOutlet UITextField *cityNameTextField;

@end
