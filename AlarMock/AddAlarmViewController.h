//
//  TimePickerViewController.h
//  AlarMock
//
//  Created by Rick Wolchuk on 8/22/14.
//  Copyright (c) 2014 AlarMock Industries. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>

@class AlarmEngine;
@class Alarm;

@interface AddAlarmViewController : UIViewController

@property (nonatomic) AlarmEngine *alarmEngine;
@property (nonatomic) Alarm *currentAlarm;
@property (nonatomic) NSArray *daysChecked;
@property (nonatomic) MPMediaItem *alarmSong;

@end
