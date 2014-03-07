//
//  SPLSendMessageViewController.m
//  Snowpool
//
//  Created by Tim Ross on 8/03/14.
//  Copyright (c) 2014 Snowpool Limited. All rights reserved.
//

#import "SPLSendMessageViewController.h"

@interface SPLSendMessageViewController ()

@end

@implementation SPLSendMessageViewController

#pragma mark -
#pragma mark View lifecycle methods

- (void)viewDidLoad
{
    [super viewDidLoad];
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
    [self.delegate sendMessageViewControllerDidSelectCancel:self];
}

- (IBAction)sendButtonPressed:(id)sender
{
    [self.delegate sendMessageViewController:self didSelectSendWithMessage:self.textView.text];
}

@end
