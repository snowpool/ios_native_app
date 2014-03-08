//
//  SPLAddCarpoolViewController.h
//  Snowpool
//
//  Created by Tim Ross on 8/03/14.
//  Copyright (c) 2014 Snowpool Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SPLAddCarpoolViewController;

@protocol SPLAddCarpoolViewControllerDelegate <NSObject>

- (void)addCarpoolViewControllerDidCancel:(SPLAddCarpoolViewController *)controller;
- (void)addCarpoolViewControllerDidAddCarpool:(SPLAddCarpoolViewController *)controller;

@end

@interface SPLAddCarpoolViewController : UITableViewController

@property (nonatomic, weak) id<SPLAddCarpoolViewControllerDelegate> delegate;

- (IBAction)cancelButtonPressed:(id)sender;
- (IBAction)viewWasTapped:(id)sender;

@end
