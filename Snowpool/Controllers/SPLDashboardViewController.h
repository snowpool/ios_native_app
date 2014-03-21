//
//  SPLDashboardViewController.h
//  Snowpool
//
//  Created by Tim Ross on 8/03/14.
//  Copyright (c) 2014 Snowpool Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPLSelectCountryViewController.h"

@interface SPLDashboardViewController : UITableViewController<SPLSelectCountryViewControllerDelegate>

@property (nonatomic, weak) IBOutlet UISegmentedControl *filter;

- (IBAction)rightBarButtonItemPressed:(id)sender;
- (IBAction)filterValueChanged:(id)sender;

@end
