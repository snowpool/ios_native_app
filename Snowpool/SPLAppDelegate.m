//
//  SPLAppDelegate.m
//  Snowpool
//
//  Created by Tim Ross on 8/03/14.
//  Copyright (c) 2014 Snowpool Limited. All rights reserved.
//

#import "SPLAppDelegate.h"
#import "SPLAppearance.h"
#import <SVProgressHUD/SVProgressHUD.h>

@implementation SPLAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [SPLAppearance configure];
    
    [[SPLAnalytics sharedInstance] startSession];
    
    return YES;
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [[SPLAnalytics sharedInstance] startSession];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[SPLAnalytics sharedInstance] endSession];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [[SPLAnalytics sharedInstance] endSession];
}

@end
