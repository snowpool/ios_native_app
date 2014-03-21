//
//  SPLNavigationController.m
//  Snowpool
//
//  Created by Tim Ross on 15/03/14.
//  Copyright (c) 2014 Snowpool Limited. All rights reserved.
//

#import "SPLNavigationController.h"

@interface SPLNavigationController ()

@end

@implementation SPLNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setNeedsStatusBarAppearanceUpdate];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
