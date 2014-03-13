//
//  SPLAuthService.m
//  Snowpool
//
//  Created by Tim Ross on 9/03/14.
//  Copyright (c) 2014 Snowpool Limited. All rights reserved.
//

#import "SPLAuthService.h"
#import "AFHTTPRequestOperationManager.h"
#import "SPLUser.h"

@interface SPLAuthService ()

@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;

@end

@implementation SPLAuthService

- (id)init
{
    return [self initWithBaseURL:[NSURL URLWithString:SPLServiceBaseURL]];
}

- (id)initWithBaseURL:(NSURL *)baseURL
{
    if ((self = [super init])) {
        _manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    }
    return self;
}

- (void)loginWithEmail:(NSString *)email password:(NSString *)password
                  success:(void (^)(NSString *token, NSInteger userID))success
                  failure:(void (^)(NSError *error, NSInteger statusCode))failure
{
    [_manager POST: @"/tokens.js"
        parameters: @{@"email": email, @"password" : password }
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              success(responseObject[@"token"], [responseObject[@"user_id"] integerValue]);
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              failure(error, operation.response.statusCode);
          }];
    
}

- (void)cancel
{
    [_manager.operationQueue cancelAllOperations];
}

@end
