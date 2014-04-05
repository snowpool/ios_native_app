//
//  SPLSelectDateViewController.h
//  Snowpool
//
//  Created by Patrick Davey on 5/04/14.
//  Copyright (c) 2014 Snowpool Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SPLSelectDateViewController;

@protocol SPLSelectDateViewControllerDelegate <NSObject>

- (void)selectDateViewControllerDidChangeNumberOfSpaces:(SPLSelectDateViewController *)controller;

@end

@interface SPLSelectDateViewController : UITableViewController

@property (nonatomic, weak) NSString *dateTypeToSelect;
@property (nonatomic, weak) id<SPLSelectDateViewControllerDelegate> delegate;

@end