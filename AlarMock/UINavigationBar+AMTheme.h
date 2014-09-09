//
//  UINavigationBar+AMTheme.h
//  AlarMock
//
//  Created by Patrick Hogan on 9/8/14.
//  Copyright (c) 2014 AlarMock Industries. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, AMNavigationBarStyle) {
    AMNavigationBarStyleDark,
    AMNavigationBarStyleLight
};

@interface UINavigationBar (AMTheme)

+ (void)setAm_AppearanceStyle:(AMNavigationBarStyle)style;

@end
