//
//  SPLCarpoolService.h
//  Snowpool
//
//  Created by Tim Ross on 9/03/14.
//  Copyright (c) 2014 Snowpool Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPLCarpoolService : NSObject

- (void)requestCarpoolsForCountryID:(NSNumber *)countryID
                            success:(void (^)(NSArray *carpools))success
                            failure:(void (^)(NSError *error))failure;

@end
