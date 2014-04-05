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


#pragma mark -
#pragma mark UITableView methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SelectDateCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell.textLabel.text = @"hello";
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"Choose date you're %@", self.dateTypeToSelect];
}


@end
