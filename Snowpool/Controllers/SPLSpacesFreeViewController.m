//
//  SPLSpacesFreeViewController.m
//  Snowpool
//
//  Created by Patrick Davey on 5/04/14.
//  Copyright (c) 2014 Snowpool Limited. All rights reserved.
//

#import "SPLSpacesFreeViewController.h"

@interface SPLSpacesFreeViewController ()

@end

@implementation SPLSpacesFreeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}


#pragma mark -
#pragma mark UITableView methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    if (indexPath.row == self.spacesFree - 1) {
      cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    DebugLog(@"Selected this number of spaces with key %d", indexPath.row);
    
    //kill the old cell
    [self clearOldCellOnTableView:tableView andActivateNewCellForIndexPath:indexPath];

    [self.delegate spacesFreeViewControllerDidChangeNumberOfSpaces:self];
}

- (void)clearOldCellOnTableView:(UITableView *)tableView andActivateNewCellForIndexPath:(NSIndexPath *)indexPath {
    NSIndexPath *oldPath = [NSIndexPath indexPathForRow:self.spacesFree -1 inSection:0];
    UITableViewCell *oldCell = [super tableView:tableView cellForRowAtIndexPath:oldPath];
    oldCell.accessoryType = UITableViewCellAccessoryNone;

    self.spacesFree = indexPath.row + 1;
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
}

@end

