//
//  SPLAppDelegate.m
//  Snowpool
//
//  Created by Tim Ross on 8/03/14.
//  Copyright (c) 2014 Snowpool Limited. All rights reserved.
//

#import "SPLAppDelegate.h"

@implementation SPLAppDelegate

- (void)configureAppearance
{
    UIColor *blueColor = [UIColor colorWithRed:43.f/255.f green:128.f/255.f blue:255.f/255.f alpha:1.f];
    [UINavigationBar appearance].tintColor = blueColor;
    [UISegmentedControl appearance].tintColor = blueColor;
    [UIButton appearance].tintColor = blueColor;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self configureAppearance];
    
    return YES;
}

@end
