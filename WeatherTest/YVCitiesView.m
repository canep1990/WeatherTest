//
//  YVCitiesView.m
//  WeatherTest
//
//  Created by Юрий Воскресенский on 19.05.15.
//  Copyright (c) 2015 Юрий Воскресенский. All rights reserved.
//

#import "YVCitiesView.h"
#import "YVWeatherModel.h"
#import "YVStartingCell.h"
#import "YVTodayWeatherInfoViewController.h"

static NSString *const kCellReuseIndentifier = @"Cell333";

static NSString *const kSortKey = @"cityName";

@interface YVCitiesView() <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@end

@implementation YVCitiesView

- (NSFetchedResultsController *)fetchedResultsController
{
    if (!_fetchedResultsController)
    {
        NSFetchRequest *request = [YVWeatherModel MR_requestAllSortedBy:kSortKey ascending:YES];
        _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:[NSManagedObjectContext MR_defaultContext] sectionNameKeyPath:nil cacheName:nil];
        [_fetchedResultsController performFetch:nil];
        _fetchedResultsController.delegate = self;
    }
    return _fetchedResultsController;
}

- (void)dealloc
{
    self.fetchedResultsController.delegate = nil;
}

- (void)changeTableViewEditingStyle
{
    [self.tableView setEditing:!self.tableView.editing animated:YES];
}

- (void)reloadTableData
{
    [self.fetchedResultsController performFetch:nil];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)awakeFromNib
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    view.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = view;
}

- (void)loadViewCustomization
{
    [self.tableView registerClass:[YVStartingCell class] forCellReuseIdentifier:kCellReuseIndentifier];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self fetchedResultsController].fetchedObjects && [self fetchedResultsController].fetchedObjects.count > 0) return [self fetchedResultsController].fetchedObjects.count;
    else return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YVStartingCell *cell = (YVStartingCell *)[tableView dequeueReusableCellWithIdentifier:kCellReuseIndentifier];
    if (!cell)
    {
        cell = [[YVStartingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellReuseIndentifier];
    }
    YVWeatherModel *currentWeatherModel = [[self fetchedResultsController].fetchedObjects objectAtIndex:indexPath.row];
    [cell configureCellWithWeatherModel:currentWeatherModel];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YVWeatherModel *currentWeatherModel = [[self fetchedResultsController].fetchedObjects objectAtIndex:indexPath.row];
    if (self.delegate)
    {
        [self.delegate didSelectModel:currentWeatherModel];
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        YVWeatherModel *poo = [[self fetchedResultsController] objectAtIndexPath:indexPath];
        [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
            YVWeatherModel *localPoo = [poo MR_inContext:localContext];
            [localPoo MR_deleteEntity];
        }];
    }
}

#pragma mark - NSFetchedResultsController delegate methods

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    YVWeatherModel *model = (YVWeatherModel *)anObject;
    switch (type)
    {
        case NSFetchedResultsChangeInsert:
        {
            if (model != nil)
            {
                [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            }
        }
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        case NSFetchedResultsChangeUpdate:
        {
            YVWeatherModel *model = [[self fetchedResultsController] objectAtIndexPath:indexPath];
            YVStartingCell *cell = (YVStartingCell *)[self.tableView cellForRowAtIndexPath:indexPath];
            [cell configureCellWithWeatherModel:model];
        }
            break;
        case NSFetchedResultsChangeMove:
        {
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject: newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
            break;
            
        default:
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch (type)
    {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        default:
            break;
    }
}

@end
