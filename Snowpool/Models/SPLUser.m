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

NSString *const SPLUserAuthenticationDidChangeNotification = @"SPLUserAuthenticationDidChangeNotification";

+ (instancetype)currentUser
{
    static dispatch_once_t pred;
    static SPLUser *sharedInstance = nil;
    dispatch_once(&pred, ^{ sharedInstance = [[self alloc] init]; });
    return sharedInstance;
}

- (BOOL)isAuthenticated
{
    return self.token != nil;
}

- (NSInteger)userID
{
    return [[RSSecrets stringForKey:SPLAuthUserID] integerValue];
}

- (NSString *)token
{
    return [RSSecrets stringForKey:SPLAuthTokenKey];
}

- (void)signInWithUserID:(NSInteger )userID token:(NSString *)token
{
    [RSSecrets setString:token forKey:SPLAuthTokenKey];
    [RSSecrets setString:[NSString stringWithFormat:@"%d", userID] forKey: SPLAuthUserID];
    [[NSNotificationCenter defaultCenter] postNotificationName:SPLUserAuthenticationDidChangeNotification object:self];
}

- (void)signOut
{
    [RSSecrets removeKey:SPLAuthTokenKey];
    [[NSNotificationCenter defaultCenter] postNotificationName:SPLUserAuthenticationDidChangeNotification object:self];
}

@end
