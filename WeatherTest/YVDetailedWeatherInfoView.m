//
//  YVDetailedWeatherInfoView.m
//  WeatherTest
//
//  Created by Юрий Воскресенский on 20.05.15.
//  Copyright (c) 2015 Юрий Воскресенский. All rights reserved.
//

#import "YVDetailedWeatherInfoView.h"
#import "YVDescriptionWeatherCell.h"
#import "YVWeatherDescriptionModel.h"

static NSString *const kWeatherCellReuseIndentifier = @"Cell3";
static NSInteger const kRowHeightForWeatherDescriptionCell = 146;

@interface YVDetailedWeatherInfoView()

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@end

@implementation YVDetailedWeatherInfoView

- (NSFetchedResultsController *)fetchedResultsController
{
    if (!_fetchedResultsController)
    {
        NSPredicate *cityPredicate = [NSPredicate predicateWithFormat:@"cityName == %@", self.weatherModel.cityName];
        if (self.weatherModel.cityName)
        {
            NSFetchRequest *request = [YVWeatherDescriptionModel MR_requestAllSortedBy:@"date" ascending:YES withPredicate:cityPredicate];
            request.fetchLimit = self.fetchLimit;
            _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:[NSManagedObjectContext MR_contextForCurrentThread] sectionNameKeyPath:nil cacheName:nil];
            [_fetchedResultsController performFetch:nil];
        }
    }
    return _fetchedResultsController;
}

- (void)loadViewCustomization
{
    [self.tableView registerNib:[UINib nibWithNibName:@"YVDescriptionWeatherCell" bundle:[NSBundle mainBundle]]forCellReuseIdentifier:kWeatherCellReuseIndentifier];
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
    return [self fetchedResultsController].fetchedObjects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YVDescriptionWeatherCell *cell = (YVDescriptionWeatherCell *)[tableView dequeueReusableCellWithIdentifier:kWeatherCellReuseIndentifier];
    if (!cell)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"YVDescriptionWeatherCell" owner:self options:nil];
        cell = (YVDescriptionWeatherCell *)[nib objectAtIndex:0];
    }
    [cell configureCellWithWeatherDescriptionModel:[self fetchedResultsController].fetchedObjects[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kRowHeightForWeatherDescriptionCell;
}

@end