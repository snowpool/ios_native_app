//
//  SPLSendMessageViewController.h
//  Snowpool
//
//  Created by Tim Ross on 8/03/14.
//  Copyright (c) 2014 Snowpool Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPLSendMessageViewController : UIViewController

@property (nonatomic, assign) NSInteger carpoolID;
@property (nonatomic, weak) IBOutlet UITextView *textView;

- (IBAction)cancelButtonPressed:(id)sender;
- (IBAction)sendButtonPressed:(id)sender;

@end
