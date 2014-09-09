//
//  UIFont+AMTheme.m
//  AlarMock
//
//  Created by Patrick Hogan on 9/6/14.
//  Copyright (c) 2014 AlarMock Industries. All rights reserved.
//

#import "UIFont+AMTheme.h"

static NSString * const kFontClanOTBook = @"ClanOT-Book";
static NSString * const kFontClanNarrowMedium = @"ClanOT-NarrMedium";

@implementation UIFont (AMTheme)

#pragma mark - Book
//TODO:split font properties ie. am_snoozeLabelFont, am_barButtonItemFont...., same with colors not a number
+ (instancetype)am_book14
{
    return [self am_bookWithSize:14.0f];
}

+ (instancetype)am_book16
{
    return [self am_bookWithSize:16.0f];
}

+ (instancetype)am_book22
{
    return [self am_bookWithSize:22.0f];
}

+ (instancetype)am_book28
{
    return [self am_bookWithSize:28.0f];
}

+ (instancetype)am_book48
{
    return [self am_bookWithSize:48.0f];
}

+ (instancetype)am_bookWithSize:(CGFloat)size
{
    return [self fontWithName:kFontClanOTBook size:size];
}

#pragma mark - Narrow Medium

+ (instancetype)am_narrowMedium14
{
    return [self am_narrowMediumWithSize:14.0f];
}

+ (instancetype)am_narrowMediumWithSize:(CGFloat)size
{
    return [self fontWithName:kFontClanNarrowMedium size:size];
}

@end
