//
//  SPLSignInViewController.m
//  Snowpool
//
//  Created by Tim Ross on 8/03/14.
//  Copyright (c) 2014 Snowpool Limited. All rights reserved.
//

#import "SPLSignInViewController.h"
#import "SPLAuthService.h"
#import "SPLUser.h"

@interface SPLSignInViewController ()

@property (nonatomic, strong) SPLAuthService *authService;

@end

@implementation SPLSignInViewController

- (void)signInWithEmail:(NSString *)email password:(NSString *)password
{
    self.loginButton.enabled = NO;
    [SVProgressHUD showWithStatus:@"Signing In"];
    [_authService loginWithEmail:email password:password
      success:^(NSString *token, NSInteger userID) {
          [[SPLUser currentUser] signInWithUserID:userID token: token];
          [SVProgressHUD dismiss];
          [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSError *error, NSInteger statusCode) {
        if (statusCode == 401) {
            [SVProgressHUD showErrorWithStatus:@"Incorrect Email or Password"];
        } else {
            [SVProgressHUD showErrorWithStatus:error.localizedDescription];
        }
        self.loginButton.enabled = YES;
        NSLog(@"Error signing in: %@", error);
    }];
}

#pragma mark -
#pragma mark View lifecycle methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.authService = [[SPLAuthService alloc] init];
    [self.emailTextField becomeFirstResponder];
    
    [[SPLAnalytics sharedInstance] sendScreenView:@"Sign In"];
}

- (IBAction)cancelButtonPressed:(id)sender
{
    [_authService cancel];
    [SVProgressHUD dismiss];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)signInButtonPressed:(id)sender
{
    [self signInWithEmail:self.emailTextField.text password:self.passwordTextField.text];
}

@end
