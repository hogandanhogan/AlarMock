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
    return @[(id)[[UIColor am_darkBlueColor] CGColor], (id)[[UIColor am_lightBlueColor] CGColor]];
}

#pragma mark - Switch

+ (instancetype)am_switchTintColor
{
    return [UIColor colorWithRed:0.29f green:0.40f blue:0.56f alpha:1.0f];
}

+ (instancetype)am_switchThumbColor
{
    return [UIColor am_whiteColor];
}

#pragma mark - 

+ (instancetype)am_lightBlueColor
{
    return [UIColor colorWithRed:0.13f green:0.18f blue:0.34f alpha:1.0f];
//    return [UIColor colorWithRed:0.11f green:0.44f blue:0.60f alpha:1.0f];
}

+ (instancetype)am_darkBlueColor
{
    return [UIColor colorWithRed:0.11f green:0.44f blue:0.60f alpha:1.0f];
//    return [UIColor colorWithRed:0.13f green:0.18f blue:0.34f alpha:1.0f];
}

+ (instancetype)am_lightGrayColor
{
    return [UIColor colorWithRed:0.78f green:0.78f blue:0.8f alpha:1];
}

+ (instancetype)am_whiteColor
{
    return [UIColor colorWithRed:0.95f green:0.95f blue:1.0f alpha:1];
}

+ (instancetype)am_blackColor
{
    return [UIColor colorWithWhite:0.2f alpha:1.0f];
}

@end
