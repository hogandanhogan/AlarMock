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

+ (instancetype)book22
{
    return [self bookWithSize:36.0f];
}

+ (instancetype)bookWithSize:(CGFloat)size
{
    return [self fontWithName:kFontClanOTBook size:size];
}

#pragma mark - Narrow Medium

+ (instancetype)narrowMediumWithSize:(CGFloat)size
{
    return [self fontWithName:kFontClanNarrowMedium size:size];
}

@end
