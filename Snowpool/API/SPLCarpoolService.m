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

@end
