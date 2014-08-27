//
//  AlarmEngine.m
//  AlarMock
//
//  Created by Rick Wolchuk on 8/26/14.
//  Copyright (c) 2014 AlarMock Industries. All rights reserved.
//

#import "AlarmEngine.h"
#import "RepeatViewController.h"

@implementation AlarmEngine

-(void)repeatdaysSelected:(int)selectedDays
{
    NSLog(@"The Day you selected is %i", selectedDays);
}

@end
