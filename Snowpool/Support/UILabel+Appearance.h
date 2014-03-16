//
//  UILabel+Appearance.h
//  Snowpool
//
//  Created by Tim Ross on 16/03/14.
//  Copyright (c) 2014 Snowpool Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Appearance)

- (void)spl_setFont:(UIFont *)font UI_APPEARANCE_SELECTOR;
- (void)spl_setTextColor:(UIColor *)color UI_APPEARANCE_SELECTOR;

@end
