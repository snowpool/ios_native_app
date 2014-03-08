//
//  SPLSettingsViewController.m
//  Snowpool
//
//  Created by Patrick Davey on 8/03/14.
//  Copyright (c) 2014 Snowpool Limited. All rights reserved.
//

#import "SPLSettingsViewController.h"

@interface SPLSettingsViewController ()

@end

@implementation SPLSettingsViewController

- (IBAction)cancelButtonPressed:(id)sender
{
    [self.delegate settingsViewControllerDidCancel:self];
}

@end
