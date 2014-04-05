//
//  SPLSelectFieldViewController.h
//  Snowpool
//
//  Created by Patrick Davey on 5/04/14.
//  Copyright (c) 2014 Snowpool Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SPLSelectFieldViewController;

@protocol SPLSelectFieldViewControllerDelegate <NSObject>

- (void)selectSkiFieldControllerDidChangeSkiField:(SPLSelectFieldViewController *)controller;

@end

@interface SPLSelectFieldViewController : UITableViewController

@property (nonatomic, weak) NSNumber *selectedSkiFieldID;
@property (nonatomic, weak) id<SPLSelectFieldViewControllerDelegate> delegate;

@end
