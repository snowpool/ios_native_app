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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    if (indexPath.row == self.spacesFree - 1) {
      cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    return cell;
}


@end

