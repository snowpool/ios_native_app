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

@interface SPLSettingsViewController ()

@end

@implementation SPLSettingsViewController

#pragma mark -
#pragma mark View lifecycle methods

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

#pragma mark -
#pragma mark IBAction methods

- (IBAction)cancelButtonPressed:(id)sender
{
    [self.delegate settingsViewControllerDidCancel:self];
}

- (IBAction)signOutButtonPressed:(id)sender
{
    [self.delegate settingsViewControllerDidSignOut:self];
}

#pragma mark -
#pragma mark SPLSelectCountryViewControllerDelegate methods

- (void)selectCountryViewControllerDidChangeCountry:(SPLSelectCountryViewController *)controller
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
