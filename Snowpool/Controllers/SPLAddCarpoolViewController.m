//
//  SPLAddCarpoolViewController.m
//  Snowpool
//
//  Created by Tim Ross on 8/03/14.
//  Copyright (c) 2014 Snowpool Limited. All rights reserved.
//

#import "SPLAddCarpoolViewController.h"
#import "SPLCarpoolService.h"
#import "SPLSkiField.h"
#import "SPLUserDefaults.h"
#import "SPLUser.h"

@interface SPLAddCarpoolViewController ()

@property (nonatomic, strong) SPLCarpoolService *carpoolService;
@property (nonatomic, strong) NSNumber *selectedSkiFieldID;

@end

@implementation SPLAddCarpoolViewController

NSString *const SPLDidCreateCarpoolNotification = @"SPLDidCreateCarpoolNotification";

- (void)saveLastValidCity:(NSString *)city telephone:(NSString *)telephone skiFieldID:(NSNumber *)skiFieldID
{
    SPLUserDefaults *defaults = [SPLUserDefaults standardUserDefaults];
    defaults.telephone = telephone;
    defaults.city = city;
    defaults.lastSkiFieldVisitedID = skiFieldID;
    [defaults synchronize];
}

- (void)setupDefaults
{
    SPLUserDefaults *defaults = [SPLUserDefaults standardUserDefaults];

    self.telephone.text = defaults.telephone;
    self.leavingFrom.text = defaults.city;
    
    if (defaults.lastSkiFieldVisitedID) {
        self.selectedSkiFieldID = defaults.lastSkiFieldVisitedID;
        self.skiFieldTitle.text = [SPLSkiField titleForFieldWithID:self.selectedSkiFieldID];
    }
}

- (NSString *)firstErrorMessageFromErrors:(NSDictionary *)errors
{
    NSString *key = [[errors allKeys] firstObject];
    NSString *errorMessage = [errors[key] firstObject];
    
    key = [[key stringByReplacingOccurrencesOfString:@"_"
                                    withString:@" "] mutableCopy];
    key = [key stringByReplacingCharactersInRange: NSMakeRange(0,1)
                                        withString:[[key substringToIndex:1] capitalizedString]];;
    
    return [NSString stringWithFormat:@"%@ %@", key, errorMessage];
}

- (void)createCarpool
{
    [SVProgressHUD showWithStatus:@"Creating Carpool"];
    [_carpoolService createCarpoolWithFieldID:[self.selectedSkiFieldID intValue]
                                  dateLeaving:self.dateLeaving.text
                                dateReturning:self.dateReturning.text
                                   spacesFree:[self.spacesFree.text intValue]
                                  leavingFrom:self.leavingFrom.text
                                    telephone:self.telephone.text
                                carpoolWanted:self.carpoolWanted.isOn
                             drivenHereBefore:self.drivenHereBefore.isOn
                                      message:self.message.text
                                      success:^() {
                                          [SVProgressHUD dismiss];
                                          [self saveLastValidCity:self.leavingFrom.text
                                                        telephone:self.telephone.text
                                                       skiFieldID:self.selectedSkiFieldID];
                                          [[NSNotificationCenter defaultCenter] postNotificationName:SPLDidCreateCarpoolNotification object:nil];
                                          
                                          [[SPLAnalytics sharedInstance] sendEventUserDidCreateCarpoolWithSkifieldID:self.selectedSkiFieldID];

                                          [self.navigationController dismissViewControllerAnimated:YES completion:nil];
                                      } failure:^(NSError *error, NSInteger statusCode, NSDictionary *errorsHash) {
                                          NSLog(@"Error creating carpool: %@", error);
                                          if (statusCode == 401) {
                                              [SVProgressHUD showErrorWithStatus:@"Cannot create carpool, has your password changed?"];
                                              [[SPLUser currentUser] signOut];
                                              [self.navigationController dismissViewControllerAnimated:YES completion:nil];
                                          } else {
                                              [SVProgressHUD dismiss];
                                              UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error Creating Carpool"
                                                                                              message:[self firstErrorMessageFromErrors:errorsHash[@"errors"]]
                                                                                             delegate:self
                                                                                    cancelButtonTitle:@"OK"
                                                                                    otherButtonTitles:nil];
                                              [alert show];

                                              NSLog(@"Error sending message: %@", error);
                                          }
                                      }];

    
    
}

#pragma mark -
#pragma mark View lifecycle methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.carpoolService = [[SPLCarpoolService alloc] init];
    [self setupDefaults];
    
    [[SPLAnalytics sharedInstance] sendScreenView:@"Add Carpool"];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"SelectSpacesFree"]) {
        SPLSpacesFreeViewController *controller = segue.destinationViewController;
        controller.spacesFree = [self.spacesFree.text intValue];
        controller.delegate = self;
    }
    else if ([segue.identifier isEqualToString:@"SelectDateLeaving"]) {
        SPLSelectDateViewController *controller = segue.destinationViewController;
        controller.dateTypeToSelect = @"leaving";
        controller.selectedDate = self.dateLeaving.text;
        controller.delegate = self;
    }
    else if ([segue.identifier isEqualToString:@"SelectDateReturning"]) {
        SPLSelectDateViewController *controller = segue.destinationViewController;
        controller.dateTypeToSelect = @"returning";
        controller.selectedDate = self.dateReturning.text;
        controller.delegate = self;
    }
    else if ([segue.identifier isEqualToString:@"SelectSkiField"]) {
        SPLSelectFieldViewController *controller = segue.destinationViewController;
        controller.selectedSkiFieldID = self.selectedSkiFieldID;
        controller.delegate = self;
    }
}

#pragma mark -
#pragma mark IBAction methods

- (IBAction)cancelButtonPressed:(id)sender
{
    [_carpoolService cancel];
    [SVProgressHUD dismiss];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)doneButtonPressed:(id)sender
{
    [self createCarpool];
}

- (IBAction)viewWasTapped:(id)sender
{
    [self.view endEditing:YES];
}

#pragma mark -
#pragma mark SPLSelectFieldViewController methods

- (void)selectSkiFieldControllerDidChangeSkiField:(SPLSelectFieldViewController *)controller
{
    self.skiFieldTitle.text = [SPLSkiField titleForFieldWithID:controller.selectedSkiFieldID];
    self.selectedSkiFieldID = controller.selectedSkiFieldID;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark SPLSpacesFreeViewController methods

- (void)spacesFreeViewControllerDidChangeNumberOfSpaces:(SPLSpacesFreeViewController *)controller
{
    self.spacesFree.text = [NSString stringWithFormat:@"%d", controller.spacesFree];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark SPLSelectDateViewController methods

- (void)selectDateViewControllerDidChangeNumberOfSpaces:(SPLSelectDateViewController *)controller
{
    if ([controller.dateTypeToSelect isEqualToString:@"leaving"]) {
        self.dateLeaving.text = controller.selectedDate;
        
        if ([self.dateReturning.text isEqualToString:@"Please Select..."]) {
            //we intelligently set the return date
            self.dateReturning.text = controller.selectedDate;
        }
    } else {
        self.dateReturning.text = controller.selectedDate;
    }
    [self.navigationController popViewControllerAnimated:YES];
}
@end
