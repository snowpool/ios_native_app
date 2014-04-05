//
//  SPLSelectFieldViewController.m
//  Snowpool
//
//  Created by Patrick Davey on 5/04/14.
//  Copyright (c) 2014 Snowpool Limited. All rights reserved.
//

#import "SPLSelectFieldViewController.h"
#import "SPLSkiField.h"
#import "SPLUserDefaults.h"

@interface SPLSelectFieldViewController ()

@property (nonatomic, strong) NSDictionary *skiFields;
@property (nonatomic, readonly) NSArray *sortedSkiFieldKeys;

@end

@implementation SPLSelectFieldViewController

- (NSArray *)sortedSkiFieldKeys
{
    return [self.skiFields keysSortedByValueUsingSelector:@selector(caseInsensitiveCompare:)];
}

#pragma mark -
#pragma mark View lifecycle methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSNumber *usersCountry = [SPLUserDefaults standardUserDefaults].selectedCountryKey;
    self.skiFields = [SPLSkiField allForCountryWithID:usersCountry];
}


#pragma mark -
#pragma mark UITableView methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.skiFields.allKeys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SelectFieldCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSNumber *fieldKey = self.sortedSkiFieldKeys[indexPath.row];
    
    if (self.selectedSkiFieldID && [fieldKey compare:self.selectedSkiFieldID] == NSOrderedSame){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }

    
    cell.textLabel.text = self.skiFields[fieldKey];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedSkiFieldID = self.sortedSkiFieldKeys[indexPath.row];
    [self.delegate selectSkiFieldControllerDidChangeSkiField:self];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Choose your ski field";
}

@end
