//
//  SPLAppDelegate.m
//  Snowpool
//
//  Created by Tim Ross on 8/03/14.
//  Copyright (c) 2014 Snowpool Limited. All rights reserved.
//

#import "SPLAppDelegate.h"
#import <SVProgressHUD/SVProgressHUD.h>

@implementation SPLAppDelegate

- (void)configureAppearance
{
    UIColor *blueColor = [UIColor colorWithRed:43.f/255.f green:128.f/255.f blue:255.f/255.f alpha:1.f];
    
    [UINavigationBar appearance].tintColor = blueColor;
    [UISegmentedControl appearance].tintColor = blueColor;
    [UIButton appearance].tintColor = blueColor;
    
    UIFont *titleFont = [UIFont fontWithName:@"Avenir-Medium" size:17.0];
    UIFont *bodyFont = [UIFont fontWithName:@"Avenir-Book" size:17.0];
    UIFont *optionFont = [UIFont fontWithName:@"Avenir-Book" size:16.0];
    
    [[UISegmentedControl appearance] setTitleTextAttributes:@{NSFontAttributeName: optionFont} forState:UIControlStateNormal];
    [[UILabel appearanceWhenContainedIn:[UITableViewCell class], nil] setFont:bodyFont];
    [[UILabel appearanceWhenContainedIn:[UIButton class], nil] setFont:bodyFont];
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSFontAttributeName: titleFont} forState:UIControlStateNormal];
    [UINavigationBar appearance].titleTextAttributes = @{NSFontAttributeName: titleFont};
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self configureAppearance];
    
    return YES;
}

@end
