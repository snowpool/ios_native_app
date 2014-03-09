//
//  SPLCarpoolService.h
//  Snowpool
//
//  Created by Tim Ross on 9/03/14.
//  Copyright (c) 2014 Snowpool Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SPLCreateCarpoolViewModel;

@interface SPLCarpoolService : NSObject

- (void)requestCarpoolsForCountryID:(NSNumber *)countryID
                            success:(void (^)(NSArray *carpools))success
                            failure:(void (^)(NSError *error))failure;

- (void)createCarpoolWithFieldID:(NSInteger)fieldID
                     dateLeaving:(NSDate *)dateLeaving
                   dateReturning:(NSDate *)dateReturning
                            name:(NSString *)name
                      spacesFree:(NSInteger)spacesFree
                     leavingFrom:(NSString *)leavingFrom
                       telephone:(NSString *)telephone
                   carpoolWanted:(Boolean)carpoolWanted
                drivenHereBefore:(Boolean)drivenHereBefore
                         message:(NSString *)message
                            success:(void (^)())success
                            failure:(void (^)(NSError *error))failure;

@end
