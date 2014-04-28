//
//  NSDictionary+NullValues.m
//  Snowpool
//
//  Created by Patrick Davey on 19/04/14.
//  Copyright (c) 2014 Snowpool Limited. All rights reserved.
//

#import "NSDictionary+NullValues.h"

@implementation NSDictionary (NullValues)

- (id)objectForKeyNotNull:(id)key
{
    id object = [self objectForKey:key];
    if (object == [NSNull null])
        return nil;
    
    return object;
}

@end