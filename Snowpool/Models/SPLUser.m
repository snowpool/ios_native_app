//
//  SPLUser.m
//  Snowpool
//
//  Created by Tim Ross on 8/03/14.
//  Copyright (c) 2014 Snowpool Limited. All rights reserved.
//

#import "SPLUser.h"
#import "RSSecrets.h"
#import "SPLUserDefaults.h"

@implementation SPLUser

+ (instancetype)currentUser
{
    static dispatch_once_t pred;
    static SPLUser *sharedInstance = nil;
    dispatch_once(&pred, ^{ sharedInstance = [[self alloc] init]; });
    return sharedInstance;
}

- (BOOL)isAuthenticated
{
    return [RSSecrets stringForKey:SPLAuthTokenKey] != nil;
}

- (void)signInWithToken:(NSString *)token;
{
    [RSSecrets setString:token forKey:SPLAuthTokenKey];
}

- (void)signOut
{
    [RSSecrets removeKey:SPLAuthTokenKey];
}

@end
