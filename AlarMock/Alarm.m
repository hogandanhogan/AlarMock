//
//  Alarm.m
//  AlarMock
//
//  Created by Patrick Hogan on 8/29/14.
//  Copyright (c) 2014 AlarMock Industries. All rights reserved.
//

#import "Alarm.h"
#import "SnoozeJokes.h"
#import "AlarmJokes.h"

@interface Alarm ()

@property (nonatomic) UILocalNotification *notification;
@property (nonatomic, getter = hasSnoozed) BOOL snoozed;

@end

@implementation Alarm

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)decoder
{
    //Encode Jokes at some point
    self = [super init];
    
    if (self) {
        self.notification = [decoder decodeObjectForKey:@"notification"];
        self.snoozeInterval = [[decoder decodeObjectForKey:@"snoozeInterval"] floatValue];
        self.alarmSong = [decoder decodeObjectForKey:@"alarmSong"];
        self.on = [[decoder decodeObjectForKey:@"on"] boolValue];
        self.snoozed = [[decoder decodeObjectForKey:@"hasSnoozed"] boolValue];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.notification forKey:@"notification"];
    [encoder encodeObject:@(self.snoozeInterval) forKey:@"snoozeInterval"];
    [encoder encodeObject:self.alarmSong forKey:@"alarmSong"];
    [encoder encodeObject:@(self.hasSnoozed) forKey:@"hasSnoozed"];
    [encoder encodeObject:@(self.on) forKey:@"on"];
}

#pragma mark - Jokes

- (void)updateAlertBody
{
    if (self.hasSnoozed) {
        self.notification.alertBody = self.snoozeJokes.joke;
    } else {
        self.notification.alertBody = self.alarmJokes.joke;
    }
}

#pragma mark - Accesors

- (void)setSnoozed:(BOOL)snoozed
{
    if (self.snoozed == snoozed) {
        return;
    }
    
    _snoozed = snoozed;
    [self updateAlertBody];
}

- (void)setFireDate:(NSDate *)fireDate
{
    _fireDate = fireDate;
    self.notification.fireDate = fireDate;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:self.notification];
}

-(void)setAlarmJokes:(AlarmJokes *)alarmJokes
{
    _alarmJokes = alarmJokes;
    [self updateAlertBody];
}

-(void)setSnoozeJokes:(SnoozeJokes *)snoozeJokes
{
    _snoozeJokes = snoozeJokes;
    [self updateAlertBody];
}

-(UILocalNotification *)notification
{
    if (!_notification) {
        self.notification = [UILocalNotification new];
        _notification.timeZone = [NSTimeZone defaultTimeZone];
    }
    
    return _notification;
}

@end