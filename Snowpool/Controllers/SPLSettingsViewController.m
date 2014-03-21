//
//  SPLSettingsViewController.m
//  Snowpool
//
//  Created by Patrick Davey on 8/03/14.
//  Copyright (c) 2014 Snowpool Limited. All rights reserved.
//

#import "SPLSettingsViewController.h"
#import "SPLCountry.h"
#import "SPLUserDefaults.h"
#import "SPLUser.h"

@interface SPLSettingsViewController ()

@end

@implementation SPLSettingsViewController

#pragma mark -
#pragma mark View lifecycle methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (![SPLUser currentUser].isAuthenticated) {
        self.navigationItem.rightBarButtonItem = nil;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSNumber *selectedCountryKey = [SPLUserDefaults standardUserDefaults].selectedCountryKey;
    if (selectedCountryKey) {
        self.selectedCountryLabel.text = [SPLCountry all][selectedCountryKey];
    }
    
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    self.appVersionLabel.text = version;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"SelectCountry"]) {
        SPLSelectCountryViewController *controller = segue.destinationViewController;
        controller.delegate = self;
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

#pragma mark -
#pragma mark IBAction methods

- (IBAction)doneButtonPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)signOutButtonPressed:(id)sender
{
    [[SPLUser currentUser] signOut];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark SPLSelectCountryViewControllerDelegate methods

- (void)selectCountryViewControllerDidChangeCountry:(SPLSelectCountryViewController *)controller
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
