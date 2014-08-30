//
//  AlarmLogic.m
//  AlarMock
//
//  Created by Patrick Hogan on 8/27/14.
//  Copyright (c) 2014 AlarMock Industries. All rights reserved.
//

#import "AlarmEngine.h"

static NSString * const kAlarmEngineDefaultsKey;

@implementation AlarmEngine
{
    NSMutableArray *_alarms;
}

+ (instancetype)loadFromSavedData
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kAlarmEngineDefaultsKey] ?: [[self alloc] init];
}

- (id)init
{
    self = [super init];
    if (self) {
        _alarms = [NSMutableArray array];
    }
    return self;
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    
    if (self) {
        _alarms = [[decoder decodeObjectForKey:@"alarms"] mutableCopy] ?: [NSMutableArray array];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:_alarms forKey:@"alarms"];
}

- (void)addAlarm:(Alarm *)alarm
{
    if ([_alarms containsObject:alarm]) {
        return;
    }

    [_alarms addObject:alarm];
    [self save];
}

- (void)removeAlarm:(Alarm *)alarm
{
    if (![_alarms containsObject:alarm]) {
        return;
    }
    
    [_alarms removeObject:alarm];
    [self save];
}

- (void)save
{
    [[NSUserDefaults standardUserDefaults] setObject:self forKey:kAlarmEngineDefaultsKey];
}

@end
