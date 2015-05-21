//
//  AppDelegate.m
//  WeatherTest
//
//  Created by Юрий Воскресенский on 19.05.15.
//  Copyright (c) 2015 Юрий Воскресенский. All rights reserved.
//

#import "YVAppDelegate.h"
#import "CoreData+MagicalRecord.h"
#import "YVWeatherModel.h"
#import "YVCitiesViewController.h"

static NSString * const kCreateOnceDefaultsKey = @"CreateOnceDefaultsKey";
static NSString * const kCoreDataName = @"WeatherTest";
static NSString * const kSaintPetersburgName = @"Санкт-Петербург";
static NSString * const kMoscowName = @"Москва";

@interface YVAppDelegate ()

/** Method helper for loading default data to core data */
- (void)loadDefaultData;

@end

@implementation YVAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];

    [MagicalRecord setupCoreDataStackWithStoreNamed:kCoreDataName];
    [self loadDefaultData];
    
    YVCitiesViewController *cityVC = [[YVCitiesViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:cityVC];
    self.window.rootViewController = navController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application 
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
}

- (void)loadDefaultData
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults boolForKey:kCreateOnceDefaultsKey])
    {
        YVWeatherModel *model1 = [YVWeatherModel MR_createEntity];
        model1.cityName = kSaintPetersburgName;
        YVWeatherModel *model2 = [YVWeatherModel MR_createEntity];
        model2.cityName = kMoscowName;
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        [defaults setBool:YES forKey:kCreateOnceDefaultsKey];
        [defaults synchronize];
    }
}

@end
