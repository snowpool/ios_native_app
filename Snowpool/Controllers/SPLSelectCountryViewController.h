//
//  SPLSelectCountryViewController.h
//  Snowpool
//
//  Created by Patrick Davey on 8/03/14.
//  Copyright (c) 2014 Snowpool Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SPLSelectCountryViewController;

@protocol SPLSelectCountryViewControllerDelegate <NSObject>

- (void)selectCountryViewControllerDidChangeCountry:(SPLSelectCountryViewController *)controller;

@end

@interface SPLSelectCountryViewController : UITableViewController

@property (nonatomic, weak) id<SPLSelectCountryViewControllerDelegate> delegate;

@end
