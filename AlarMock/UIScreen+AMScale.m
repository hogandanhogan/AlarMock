//
//  UIScreen+AMScale.m
//  AlarMock
//
//  Created by Patrick Hogan on 9/6/14.
//  Copyright (c) 2014 AlarMock Industries. All rights reserved.
//

#import "UIScreen+AMScale.h"

@implementation UIScreen (AMScale)

- (CGFloat)am_scaledDimensionWithPixelSize:(CGFloat)pixelSize
{
    return pixelSize/self.scale;
}

@end
