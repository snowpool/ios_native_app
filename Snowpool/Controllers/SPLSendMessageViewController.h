//
//  SPLSendMessageViewController.h
//  Snowpool
//
//  Created by Tim Ross on 8/03/14.
//  Copyright (c) 2014 Snowpool Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SPLSendMessageViewController;

@protocol SPLSendMessageViewControllerDelegate <NSObject>

- (void)sendMessageViewControllerDidSelectCancel:(SPLSendMessageViewController *)controller;
- (void)sendMessageViewController:(SPLSendMessageViewController *)controller didSelectSendWithMessage:(NSString *)message;

@end

@interface SPLSendMessageViewController : UIViewController

@property (nonatomic, weak) id<SPLSendMessageViewControllerDelegate> delegate;
@property (nonatomic, weak) IBOutlet UITextView *textView;

- (IBAction)cancelButtonPressed:(id)sender;
- (IBAction)sendButtonPressed:(id)sender;

@end
