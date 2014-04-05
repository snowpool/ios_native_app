//
//  SPLUserDefaults.h
//  Snowpool
//
//  Created by Tim Ross on 8/03/14.
//  Copyright (c) 2014 Snowpool Limited. All rights reserved.
//

#import "GVUserDefaults.h"

@interface SPLUserDefaults : GVUserDefaults

@property (nonatomic, strong) NSNumber *selectedCountryKey;
@property (nonatomic, strong) NSString *telephone;
@property (nonatomic, strong) NSString *city;

+ (instancetype)standardUserDefaults;

- (void)synchronize;

@end
