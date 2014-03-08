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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"SignIn"]) {
        UINavigationController *navController = segue.destinationViewController;
        SPLSignInViewController *controller = (SPLSignInViewController *)navController.topViewController;
        controller.delegate = self;
    } else if ([segue.identifier isEqualToString:@"Settings"]) {
        UINavigationController *navController = segue.destinationViewController;
        SPLSettingsViewController *controller = (SPLSettingsViewController *)navController.topViewController;
        controller.delegate = self;
    } else if ([segue.identifier isEqualToString:@"SelectCountry"]) {
        UINavigationController *navController = segue.destinationViewController;
        SPLSelectCountryViewController *controller = (SPLSelectCountryViewController *)navController.topViewController;
        controller.delegate = self;
    }
}

- (void)tableViewDidStartRefresh:(UIRefreshControl *)refreshControl
{
    [self.refreshControl endRefreshing];
}

#pragma mark -
#pragma mark SPLSignInViewControllerDelegate methods

- (void)signInViewControllerDidCancel:(SPLSignInViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)signInViewControllerDidSignIn:(SPLSignInViewController *)controller
{
    NSLog(@"User did sign in");
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark SPLSettingsViewControllerDelegate methods

- (void)settingsViewControllerDidCancel:(SPLSettingsViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark SPLSelectCountryViewControllerDelegate methods

- (void)selectCountryViewControllerDidChangeCountry:(SPLSelectCountryViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
