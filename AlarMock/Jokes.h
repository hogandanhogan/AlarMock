//
//  Jokes.h
//  AlarMock
//
//  Created by Ben Bueltmann on 8/25/14.
//  Copyright (c) 2014 AlarMock Industries. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JokesManager <NSObject>
//used to be just *jokes
@optional
-(void)alarmJokesReturned:(NSArray *)alarmJokesReturned;
-(void)snoozeJokesReturned:(NSArray *)snoozeJokesReturned;

@end
@interface Jokes : NSObject

@property id<JokesManager>delegate;
//@property NSArray *alarmJokes;
//@property NSArray *snoozeJokes;

-(void)queryAlarmJokes;
-(void)querySnoozeJokes;

@end
