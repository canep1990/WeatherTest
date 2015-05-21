//
//  YVTodayWeatherInfoView.m
//  WeatherTest
//
//  Created by Юрий Воскресенский on 19.05.15.
//  Copyright (c) 2015 Юрий Воскресенский. All rights reserved.
//

#import "YVTodayWeatherInfoView.h"
#import "YVStartingCell.h"
#import "YVWeatherModel.h"
#import "YVWeatherDescriptionModel.h"
#import "YVSimpleTextCell.h"
#import "YVDescriptionWeatherCell.h"

static NSString *const kHeaderCellReuseIndentifier = @"Cell";
static NSString *const kSelectableCellReuseIndentifier = @"Cell2";
static NSString *const kWeatherCellReuseIndentifier = @"Cell3";
static NSInteger const kRowHeightForWeatherDescriptionCell = 146;
static NSInteger const kRowHeightForStandardCell = 44;

@interface YVTodayWeatherInfoView() <UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@end

@implementation YVTodayWeatherInfoView

- (NSFetchedResultsController *)fetchedResultsController
{
    if (!_fetchedResultsController)
    {
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay ) fromDate:[NSDate date]];
        NSDate *startDate = [calendar dateFromComponents:components];
        [components setMonth:0];
        [components setDay:1];
        [components setYear:0];
        NSDate *endDate = [calendar dateByAddingComponents:components toDate:startDate options:0];
        NSPredicate *datePredicate = [NSPredicate predicateWithFormat:@"((date >= %@) AND (date < %@)) || (date = nil)",startDate, endDate];
        NSPredicate *cityPredicate = [NSPredicate predicateWithFormat:@"cityName == %@", self.weatherModel.cityName];
        NSCompoundPredicate *compoundPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[datePredicate, cityPredicate]];
        if (self.weatherModel.cityName)
        {
            _fetchedResultsController = [YVWeatherDescriptionModel MR_fetchAllSortedBy:@"date" ascending:NO withPredicate:compoundPredicate groupBy:nil delegate:nil inContext:[NSManagedObjectContext MR_contextForCurrentThread]];
        }
    }
    return _fetchedResultsController;
}

- (void)loadViewCustomization
{
    [self.tableView registerClass:[YVStartingCell class] forCellReuseIdentifier:kHeaderCellReuseIndentifier];
    [self.tableView registerClass:[YVSimpleTextCell class] forCellReuseIdentifier:kSelectableCellReuseIndentifier];
    [self.tableView registerClass:[YVSimpleTextCell class] forCellReuseIdentifier:kSelectableCellReuseIndentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"YVDescriptionWeatherCell" bundle:[NSBundle mainBundle]]forCellReuseIdentifier:kWeatherCellReuseIndentifier];
    [self fetchedResultsController];
}

- (void)awakeFromNib
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    view.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = view;
}

- (void)reloadTableData
{
    [self.fetchedResultsController performFetch:nil];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - table view datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self fetchedResultsController].fetchedObjects.count > 0)
        return 4;
    else
        return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        YVStartingCell *cell = (YVStartingCell *)[tableView dequeueReusableCellWithIdentifier:kHeaderCellReuseIndentifier];
        if (!cell)
        {
            cell = [[YVStartingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kHeaderCellReuseIndentifier];
        }
        [cell configureCellWithWeatherModel:self.weatherModel];
        return cell;
    }
    if (indexPath.row == 1)
    {
        YVDescriptionWeatherCell *cell = (YVDescriptionWeatherCell *)[tableView dequeueReusableCellWithIdentifier:kWeatherCellReuseIndentifier];
        if (!cell)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"YVDescriptionWeatherCell" owner:self options:nil];
            cell = (YVDescriptionWeatherCell *)[nib objectAtIndex:0];
        }
        [cell configureCellWithWeatherDescriptionModel:[self fetchedResultsController].fetchedObjects[0]];
        return cell;
    }
    if (indexPath.row == 2)
    {
        YVSimpleTextCell *cell = (YVSimpleTextCell *)[tableView dequeueReusableCellWithIdentifier:kSelectableCellReuseIndentifier];
        if (!cell)
        {
            cell = [[YVSimpleTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kSelectableCellReuseIndentifier];
        }
        [cell configureWithText:@"Прогноз на 3 дня"];
        return cell;
    }
    if (indexPath.row == 3)
    {
        YVSimpleTextCell *cell = (YVSimpleTextCell *)[tableView dequeueReusableCellWithIdentifier:kSelectableCellReuseIndentifier];
        if (!cell)
        {
            cell = [[YVSimpleTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kSelectableCellReuseIndentifier];
        }
        [cell configureWithText:@"Прогноз на 7 дней"];
        return cell;
    }
    UITableViewCell *cellToReturn = [[UITableViewCell alloc] init];
    return cellToReturn;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1)
    {
        return kRowHeightForWeatherDescriptionCell;
    }
    else
    {
        return kRowHeightForStandardCell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2 || indexPath.row == 3)
    {
        if (self.delegate)
        {
            YVWeatherDescriptionModel *model = [self fetchedResultsController].fetchedObjects[0];
            [self.delegate didSelectModel:model atIndex:indexPath.row];
        }
    }
}

@end
