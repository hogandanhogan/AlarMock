//
//  Alarm.h
//  AlarMock
//
//  Created by Patrick Hogan on 8/29/14.
//  Copyright (c) 2014 AlarMock Industries. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>

@class AlarmJokes;
@class SnoozeJokes;

@interface Alarm : NSObject <NSCoding>

@property (nonatomic) NSTimeInterval snoozeInterval;
@property (nonatomic) MPMediaItem *alarmSong;
//days repeat property
@property (nonatomic) BOOL on;
@property (nonatomic) NSDate *fireDate;
@property (nonatomic) AlarmJokes *alarmJokes;
@property (nonatomic) SnoozeJokes *snoozeJokes;

@end
