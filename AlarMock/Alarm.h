//
//  Alarm.h
//  AlarMock
//
//  Created by Patrick Hogan on 8/29/14.
//  Copyright (c) 2014 AlarMock Industries. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface Alarm : NSObject <NSCoding>

@property UILocalNotification *notification;
@property float snoozeInterval;
@property MPMediaItem *alarmSong;
@property BOOL on;

@end
