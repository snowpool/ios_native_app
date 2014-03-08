//
//  SPLSettingsViewController.h
//  Snowpool
//
//  Created by Patrick Davey on 8/03/14.
//  Copyright (c) 2014 Snowpool Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPLSelectCountryViewController.h"

@class SPLSettingsViewController;

@protocol SPLSettingsViewControllerDelegate <NSObject>

- (void)settingsViewControllerDidCancel:(SPLSettingsViewController *)controller;
- (void)settingsViewControllerDidSignOut:(SPLSettingsViewController *)controller;

@end

@interface SPLSettingsViewController : UITableViewController<SPLSelectCountryViewControllerDelegate>

@property (nonatomic, weak) id<SPLSettingsViewControllerDelegate> delegate;
@property (nonatomic, weak) IBOutlet UILabel *selectedCountryLabel;
@property (nonatomic, weak) IBOutlet UILabel *appVersionLabel;

- (IBAction)cancelButtonPressed:(id)sender;
- (IBAction)signOutButtonPressed:(id)sender;

@end
