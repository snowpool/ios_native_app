//
//  NSDictionary+NullValues.h
//  Snowpool
//
//  Created by Patrick Davey on 19/04/14.
//  Copyright (c) 2014 Snowpool Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (NullValues)

- (id)objectForKeyNotNull:(id)key;

@end
