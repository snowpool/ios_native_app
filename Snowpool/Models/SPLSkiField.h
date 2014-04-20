//
//  SPLSkiField.h
//  Snowpool
//
//  Created by Patrick Davey on 9/03/14.
//  Copyright (c) 2014 Snowpool Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPLSkiField : NSObject

+ (NSDictionary *)allForCountryWithID:(NSNumber *)countryID;
+ (NSDictionary *)all;
+ (NSString *)titleForFieldWithID:(NSNumber *)fieldID;

@end
