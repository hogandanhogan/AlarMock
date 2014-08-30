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

@property (nonatomic, readonly) NSArray *alarms;

@property (nonatomic, weak) id<AlarmEngineDelegate> delegate;

- (void)addAlarm:(Alarm *)alarm;
- (void)removeAlarm:(Alarm *)alarm;
+ (instancetype)loadFromSavedData;

@end
