//
//  SPLAddCarpoolViewController.h
//  Snowpool
//
//  Created by Tim Ross on 8/03/14.
//  Copyright (c) 2014 Snowpool Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPLSpacesFreeViewController.h"
#import "SPLSelectDateViewController.h"

@interface SPLAddCarpoolViewController : UITableViewController<SPLSpacesFreeViewControllerDelegate, SPLSelectDateViewControllerDelegate >

@property (nonatomic, weak) IBOutlet UISwitch *carpoolWanted;
@property (nonatomic, weak) IBOutlet UISwitch *drivenHereBefore;
@property (nonatomic, weak) IBOutlet UITextField *leavingFrom;
@property (nonatomic, weak) IBOutlet UITextField *telephone;
@property (nonatomic, weak) IBOutlet UITextView *message;
@property (weak, nonatomic) IBOutlet UILabel *spacesFree;


- (IBAction)cancelButtonPressed:(id)sender;
- (IBAction)doneButtonPressed:(id)sender;
- (IBAction)viewWasTapped:(id)sender;

@end
