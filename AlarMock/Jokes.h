//
//  Jokes.h
//  AlarMock
//
//  Created by Ben Bueltmann on 8/25/14.
//  Copyright (c) 2014 AlarMock Industries. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JokesManager <NSObject>

-(void)alarmJokesReturned:(NSArray *)jokes;

@end
@interface Jokes : NSObject

@property id<JokesManager>delegate;
@property NSArray *alarmJokes;
@property NSArray *snoozeJokes;

-(void)queryAlarmJokes;

@end
