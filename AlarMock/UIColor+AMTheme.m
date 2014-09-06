//
//  UIColor+AMTheme.m
//  AlarMock
//
//  Created by Patrick Hogan on 9/6/14.
//  Copyright (c) 2014 AlarMock Industries. All rights reserved.
//

#import "UIColor+AMTheme.h"

@implementation UIColor (AMTheme)

+ (NSArray *)am_backgroundGradientColors
{
    return @[(id)[[UIColor colorWithRed:0.0f/255.0f green:152.0f/255.0f blue:202.0f/255.0f alpha:1.0f] CGColor],
             (id)[[UIColor colorWithRed:43.0f/255.0f green:33.0f/255.0f blue:83.0f/255.0f alpha:1.0f] CGColor]];
}

+ (instancetype)am_switchOnTintColor
{
    return [UIColor colorWithRed:43.0f/255.0f green:33.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
}

+ (instancetype)am_switchTintColor
{
    return [UIColor colorWithRed:0.0f/255.0f green:152.0f/255.0f blue:202.0f/255.0f alpha:1.0f];
}

@end
