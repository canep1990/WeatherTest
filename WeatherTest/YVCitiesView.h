//
//  YVCitiesView.h
//  WeatherTest
//
//  Created by Юрий Воскресенский on 19.05.15.
//  Copyright (c) 2015 Юрий Воскресенский. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YVBaseView.h"
#import "CoreData+MagicalRecord.h"

@class YVWeatherModel;

/** Protocol for callbacks */
@protocol YVCitiesViewDelegate <NSObject>

/** Callback for selected model */
- (void)didSelectModel:(YVWeatherModel *)model;

@end

/** View class for displaying cities */
@interface YVCitiesView : YVBaseView <NSFetchedResultsControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

/** Delegate property */
@property (weak, nonatomic) id <YVCitiesViewDelegate> delegate;

/** Change editing style */
- (void)changeTableViewEditingStyle;

/** Reload table data */
- (void)reloadTableData;

@end
