//
//  SPLCarpoolViewController.m
//  Snowpool
//
//  Created by Tim Ross on 8/03/14.
//  Copyright (c) 2014 Snowpool Limited. All rights reserved.
//

#import "SPLCarpoolViewController.h"
#import "SPLUser.h"
#import "SPLSendMessageViewController.h"
#import "SPLCarpoolService.h"

@interface SPLCarpoolViewController ()

@property (nonatomic, strong) NSArray *carpoolDetails;
@property (nonatomic, strong) SPLCarpoolService *carpoolService;

@end

@implementation SPLCarpoolViewController

NSString * const kCarpoolActionSendMessage = @"Send Message";
NSString * const kCarpoolActionDelete = @"Delete";

- (void)displayCarpool
{
    self.dateLeavingLabel.text = self.carpool.start;
    self.dateReturningLabel.text = self.carpool.dateReturning;
    self.nameLabel.text = self.carpool.name;
    self.spacesLabel.text = [NSString stringWithFormat:@"%d", self.carpool.spacesFree];
    self.telephoneLabel.text = self.carpool.telephone;
    self.drivenHereBeforeLabel.text = self.carpool.hasDrivenBefore ? @"Yes" : @"No";
    self.leavingFromLabel.text = self.carpool.leavingFrom;
    self.notesTextView.text = self.carpool.message;
}

#pragma mark -
#pragma mark View lifecycle methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.carpoolService = [[SPLCarpoolService alloc] init];
    
    [self displayCarpool];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"SendMessage"]) {
        UINavigationController *navController = segue.destinationViewController;
        SPLSendMessageViewController *controller = (SPLSendMessageViewController *)navController.topViewController;
        controller.carpoolID = self.carpool.carpoolID;
    }else if ([segue.identifier isEqualToString:@"Delete"]) {
        [SVProgressHUD showWithStatus:@"Deleting Carpool"];
        [_carpoolService deleteCarpoolWithID:self.carpool.carpoolID
                                     success:^() {
                                         [SVProgressHUD dismiss];
                                         [self dismissViewControllerAnimated:YES completion:nil];
                                     } failure:^(NSError *error, NSInteger statusCode) {
                                         if (statusCode == 401) {
                                             [SVProgressHUD showErrorWithStatus:@"Cannot delete carpool, has your password changed?"];
                                             [[SPLUser currentUser] signOut];
                                             [self dismissViewControllerAnimated:YES completion:nil];
                                         }else{
                                             [SVProgressHUD showErrorWithStatus:error.localizedDescription];
                                             NSLog(@"Error deleting carpool: %@", error);
                                         }
                                         
                                     }];
    }
}

#pragma mark -
#pragma mark UITableView methods

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return [NSString stringWithFormat:@"Carpool To %@", self.carpool.fieldName];
    } else {
        return @"Notes";
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && self.carpool.message.length > 0) {
        CGRect textRect = [self.carpool.message boundingRectWithSize:CGSizeMake(self.notesTextView.frame.size.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: self.notesTextView.font} context:nil];
        return textRect.size.height + 28;
    } else {
        return 44.f;
    }
}

#pragma mark -
#pragma mark IBAction methods

- (IBAction)actionButtonPressed:(id)sender
{
    UIActionSheet *actionSheet = nil;
    if (![SPLUser currentUser].isAuthenticated) {
        actionSheet = [[UIActionSheet alloc] initWithTitle:@"You must sign in (or sign up on snowpool.org) to send a message"
                                                  delegate:self cancelButtonTitle:@"Cancel"
                                    destructiveButtonTitle:nil otherButtonTitles:nil, nil];
    }else if (self.carpool.userID == [SPLUser currentUser].userID){
        actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:kCarpoolActionDelete otherButtonTitles:nil, nil];
    } else {
        actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:kCarpoolActionSendMessage, nil];
    }
    [actionSheet showFromBarButtonItem:(UIBarButtonItem *)sender animated:YES];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:kCarpoolActionSendMessage]) {
        [self performSegueWithIdentifier:@"SendMessage" sender:self];
    } else if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:kCarpoolActionDelete]) {
        [self performSegueWithIdentifier:@"Delete" sender:self];
    }
}

@end
