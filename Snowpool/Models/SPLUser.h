//
//  SPLUser.h
//  Snowpool
//
//  Created by Tim Ross on 8/03/14.
//  Copyright (c) 2014 Snowpool Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPLUser : NSObject

+ (instancetype)currentUser;

@property (nonatomic, readonly) BOOL isAuthenticated;

- (void)signInWithToken:(NSString *)token;
- (void)signOut;

@end
