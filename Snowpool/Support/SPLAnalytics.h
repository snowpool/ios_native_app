//
//  SPLAnalytics.h
//  Snowpool
//
//  Created by Tim Ross on 29/04/14.
//  Copyright (c) 2014 Snowpool Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPLAnalytics : NSObject

+ (instancetype)sharedInstance;

- (void)startSession;
- (void)endSession;
- (void)sendScreenView:(NSString *)screenName;
- (void)sendEventWithCategory:(NSString *)category action:(NSString *)action label:(NSString *)label value:(NSNumber *)value;

- (void)sendEventUserDidCreateCarpoolWithSkifieldID:(NSNumber *)skifieldID;

@end
