//
//  SPLSelectCountryViewController.m
//  Snowpool
//
//  Created by Patrick Davey on 8/03/14.
//  Copyright (c) 2014 Snowpool Limited. All rights reserved.
//

#import "SPLSelectCountryViewController.h"
#import "SPLUserDefaults.h"
#import "SPLCountry.h"

@interface SPLSelectCountryViewController ()

@property (nonatomic, strong) NSDictionary *countries;
@property (nonatomic, readonly) NSArray *sortedCountryKeys;

@end

@implementation SPLSelectCountryViewController

NSString *const SPLCountryDidChangeNotification = @"SPLCountryDidChangeNotification";

- (NSArray *)sortedCountryKeys
{
    return [self.countries.allKeys sortedArrayUsingSelector:@selector(compare:)];
}

#pragma mark -
#pragma mark View lifecycle methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.countries = [SPLCountry all];
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
    
    NSNumber *selectedCountryKey = [SPLUserDefaults standardUserDefaults].selectedCountryKey;
    if (selectedCountryKey && [selectedCountryKey isEqualToNumber:countryKey]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    cell.textLabel.text = self.countries[countryKey];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{   
    SPLUserDefaults *defaults = [SPLUserDefaults standardUserDefaults];
    defaults.selectedCountryKey = self.sortedCountryKeys[indexPath.row];
    [defaults synchronize];
    DebugLog(@"Selected country with key %@", defaults.selectedCountryKey);
    [[NSNotificationCenter defaultCenter] postNotificationName:SPLCountryDidChangeNotification object:nil];
    [self.delegate selectCountryViewControllerDidChangeCountry:self];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Choose your country";
}

@end
