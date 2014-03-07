//
//  SPLCarpoolViewController.m
//  Snowpool
//
//  Created by Tim Ross on 8/03/14.
//  Copyright (c) 2014 Snowpool Limited. All rights reserved.
//

#import "SPLCarpoolViewController.h"

@interface SPLCarpoolViewController ()

@end

@implementation SPLCarpoolViewController

NSString * const kCarpoolActionSendMessage = @"Send Message";

#pragma mark -
#pragma mark View lifecycle methods

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"SendMessage"]) {
        UINavigationController *navController = segue.destinationViewController;
        SPLSendMessageViewController *controller = (SPLSendMessageViewController *)navController.topViewController;
        controller.delegate = self;
    }
}

#pragma mark -
#pragma mark IBAction methods

- (IBAction)actionButtonPressed:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:kCarpoolActionSendMessage, nil];
    [actionSheet showFromBarButtonItem:(UIBarButtonItem *)sender animated:YES];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:kCarpoolActionSendMessage]) {
        [self performSegueWithIdentifier:@"SendMessage" sender:self];
    }
}

#pragma mark -
#pragma mark SPLSendMessageViewControllerDelegate methods

- (void)sendMessageViewControllerDidSelectCancel:(SPLSendMessageViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sendMessageViewController:(SPLSendMessageViewController *)controller didSelectSendWithMessage:(NSString *)message
{
    NSLog(@"Send message with text: %@", message);
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
