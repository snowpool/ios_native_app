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
    
    NSDate *date = [NSDate date];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
    dayComponent.day = indexPath.row;
    
    NSCalendar *theCalendar = [NSCalendar currentCalendar];
    date = [theCalendar dateByAddingComponents:dayComponent toDate:date options:0];
    
    //now date contains the offset from today that we want, format it into the string we want
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    [dateFormatter setDateFormat:@"d-MMM-YYYY"];
    
    cell.textLabel.text = [dateFormatter stringFromDate:date];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"Choose date you're %@", self.dateTypeToSelect];
}


@end
