//
//  SPLAppearance.m
//  Snowpool
//
//  Created by Tim Ross on 15/03/14.
//  Copyright (c) 2014 Snowpool Limited. All rights reserved.
//

#import "SPLAppearance.h"
#import "UIButton+Appearance.h"

@implementation SPLAppearance

+ (void)configure
{
    UIColor *blueColor = [UIColor colorWithRed:43.f/255.f green:128.f/255.f blue:255.f/255.f alpha:1.f];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [UINavigationBar appearance].barTintColor = blueColor;
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    [UISegmentedControl appearance].tintColor = blueColor;
    [UIButton appearance].tintColor = blueColor;
    
    UIFont *titleFont = [UIFont fontWithName:@"Avenir-Medium" size:17.0];
    UIFont *bodyFont = [UIFont fontWithName:@"Avenir-Book" size:16.0];
    
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSFontAttributeName: titleFont, NSForegroundColorAttributeName: [UIColor whiteColor]} forState:UIControlStateNormal];
    [UINavigationBar appearance].titleTextAttributes = @{NSFontAttributeName: titleFont, NSForegroundColorAttributeName: [UIColor whiteColor]};
    [[UISegmentedControl appearance] setTitleTextAttributes:@{NSFontAttributeName: bodyFont} forState:UIControlStateNormal];
    [UILabel appearanceWhenContainedIn:[UITableViewCell class], nil].font = bodyFont;
    [[UIButton appearance] spl_setTitleFont:bodyFont];
}

@end
