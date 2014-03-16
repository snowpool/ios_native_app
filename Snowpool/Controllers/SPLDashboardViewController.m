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
#import "SPLCarpoolService.h"
#import "SPLCarpool.h"
#import "SPLCarpoolViewController.h"
#import "SPLTableSectionHeaderView.h"

@interface SPLDashboardViewController ()

@property (nonatomic, strong) NSArray *carpools;
@property (nonatomic, strong) NSArray *groupedDates;
@property (nonatomic, strong) NSDictionary *carpoolsGroupedByDate;
@property (nonatomic, strong) SPLCarpoolService *carpoolService;

@end

@implementation SPLDashboardViewController
{
    BOOL _hasRequestedCarpools;
}

- (void)loadGroupedCarpools
{
    NSArray *filteredCarpools = self.carpools;
    if (self.filter.selectedSegmentIndex > 0) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"isSeeking = %d",
                                  self.filter.selectedSegmentIndex == 1 ? NO : YES];
        filteredCarpools = [self.carpools filteredArrayUsingPredicate:predicate];
    }
    
    NSMutableDictionary *carpoolsGroupedByDate = [NSMutableDictionary dictionary];
    NSMutableArray *groupedDates = [NSMutableArray array];
    for (SPLCarpool *carpool in filteredCarpools) {
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
    [_carpoolService requestCarpoolsForCountryID:selectedCountryKey success:^(NSArray *carpools) {
        DebugLog(@"Fetched %d carpools from service", carpools.count);
        self.carpools = carpools;
        [self loadGroupedCarpools];
        [self.refreshControl endRefreshing];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"Error requesting carpools: %@", error);
        [self.refreshControl endRefreshing];
        [SVProgressHUD showErrorWithStatus:error.localizedDescription];
    }];
}

- (SPLCarpool *)carpoolAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *startDate = [self.groupedDates objectAtIndex:indexPath.section];
    NSArray *carpools = [self.carpoolsGroupedByDate objectForKey:startDate];
    return carpools[indexPath.row];
}

- (void)setRightBarButtonItemTitle
{
    if ([SPLUser currentUser].isAuthenticated) {
        self.navigationItem.rightBarButtonItem.title = @"Add Carpool";
    } else {
        self.navigationItem.rightBarButtonItem.title = @"Sign In";
    }
}

#pragma mark -
#pragma mark View lifecycle methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(countryDidChange:)
                                                 name:SPLCountryDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(userAuthenticationDidChange:)
                                                 name:SPLUserAuthenticationDidChangeNotification object:nil];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self
                            action:@selector(tableViewDidStartRefresh:)
                  forControlEvents:UIControlEventValueChanged];
    
    self.carpoolService = [[SPLCarpoolService alloc] init];
    
    [self setRightBarButtonItemTitle];
    
    if ([SPLUserDefaults standardUserDefaults].selectedCountryKey == nil) {
        [self performSegueWithIdentifier:@"SelectCountry" sender:self];
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!_hasRequestedCarpools) {
        _hasRequestedCarpools = YES;
        // Offset table view to display refresh indicator
        [self.tableView setContentOffset:CGPointMake(0, -124)];
        [self requestCarpools];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"SelectCountry"]) {
        UINavigationController *navController = segue.destinationViewController;
        SPLSelectCountryViewController *controller = (SPLSelectCountryViewController *)navController.topViewController;
        controller.delegate = self;
    } else if ([segue.identifier isEqualToString:@"CarpoolDetails"]) {
        SPLCarpoolViewController *controller = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell *)sender];
        controller.carpool = [self carpoolAtIndexPath:indexPath];
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
    
    SPLCarpool *carpool = [self carpoolAtIndexPath:indexPath];
    cell.textLabel.text = carpool.title;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.groupedDates objectAtIndex:section];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    SPLTableSectionHeaderView *view = [[SPLTableSectionHeaderView alloc] init];
    view.titleLabel.text = [self tableView:tableView titleForHeaderInSection:section];
    
    return view;
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

- (IBAction)filterValueChanged:(id)sender
{
    [self loadGroupedCarpools];
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark NSNofitication methods

- (void)countryDidChange:(NSNotification *)notification
{
    [self requestCarpools];
}

- (void)userAuthenticationDidChange:(NSNotification *)notification
{
    [self setRightBarButtonItemTitle];
}

#pragma mark -
#pragma mark SPLSelectCountryViewControllerDelegate methods

- (void)selectCountryViewControllerDidChangeCountry:(SPLSelectCountryViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
