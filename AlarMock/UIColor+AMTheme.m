//
//  UIColor+AMTheme.m
//  AlarMock
//
//  Created by Patrick Hogan on 9/6/14.
//  Copyright (c) 2014 AlarMock Industries. All rights reserved.
//

#import "UIColor+AMTheme.h"

@implementation UIColor (AMTheme)

#pragma mark - Background

+ (NSArray *)am_backgroundGradientColors
{
    return @[(id)[[UIColor am_darkBlue] CGColor], (id)[[UIColor am_lightBlue] CGColor]];
}

#pragma mark - Switch

+ (instancetype)am_switchTintColor
{
    return [UIColor colorWithRed:0.5f green:0.5f blue:0.65f alpha:1.0f];
}

#pragma mark -

+ (instancetype)am_lightBlue
{
    return [UIColor colorWithRed:38.0f/255.0f green:33.0f/255.0f blue:73.0f/255.0f alpha:1.0f];
}

+ (instancetype)am_darkBlue
{
    return [UIColor colorWithRed:0.0f/255.0f green:110.0f/255.0f blue:155.0f/255.0f alpha:1.0f];
}

@end
