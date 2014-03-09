//
//  SPLCarpool.m
//  Snowpool
//
//  Created by Tim Ross on 9/03/14.
//  Copyright (c) 2014 Snowpool Limited. All rights reserved.
//

#import "SPLCarpool.h"

@implementation SPLCarpool

+ (NSArray *)carpoolsFromArray:(NSArray *)carpoolArray
{
    NSMutableArray *carpools = [NSMutableArray array];
    for (NSDictionary *dict in carpoolArray) {
        SPLCarpool *carpool = [[SPLCarpool alloc] initWithDictionary:dict];
        [carpools addObject:carpool];
    }
    return [carpools copy];
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        _carpoolID = [dict[@"id"] integerValue];
        _title = dict[@"title"];
        _start = dict[@"start"];
        _isSeeking = [dict[@"seeking"] boolValue];
        _leavingFrom = dict[@"leavingFrom"];
        _name = dict[@"name"];
        _fieldName = dict[@"fieldName"];
        _message = dict[@"message"];
        _telephone = dict[@"telephone"];
        _spacesFree = [dict[@"spacesFree"] integerValue];
        _userID = [dict[@"userID"] integerValue];
        _fieldID = [dict[@"fieldID"] integerValue];
        _spacesFree = [dict[@"spacesFree"] integerValue];
        _hasDrivenBefore = [dict[@"drivenBefore"] boolValue];

    }
    return self;
}

@end
