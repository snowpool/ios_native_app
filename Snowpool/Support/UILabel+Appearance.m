//
//  UILabel+Appearance.m
//  Snowpool
//
//  Created by Tim Ross on 16/03/14.
//  Copyright (c) 2014 Snowpool Limited. All rights reserved.
//

#import "UILabel+Appearance.h"

@implementation UILabel (Appearance)

- (void)spl_setFont:(UIFont *)font
{
    self.font = font;
}

- (void)spl_setTextColor:(UIColor *)color
{
    self.textColor = color;
}

@end
