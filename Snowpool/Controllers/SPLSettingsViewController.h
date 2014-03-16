//
//  SPLSettingsViewController.h
//  Snowpool
//
//  Created by Patrick Davey on 8/03/14.
//  Copyright (c) 2014 Snowpool Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPLSelectCountryViewController.h"

@interface SPLSettingsViewController : UITableViewController<SPLSelectCountryViewControllerDelegate>

@property (nonatomic, weak) IBOutlet UILabel *selectedCountryLabel;
@property (nonatomic, weak) IBOutlet UILabel *appVersionLabel;

- (IBAction)doneButtonPressed:(id)sender;
- (IBAction)signOutButtonPressed:(id)sender;

@end
