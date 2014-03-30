//
//  SPLCarpoolService.m
//  Snowpool
//
//  Created by Tim Ross on 9/03/14.
//  Copyright (c) 2014 Snowpool Limited. All rights reserved.
//

#import "SPLCarpoolService.h"
#import "SPLCarpool.h"
#import "AFHTTPRequestOperationManager.h"
#import "SPLUser.h"

@interface SPLCarpoolService ()

@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;

@end

@implementation SPLCarpoolService

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

- (void)requestCarpoolsForCountryID:(NSNumber *)countryID
                            success:(void (^)(NSArray *carpools))success
                            failure:(void (^)(NSError *error))failure
{
    [_manager GET:[NSString stringWithFormat:@"/countries/%@.js", countryID]
        parameters:nil
           success:^(AFHTTPRequestOperation *operation, id responseObject) {
               success([SPLCarpool carpoolsFromArray:responseObject]);
           } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
               failure(error);
           }];
}

- (void)createCarpoolWithFieldID:(NSInteger)fieldID
                     dateLeaving:(NSDate *)dateLeaving
                   dateReturning:(NSDate *)dateReturning
                      spacesFree:(NSInteger)spacesFree
                     leavingFrom:(NSString *)leavingFrom
                       telephone:(NSString *)telephone
                   carpoolWanted:(Boolean)carpoolWanted
                drivenHereBefore:(Boolean)drivenHereBefore
                         message:(NSString *)message
                         success:(void (^)())success
                         failure:(void (^)(NSError *error))failure
{
    [_manager POST:@"/pools.js"
       parameters:@{
                    @"token": [SPLUser currentUser].token,
                    @"pool": @{
                            @"leaving_from": leavingFrom,
                            @"field_id": @(fieldID),
                            @"leaving_date": dateLeaving,
                            @"returning_date": dateReturning,
                            @"spaces_free": @(spacesFree),
                            @"telephone": telephone,
                            @"seeking": @(carpoolWanted),
                            @"message": message,
                            @"driven_here_before": @(drivenHereBefore)
                            }
                    }
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              success();
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              failure(error);
          }];
}

- (void)sendMessageToCarpoolWithID:(NSInteger)carpoolID message:(NSString *)message
                           success:(void (^)())success
                           failure:(void (^)(NSError *error, NSInteger statusCode))failure;
{
    [_manager POST:[NSString stringWithFormat:@"/pools/%d/sendmessage.js", carpoolID]
        parameters:@{
                     @"token": [SPLUser currentUser].token, // TODO: What if user is not signed in?
                     @"message": message
                     }
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              success();
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              failure(error, operation.response.statusCode);
          }];
}

- (void)deleteCarpoolWithID:(NSInteger)carpoolID
                    success:(void (^)())success
                    failure:(void (^)(NSError *, NSInteger statusCode))failure
{
    [_manager POST:[NSString stringWithFormat:@"/pools/%d.js", carpoolID]
        parameters:@{
                     @"token": [SPLUser currentUser].token,
                     @"_method": @"delete"
                     }
           success:^(AFHTTPRequestOperation *operation, id responseObject) {
               success();
           } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
               failure(error, operation.response.statusCode);
           }];
}

- (void)cancel
{
    [_manager.operationQueue cancelAllOperations];
}

@end
