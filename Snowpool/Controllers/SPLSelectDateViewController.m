//
//  SPLSelectDateViewController.m
//  Snowpool
//
//  Created by Patrick Davey on 5/04/14.
//  Copyright (c) 2014 Snowpool Limited. All rights reserved.
//

#import "SPLSelectDateViewController.h"

@interface SPLSelectDateViewController ()

@end

@implementation SPLSelectDateViewController

NSInteger const NumberOfDaysToShow = 10;

#pragma mark -
#pragma mark UITableView methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return NumberOfDaysToShow;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SelectDateCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    cell.textLabel.text = [self dateStringForOffsetNumberOfDays:indexPath.row];
    
    if ([cell.textLabel.text isEqualToString:self.selectedDate]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    if (indexPath.row == 1) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@ (Tomorrow)", cell.textLabel.text];
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedDate = [self dateStringForOffsetNumberOfDays:indexPath.row];
    [self.delegate selectDateViewControllerDidChangeNumberOfSpaces:self];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"Choose date you're %@", self.dateTypeToSelect];
}

- (NSString *)dateStringForOffsetNumberOfDays:(NSInteger)offset
{
    NSDate *date = [NSDate date];
    NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
    dayComponent.day = offset;
    
    NSCalendar *theCalendar = [NSCalendar currentCalendar];
    date = [theCalendar dateByAddingComponents:dayComponent toDate:date options:0];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    [dateFormatter setDateFormat:@"d-MMMM-YYYY"];
    
    return [dateFormatter stringFromDate:date];
}

@end
