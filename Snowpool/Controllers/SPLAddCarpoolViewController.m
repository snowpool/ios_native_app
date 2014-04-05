//
//  SPLAddCarpoolViewController.m
//  Snowpool
//
//  Created by Tim Ross on 8/03/14.
//  Copyright (c) 2014 Snowpool Limited. All rights reserved.
//

#import "SPLAddCarpoolViewController.h"
#import "SPLCarpoolService.h"

@interface SPLAddCarpoolViewController ()

@property (nonatomic, strong) SPLCarpoolService *carpoolService;

@end

@implementation SPLAddCarpoolViewController

- (void)createCarpool
{
    NSLog(@"this telephone %@",self.telephone.text);
    NSLog( self.drivenHereBefore.isOn ? @"YES" : @"NO");
    [SVProgressHUD showSuccessWithStatus:@"Carpool Created"];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark View lifecycle methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.carpoolService = [[SPLCarpoolService alloc] init];
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
    }
    else if ([segue.identifier isEqualToString:@"SelectDateReturning"]) {
        SPLSelectDateViewController *controller = segue.destinationViewController;
        controller.dateTypeToSelect = @"returning";
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


#pragma mark -
#pragma mark SPLSpacesFreeViewController methods

- (void)spacesFreeViewControllerDidChangeNumberOfSpaces:(SPLSpacesFreeViewController *)controller
{
    self.spacesFree.text = [NSString stringWithFormat:@"%d", controller.spacesFree];
    [controller dismissViewControllerAnimated:YES completion:nil];
}


@end
