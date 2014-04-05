//
//  SPLUserDefaults.m
//  Snowpool
//
//  Created by Tim Ross on 8/03/14.
//  Copyright (c) 2014 Snowpool Limited. All rights reserved.
//

#import "SPLUserDefaults.h"

@implementation SPLUserDefaults

@dynamic selectedCountryKey;
@dynamic telephone;
@dynamic city;

+ (instancetype)standardUserDefaults
{
    static dispatch_once_t pred;
    static SPLUserDefaults *sharedInstance = nil;
    dispatch_once(&pred, ^{ sharedInstance = [[self alloc] init]; });
    return sharedInstance;
}

- (NSString *)transformKey:(NSString *)key
{
    return [NSString stringWithFormat:@"SPL_%@", key];
}

- (void)synchronize
{
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
