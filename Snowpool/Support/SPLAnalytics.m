//
//  SPLAnalytics.m
//  Snowpool
//
//  Created by Tim Ross on 29/04/14.
//  Copyright (c) 2014 Snowpool Limited. All rights reserved.
//

#import "SPLAnalytics.h"
#import <GoogleAnalytics-iOS-SDK/GAI.h>
#import <GoogleAnalytics-iOS-SDK/GAIFields.h>
#import <GoogleAnalytics-iOS-SDK/GAIDictionaryBuilder.h>

@interface SPLAnalytics ()

@property (nonatomic, assign) id<GAITracker> tracker;

@end

@implementation SPLAnalytics

+ (instancetype)sharedInstance
{
    static SPLAnalytics *sharedInstance = nil;
    
    @synchronized(self) {
        if (!sharedInstance) {
            sharedInstance = [[SPLAnalytics alloc] init];
        }
    }
    return sharedInstance;
}

- (id)init
{
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    [GAI sharedInstance].dispatchInterval = 20;
    [[GAI sharedInstance].logger setLogLevel:kGAILogLevelError];
    return [self initWithTracker:[[GAI sharedInstance] trackerWithTrackingId:SPLAnalyticsTrackingID]];
}

- (id)initWithTracker:(id<GAITracker>)tracker
{
    if (self = [super init]) {
        self.tracker = tracker;
    }
    return self;
}

- (void)startSession
{
    DebugLog(@"SPLAnalytics: startSession");
    [_tracker set:kGAISessionControl value:@"start"];
}

- (void)endSession
{
    DebugLog(@"SPLAnalytics: endSession");
    [_tracker set:kGAISessionControl value:@"end"];
}

- (void)sendScreenView:(NSString *)screenName
{
    DebugLog(@"SPLAnalytics: sendScreenView: %@", screenName);
    [_tracker set:kGAIScreenName value:screenName];
    [_tracker send:[[GAIDictionaryBuilder createAppView] build]];
}

- (void)sendEventWithCategory:(NSString *)category action:(NSString *)action label:(NSString *)label value:(NSNumber *)value
{
    DebugLog(@"SPLAnalytics: sendEventWithCategory: %@, action: %@, label: %@", category, action, label);
    [_tracker send:[[GAIDictionaryBuilder createEventWithCategory:category
                                                           action:action
                                                            label:label
                                                            value:value] build]];
}

- (void)sendEventUserDidCreateCarpoolWithSkifieldID:(NSNumber *)skifieldID
{
    [self sendEventWithCategory:@"Carpool" action:@"Created" label:@"Skifield" value:skifieldID];
}

@end
