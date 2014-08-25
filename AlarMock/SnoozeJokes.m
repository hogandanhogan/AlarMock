//
//  SnoozeJokes.m
//  AlarMock
//
//  Created by Ben Bueltmann on 8/25/14.
//  Copyright (c) 2014 AlarMock Industries. All rights reserved.
//

#import "SnoozeJokes.h"

@implementation SnoozeJokes

+(NSString *)parseClassName
{
    return @"SnoozeJokes";
}

+(void)load
{
    [self registerSubclass];
}



@dynamic joke;
@end
