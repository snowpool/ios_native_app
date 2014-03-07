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

- (IBAction)cancelButtonPressed:(id)sender
{
    [self.delegate sendMessageViewControllerDidSelectCancel:self];
}

- (IBAction)sendButtonPressed:(id)sender
{
    [self.delegate sendMessageViewController:self didSelectSendWithMessage:@"Test"];
}

@end
