//
//  SPLCarpoolViewController.m
//  Snowpool
//
//  Created by Tim Ross on 8/03/14.
//  Copyright (c) 2014 Snowpool Limited. All rights reserved.
//

#import "SPLCarpoolViewController.h"
#import "SVProgressHUD.h"
#import "SPLCarpoolService.h"

@interface SPLCarpoolViewController ()

@property (nonatomic, strong) NSArray *carpoolDetails;

@end

@implementation SPLCarpoolViewController

NSString * const kCarpoolActionSendMessage = @"Send Message";

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
    
    [self displayCarpool];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"SendMessage"]) {
        UINavigationController *navController = segue.destinationViewController;
        SPLSendMessageViewController *controller = (SPLSendMessageViewController *)navController.topViewController;
        controller.delegate = self;
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
    [SVProgressHUD showWithStatus:@"Sending Message"];
    SPLCarpoolService *carpoolService = [[SPLCarpoolService alloc] init];
    [carpoolService sendMessageToCarpoolWithID:self.carpool.carpoolID message:message
                                       success:^() {
                            [SVProgressHUD dismiss];
                        } failure:^(NSError *error) {
                            [SVProgressHUD showErrorWithStatus:error.localizedDescription];
                            NSLog(@"Error signing in: %@", error);
                        }];

}

@end
