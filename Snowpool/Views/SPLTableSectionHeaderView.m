//
//  SPLTableSectionHeaderView.m
//  Snowpool
//
//  Created by Tim Ross on 16/03/14.
//  Copyright (c) 2014 Snowpool Limited. All rights reserved.
//

#import "SPLTableSectionHeaderView.h"

@implementation SPLTableSectionHeaderView

- (id)init {
    if (self = [super init]) {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 290, 22)];
        [self addSubview:_titleLabel];
    }
    return self;
}

@end
