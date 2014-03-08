//
//  SPLDashboardViewController.h
//  Snowpool
//
//  Created by Tim Ross on 8/03/14.
//  Copyright (c) 2014 Snowpool Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPLSignInViewController.h"
#import "SPLSettingsViewController.h"

@interface SPLDashboardViewController : UITableViewController<SPLSignInViewControllerDelegate, SPLSettingsViewControllerDelegate>

@end
