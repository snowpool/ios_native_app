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
    
    return YES;
}

@end
