//
//  SPLUser.h
//  Snowpool
//
//  Created by Tim Ross on 8/03/14.
//  Copyright (c) 2014 Snowpool Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPLUser : NSObject

@property (nonatomic, readonly) NSString *token;
@property (nonatomic, readonly) NSInteger userID;

+ (instancetype)currentUser;

@property (nonatomic, readonly) BOOL isAuthenticated;

- (void)signInWithUserID:(NSInteger )userID token:(NSString *)token;
- (void)signOut;

@end
