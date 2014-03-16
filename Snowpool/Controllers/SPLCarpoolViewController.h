//
//  SPLCarpoolViewController.h
//  Snowpool
//
//  Created by Tim Ross on 8/03/14.
//  Copyright (c) 2014 Snowpool Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPLCarpool.h"

@interface SPLCarpoolViewController : UITableViewController<UIActionSheetDelegate>

@property (nonatomic, strong) SPLCarpool *carpool;
@property (nonatomic, weak) IBOutlet UILabel *dateLeavingLabel;
@property (nonatomic, weak) IBOutlet UILabel *dateReturningLabel;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *spacesLabel;
@property (nonatomic, weak) IBOutlet UILabel *telephoneLabel;
@property (nonatomic, weak) IBOutlet UILabel *drivenHereBeforeLabel;
@property (nonatomic, weak) IBOutlet UILabel *leavingFromLabel;
@property (nonatomic, weak) IBOutlet UITextView *notesTextView;

- (IBAction)actionButtonPressed:(id)sender;

@end
