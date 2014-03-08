//
//  SPLSignInViewController.m
//  Snowpool
//
//  Created by Tim Ross on 8/03/14.
//  Copyright (c) 2014 Snowpool Limited. All rights reserved.
//

#import "SPLSignInViewController.h"
#import "SPLUser.h"

@interface SPLSignInViewController ()

@end

@implementation SPLSignInViewController

#pragma mark -
#pragma mark View lifecycle methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.emailTextField becomeFirstResponder];
}

- (IBAction)cancelButtonPressed:(id)sender
{
    [self.delegate signInViewControllerDidCancel:self];
}

- (IBAction)signInButtonPressed:(id)sender
{
    [[SPLUser currentUser] signInWithToken:@"1234567890"];
    [self.delegate signInViewControllerDidSignIn:self];
}

@end
