//
//  SPLCarpool.h
//  Snowpool
//
//  Created by Tim Ross on 9/03/14.
//  Copyright (c) 2014 Snowpool Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPLCarpool : NSObject


@property (nonatomic, readonly) NSInteger carpoolID;
@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) NSString *start;
@property (nonatomic, readonly) NSString *leavingFrom;
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSString *fieldName;
@property (nonatomic, readonly) NSString *message;
@property (nonatomic, readonly) NSString *telephone;
@property (nonatomic, readonly) NSInteger spacesFree;
@property (nonatomic, readonly) NSInteger userID;
@property (nonatomic, readonly) NSInteger fieldID;
@property (nonatomic, readonly) BOOL isSeeking;
@property (nonatomic, readonly) BOOL hasDrivenBefore;

+ (NSArray *)carpoolsFromArray:(NSArray *)carpoolArray;

- (id)initWithDictionary:(NSDictionary *)dict;

@end
