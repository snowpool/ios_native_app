//
//  SPLSignInViewController.h
//  Snowpool
//
//  Created by Tim Ross on 8/03/14.
//  Copyright (c) 2014 Snowpool Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SPLSignInViewController;

@protocol SPLSignInViewControllerDelegate <NSObject>

- (void)signInViewControllerDidCancel:(SPLSignInViewController *)controller;
- (void)signInViewControllerDidSignIn:(SPLSignInViewController *)controller;

@end

@interface SPLSignInViewController : UITableViewController

@property (nonatomic, weak) id<SPLSignInViewControllerDelegate> delegate;
@property (nonatomic, weak) IBOutlet UITextField *emailTextField;
@property (nonatomic, weak) IBOutlet UITextField *passwordTextField;
@property (nonatomic, weak) IBOutlet UIButton *loginButton;

- (IBAction)cancelButtonPressed:(id)sender;
- (IBAction)signInButtonPressed:(id)sender;

@end
