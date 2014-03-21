//
//  SPLSendMessageViewController.m
//  Snowpool
//
//  Created by Tim Ross on 8/03/14.
//  Copyright (c) 2014 Snowpool Limited. All rights reserved.
//

#import "SPLSendMessageViewController.h"
#import "SPLCarpoolService.h"
#import "SPLUser.h"

@interface SPLSendMessageViewController ()

@property (nonatomic, strong) SPLCarpoolService *carpoolService;

@end

@implementation SPLSendMessageViewController

- (void)sendMessageWithText:(NSString *)message
{
    [SVProgressHUD showWithStatus:@"Sending Message"];
    [_carpoolService sendMessageToCarpoolWithID:self.carpoolID message:message
                                       success:^() {
                                           [SVProgressHUD dismiss];
                                           [self dismissViewControllerAnimated:YES completion:nil];
                                       } failure:^(NSError *error, NSInteger statusCode) {
                                           if (statusCode == 401) {
                                               [SVProgressHUD showErrorWithStatus:@"Cannot send message, has your password changed?"];
                                               [[SPLUser currentUser] signOut];
                                               [self dismissViewControllerAnimated:YES completion:nil];
                                           }else{
                                               [SVProgressHUD showErrorWithStatus:error.localizedDescription];
                                               NSLog(@"Error sending message: %@", error);
                                           }
                                       }];
}

#pragma mark -
#pragma mark View lifecycle methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.carpoolService = [[SPLCarpoolService alloc] init];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.textView becomeFirstResponder];
}

#pragma mark -
#pragma mark IBAction methods

- (IBAction)cancelButtonPressed:(id)sender
{
    [_carpoolService cancel];
    [SVProgressHUD dismiss];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)sendButtonPressed:(id)sender
{
    [self sendMessageWithText:self.textView.text];
}

@end
