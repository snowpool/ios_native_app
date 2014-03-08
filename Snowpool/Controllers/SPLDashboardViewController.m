//
//  SPLDashboardViewController.m
//  Snowpool
//
//  Created by Tim Ross on 8/03/14.
//  Copyright (c) 2014 Snowpool Limited. All rights reserved.
//

#import "SPLDashboardViewController.h"
#import "SPLUserDefaults.h"

@interface SPLDashboardViewController ()

@end

@implementation SPLDashboardViewController

#pragma mark -
#pragma mark View lifecycle methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self
                            action:@selector(tableViewDidStartRefresh:)
                  forControlEvents:UIControlEventValueChanged];
    
    if ([SPLUserDefaults standardUserDefaults].selectedCountryKey == nil) {
        [self performSegueWithIdentifier:@"SelectCountry" sender:self];
    }
}

- (void)tableViewDidStartRefresh:(UIRefreshControl *)refreshControl
{
    [self.refreshControl endRefreshing];
}

@end
