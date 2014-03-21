//
//  SPLAuthService.h
//  Snowpool
//
//  Created by Tim Ross on 9/03/14.
//  Copyright (c) 2014 Snowpool Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPLAuthService : NSObject

- (void)loginWithEmail:(NSString *)email password:(NSString *)password
                  success:(void (^)(NSString *token, NSInteger userID))success
                  failure:(void (^)(NSError *error, NSInteger statusCode))failure;

- (void)cancel;

@end
