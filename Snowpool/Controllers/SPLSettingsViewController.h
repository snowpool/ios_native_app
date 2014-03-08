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

@end

@interface SPLSettingsViewController : UITableViewController<SPLSelectCountryViewControllerDelegate>

@property (nonatomic, weak) id<SPLSettingsViewControllerDelegate> delegate;
@property (nonatomic, weak) IBOutlet UILabel *selectedCountryLabel;

- (IBAction)cancelButtonPressed:(id)sender;

@end
