//
//  SPLCarpoolViewController.h
//  Snowpool
//
//  Created by Tim Ross on 8/03/14.
//  Copyright (c) 2014 Snowpool Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPLSendMessageViewController.h"
#import "SPLCarpool.h"

@interface SPLCarpoolViewController : UIViewController<UIActionSheetDelegate, SPLSendMessageViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) SPLCarpool *carpool;

- (IBAction)actionButtonPressed:(id)sender;

@end
