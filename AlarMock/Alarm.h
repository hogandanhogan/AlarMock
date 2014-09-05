//
//  Alarm.h
//  AlarMock
//
//  Created by Patrick Hogan on 8/29/14.
//  Copyright (c) 2014 AlarMock Industries. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>

@class JokeCollection;

@interface Alarm : NSObject <NSCoding>

@property (nonatomic) NSTimeInterval snoozeInterval;
@property (nonatomic) MPMediaItem *alarmSong;
@property (nonatomic) BOOL on;
@property (nonatomic) NSDate *fireDate;
@property (nonatomic) NSMutableArray *daysRepeated;
@property (nonatomic) NSArray *daysChecked;

- (id)initWithJokeCollection:(JokeCollection *)jokeCollection;
-(NSDate *) getDateOfSpecificDay:(NSInteger ) day;

- (void)alarmWillFire;
- (void)alarmWillNotFire;
- (void)snooze;
- (void)stop;

@end
