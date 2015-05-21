//
//  YVAddCityView.m
//  WeatherTest
//
//  Created by Юрий Воскресенский on 19.05.15.
//  Copyright (c) 2015 Юрий Воскресенский. All rights reserved.
//

#import "YVAddCityView.h"
#import "YVAddCell.h"

static NSString *const kCellReuseIndentifier = @"Cell";

@interface YVAddCityView() <UITableViewDataSource, UITableViewDelegate>

@end

@implementation YVAddCityView

- (void)loadViewCustomization
{
    [self.tableView registerNib:[UINib nibWithNibName:@"YVAddCell" bundle:[NSBundle mainBundle]]forCellReuseIdentifier:kCellReuseIndentifier];
}

- (NSString *)textFromTextField
{
    YVAddCell *cell = (YVAddCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
    UITextField *textField = cell.cityNameTextField;
    return textField.text;
}

- (void)awakeFromNib
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    view.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = view;
}

#pragma mark - table view datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YVAddCell *cell = (YVAddCell *)[tableView dequeueReusableCellWithIdentifier:kCellReuseIndentifier];
    if (!cell)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"YVAddCell" owner:self options:nil];
        cell = (YVAddCell *)[nib objectAtIndex:0];
    }
    return cell;
}

@end
