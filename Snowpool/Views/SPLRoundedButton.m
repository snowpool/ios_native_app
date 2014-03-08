//
//  SPLRoundedButton.m
//  AirPipes
//
//  Created by Tim Ross on 6/03/14.
//  Copyright (c) 2014 ElucidCode Limited. All rights reserved.
//

#import "SPLRoundedButton.h"
#import <QuartzCore/QuartzCore.h>

@implementation SPLRoundedButton

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.layer.cornerRadius = 4;
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    [self setNeedsLayout];
}

@end
