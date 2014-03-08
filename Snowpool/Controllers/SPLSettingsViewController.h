//
//  SPLSettingsViewController.h
//  Snowpool
//
//  Created by Patrick Davey on 8/03/14.
//  Copyright (c) 2014 Snowpool Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SPLSettingsViewController;

@protocol SPLSettingsViewControllerDelegate <NSObject>

- (void)settingsViewControllerDidCancel:(SPLSettingsViewController *)controller;

@end

@interface SPLSettingsViewController : UITableViewController

@property (nonatomic, weak) id<SPLSettingsViewControllerDelegate> delegate;

- (IBAction)cancelButtonPressed:(id)sender;

@end
