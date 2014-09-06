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

+ (instancetype)am_switchOnTintColor;
+ (instancetype)am_switchTintColor;

+ (instancetype)am_lightBlue;
+ (instancetype)am_darkBlue;

@end
