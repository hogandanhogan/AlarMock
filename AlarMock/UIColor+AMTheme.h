//
//  UIColor+AMTheme.h
//  AlarMock
//
//  Created by Patrick Hogan on 9/6/14.
//  Copyright (c) 2014 AlarMock Industries. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (AMTheme)

+ (NSArray *)am_backgroundGradientColors;

+ (instancetype)am_switchTintColor;
+ (instancetype)am_switchThumbColor;

+ (instancetype)am_lightBlueColor;
+ (instancetype)am_darkBlueColor;
+ (instancetype)am_lightGrayColor;
+ (instancetype)am_whiteColor;
+ (instancetype)am_blackColor;

@end
