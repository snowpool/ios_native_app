//
//  SPLSelectCountryViewController.m
//  Snowpool
//
//  Created by Patrick Davey on 8/03/14.
//  Copyright (c) 2014 Snowpool Limited. All rights reserved.
//

#import "SPLSelectCountryViewController.h"

@interface SPLSelectCountryViewController ()

@property (nonatomic, strong) NSDictionary *countries;
@property (nonatomic, readonly) NSArray *sortedCountryKeys;

@end

@implementation SPLSelectCountryViewController

#pragma mark -
#pragma mark View lifecycle methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.countries = @{ @1 : @"New Zealand",
                        @2 : @"Australia",
                        @3 : @"United States",
                        @4 : @"Canada" };
}

- (NSArray *)sortedCountryKeys
{
    return [self.countries.allKeys sortedArrayUsingSelector:@selector(compare:)];
}

#pragma mark -
#pragma mark UITableView methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.countries.allKeys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SelectCountryCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSNumber *countryKey = self.sortedCountryKeys[indexPath.row];
    cell.textLabel.text = self.countries[countryKey];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DebugLog(@"Selected country with key %@", self.sortedCountryKeys[indexPath.row]);
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Choose your country";
}

@end
