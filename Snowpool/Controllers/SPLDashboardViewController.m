//
//  SPLDashboardViewController.m
//  Snowpool
//
//  Created by Tim Ross on 8/03/14.
//  Copyright (c) 2014 Snowpool Limited. All rights reserved.
//

#import "SPLDashboardViewController.h"
#import "SPLUserDefaults.h"
#import "SPLUser.h"
#import "SVProgressHUD.h"
#import "SPLCarpoolService.h"
#import "SPLCarpool.h"

@interface SPLDashboardViewController ()

@property (nonatomic, strong) NSArray *groupedDates;
@property (nonatomic, strong) NSDictionary *carpoolsGroupedByDate;

@end

@implementation SPLDashboardViewController
{
    BOOL _hasRequestedCarpools;
}

- (void)loadCarpoolsFromArray:(NSArray *)carpools
{
    NSMutableDictionary *carpoolsGroupedByDate = [NSMutableDictionary dictionary];
    NSMutableArray *groupedDates = [NSMutableArray array];
    for (SPLCarpool *carpool in carpools) {
        if ([groupedDates indexOfObject:carpool.start] == NSNotFound) {
            [groupedDates addObject:carpool.start];
        }
        NSMutableArray *carpoolGroup = [carpoolsGroupedByDate objectForKey:carpool.start];
        if (!carpoolGroup) {
            carpoolGroup = [NSMutableArray array];
            [carpoolsGroupedByDate setObject:carpoolGroup forKey:carpool.start];
        }
        [carpoolGroup addObject:carpool];
    }
    self.groupedDates = [groupedDates copy];
    self.carpoolsGroupedByDate = [carpoolsGroupedByDate copy];
}

- (void)requestCarpools
{
    NSNumber *selectedCountryKey = [SPLUserDefaults standardUserDefaults].selectedCountryKey;
    if (selectedCountryKey == nil) return;
    
    [self.refreshControl beginRefreshing];
    SPLCarpoolService *carpoolService = [[SPLCarpoolService alloc] init];
    [carpoolService requestCarpoolsForCountryID:selectedCountryKey success:^(NSArray *carpools) {
        DebugLog(@"Fetched %d carpools from service", carpools.count);
        [self loadCarpoolsFromArray:carpools];
        [self.refreshControl endRefreshing];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"Error requesting carpools: %@", error);
        [self.refreshControl endRefreshing];
        [SVProgressHUD showErrorWithStatus:error.localizedDescription];
    }];
}

#pragma mark -
#pragma mark View lifecycle methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self
                            action:@selector(tableViewDidStartRefresh:)
                  forControlEvents:UIControlEventValueChanged];
    
    if ([SPLUserDefaults standardUserDefaults].selectedCountryKey == nil) {
        [self performSegueWithIdentifier:@"SelectCountry" sender:self];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([SPLUser currentUser].isAuthenticated) {
        self.navigationItem.rightBarButtonItem.title = @"Add Carpool";
    } else {
        self.navigationItem.rightBarButtonItem.title = @"Sign In";
    }
    
    if (!_hasRequestedCarpools) {
        _hasRequestedCarpools = YES;
        // Offset table view to display refresh indicator
        [self.tableView setContentOffset:CGPointMake(0, -124)];
        [self requestCarpools];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"SignIn"]) {
        UINavigationController *navController = segue.destinationViewController;
        SPLSignInViewController *controller = (SPLSignInViewController *)navController.topViewController;
        controller.delegate = self;
    } else if ([segue.identifier isEqualToString:@"AddCarpool"]) {
        UINavigationController *navController = segue.destinationViewController;
        SPLAddCarpoolViewController *controller = (SPLAddCarpoolViewController *)navController.topViewController;
        controller.delegate = self;
    } else if ([segue.identifier isEqualToString:@"Settings"]) {
        UINavigationController *navController = segue.destinationViewController;
        SPLSettingsViewController *controller = (SPLSettingsViewController *)navController.topViewController;
        controller.delegate = self;
    } else if ([segue.identifier isEqualToString:@"SelectCountry"]) {
        UINavigationController *navController = segue.destinationViewController;
        SPLSelectCountryViewController *controller = (SPLSelectCountryViewController *)navController.topViewController;
        controller.delegate = self;
    }
}

#pragma mark -
#pragma mark UITableView methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groupedDates.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *startDate = [self.groupedDates objectAtIndex:section];
    NSArray *carpools = [self.carpoolsGroupedByDate objectForKey:startDate];
    return carpools.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CarpoolCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSString *startDate = [self.groupedDates objectAtIndex:indexPath.section];
    NSArray *carpools = [self.carpoolsGroupedByDate objectForKey:startDate];
    SPLCarpool *carpool = carpools[indexPath.row];
    cell.textLabel.text = carpool.title;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.groupedDates objectAtIndex:section];
}

- (void)tableViewDidStartRefresh:(UIRefreshControl *)refreshControl
{
    [self requestCarpools];
}

#pragma mark -
#pragma mark IBAction methods

- (IBAction)rightBarButtonItemPressed:(id)sender
{
    if ([SPLUser currentUser].isAuthenticated) {
        [self performSegueWithIdentifier:@"AddCarpool" sender:self];
    } else {
        [self performSegueWithIdentifier:@"SignIn" sender:self];
    }
}

#pragma mark -
#pragma mark SPLSignInViewControllerDelegate methods

- (void)signInViewControllerDidCancel:(SPLSignInViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)signInViewControllerDidSignIn:(SPLSignInViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark SPLAddCarpoolViewControllerDelegate methods

- (void)addCarpoolViewControllerDidCancel:(SPLAddCarpoolViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addCarpoolViewControllerDidAddCarpool:(SPLAddCarpoolViewController *)controller
{
    [SVProgressHUD showSuccessWithStatus:@"Carpool Created"];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark SPLSettingsViewControllerDelegate methods

- (void)settingsViewControllerDidFinish:(SPLSettingsViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)settingsViewControllerDidSignOut:(SPLSettingsViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark SPLSelectCountryViewControllerDelegate methods

- (void)selectCountryViewControllerDidChangeCountry:(SPLSelectCountryViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
