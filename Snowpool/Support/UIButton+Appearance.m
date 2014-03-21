//
//  UIButton+Appearance.m
//  Snowpool
//
//  Created by Tim Ross on 15/03/14.
//  Copyright (c) 2014 Snowpool Limited. All rights reserved.
//

#import "UIButton+Appearance.h"

@implementation UIButton (Appearance)

- (void)spl_setTitleFont:(UIFont *)font
{
    self.titleLabel.font = font;
}

@end
