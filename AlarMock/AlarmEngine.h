//
//  AlarmLogic.h
//  AlarMock
//
//  Created by Patrick Hogan on 8/27/14.
//  Copyright (c) 2014 AlarMock Industries. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Alarm.h"

@protocol AlarmEngineDelegate

- (Alarm *)addAlarm;

@end

@interface AlarmEngine : NSObject

@property NSArray *alarms;
@property id<AlarmEngineDelegate> delegate;

- (void)snoozeAlarmWithFireDate:(NSDate *)fireDate;
- (void)removeAlarmWithFireDate:(NSDate *)fireDate;
- (void)removeAlarm:(Alarm *)alarm;
+ (Alarm *)loadFromSavedData;

@end
