//
//  SPLDashboardViewController.h
//  Snowpool
//
//  Created by Tim Ross on 8/03/14.
//  Copyright (c) 2014 Snowpool Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPLSignInViewController.h"
#import "SPLAddCarpoolViewController.h"
#import "SPLSettingsViewController.h"
#import "SPLSelectCountryViewController.h"

@interface SPLDashboardViewController : UITableViewController<SPLSignInViewControllerDelegate, SPLAddCarpoolViewControllerDelegate, SPLSettingsViewControllerDelegate, SPLSelectCountryViewControllerDelegate>

- (IBAction)rightBarButtonItemPressed:(id)sender;

@end
