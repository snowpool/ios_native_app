//
//  SPLCarpoolViewController.m
//  Snowpool
//
//  Created by Tim Ross on 8/03/14.
//  Copyright (c) 2014 Snowpool Limited. All rights reserved.
//

#import "SPLCarpoolViewController.h"
#import "SVProgressHUD.h"

@interface SPLCarpoolViewController ()

@property (nonatomic, strong) NSArray *carpoolDetails;

@end

@implementation SPLCarpoolViewController

NSString * const kCarpoolActionSendMessage = @"Send Message";

#pragma mark -
#pragma mark View lifecycle methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.carpoolDetails = @[@{@"Date Leaving": @"8 Mar 2014"},
                            @{@"Date Returning": @"8 Mar 2014"},
                            @{@"Name": @"Patrick - Snowpool"},
                            @{@"Spaces": @"1"},
                            @{@"Telephone": @"123456"},
                            @{@"Driven Here Before": @"No"},
                            @{@"Leaving From": @"Christchurch"}
                            ];
}

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
#pragma mark UITableView methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.carpoolDetails.count;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *DetailCellIdentifier = @"CarpoolDetailCell";
    static NSString *NotesCellIdentifier = @"CarpoolNotesCell";
    
    UITableViewCell *cell = nil;
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:DetailCellIdentifier];
        NSDictionary *carpoolDetail = self.carpoolDetails[indexPath.row];
        cell.textLabel.text = [[carpoolDetail allKeys] firstObject];
        cell.detailTextLabel.text = [[carpoolDetail allValues] firstObject];
        
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:NotesCellIdentifier];
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"Carpool to Mt. Cheeseman";
    } else {
        return @"Notes";
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 44;
    } else {
        return 72;
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
    [SVProgressHUD showSuccessWithStatus:@"Message Sent"];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
