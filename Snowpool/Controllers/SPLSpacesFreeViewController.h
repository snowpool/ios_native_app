//
//  SPLSpacesFreeViewController.h
//  Snowpool
//
//  Created by Patrick Davey on 5/04/14.
//  Copyright (c) 2014 Snowpool Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SPLSpacesFreeViewController;

@protocol SPLSpacesFreeViewControllerDelegate <NSObject>

- (void)spacesFreeViewControllerDidChangeNumberOfSpaces:(SPLSpacesFreeViewController *)controller;

@end

@interface SPLSpacesFreeViewController : UITableViewController

@property(nonatomic, assign) int spacesFree;
@property (nonatomic, weak) id<SPLSpacesFreeViewControllerDelegate> delegate;

@end
