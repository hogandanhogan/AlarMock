//
//  TimePickerViewController.h
//  AlarMock
//
//  Created by Rick Wolchuk on 8/22/14.
//  Copyright (c) 2014 AlarMock Industries. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>
#import "AMViewController.h"

@class AlarmEngine;
@class Alarm;

@interface AddAlarmViewController : AMViewController

@property (nonatomic) AlarmEngine *alarmEngine;

@property (strong, nonatomic) Alarm *currentAlarm;
@property NSString *notificationSound;

@end
