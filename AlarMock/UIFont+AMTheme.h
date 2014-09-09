//
//  UIFont+AMTheme.h
//  AlarMock
//
//  Created by Patrick Hogan on 9/6/14.
//  Copyright (c) 2014 AlarMock Industries. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (AMTheme)

+ (instancetype)am_book14;
+ (instancetype)am_book16;
+ (instancetype)am_book22;
+ (instancetype)am_book28;
+ (instancetype)am_book48;
+ (instancetype)am_bookWithSize:(CGFloat)size;

+ (instancetype)am_narrowMedium14;
+ (instancetype)am_narrowMediumWithSize:(CGFloat)size;

@end
