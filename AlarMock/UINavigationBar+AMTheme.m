//
//  UINavigationBar+AMTheme.m
//  AlarMock
//
//  Created by Patrick Hogan on 9/8/14.
//  Copyright (c) 2014 AlarMock Industries. All rights reserved.
//

#import "UINavigationBar+AMTheme.h"

#import "UIColor+AMTheme.h"
#import "UIFont+AMTheme.h"

@implementation UINavigationBar (AMTheme)

+ (void)setAm_AppearanceStyle:(AMNavigationBarStyle)style
{
    UIColor *textColor;
    UIStatusBarStyle statusBarStyle;
    switch (style) {
        case AMNavigationBarStyleDark:
            textColor = [UIColor am_whiteColor];
            statusBarStyle = UIStatusBarStyleLightContent;
            break;
        case AMNavigationBarStyleLight:
        default:
            textColor = [UIColor am_blackColor];
            statusBarStyle = UIStatusBarStyleDefault;
            break;
    }
    [[self appearance] setTitleTextAttributes: @{ NSFontAttributeName : [UIFont am_narrowMedium14], NSForegroundColorAttributeName: textColor }];
    [[UIApplication sharedApplication] setStatusBarStyle:statusBarStyle animated:YES];
}

@end
