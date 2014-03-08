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
@property (nonatomic, readonly) BOOL isSeeking;

+ (NSArray *)carpoolsFromArray:(NSArray *)carpoolArray;

- (id)initWithDictionary:(NSDictionary *)dict;

@end
