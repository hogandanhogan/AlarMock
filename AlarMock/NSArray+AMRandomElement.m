//
//  NSArray+AMRandomElement.m
//  AlarMock
//
//  Created by Patrick Hogan on 9/1/14.
//  Copyright (c) 2014 AlarMock Industries. All rights reserved.
//

#import "NSArray+AMRandomElement.h"

@implementation NSArray (AMRandomElement)

- (id)am_randomElement
{
    if (!self.count) {
        return nil;
    }
    
    return self[arc4random_uniform(self.count)];
}

@end
