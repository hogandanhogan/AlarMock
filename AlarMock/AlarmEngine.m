//
//  AlarmLogic.m
//  AlarMock
//
//  Created by Patrick Hogan on 8/27/14.
//  Copyright (c) 2014 AlarMock Industries. All rights reserved.
//

#import "AlarmEngine.h"

#import "Alarm.h"
#import "AlarmJoke.h"
#import "JokeCollection.h"
#import "SnoozeJoke.h"

static NSString * const kAlarmEngineDefaultsKey = @"AlarmEngineDefaultsKey";

@interface AlarmEngine ()

@property (nonatomic) JokeCollection *jokeCollection;

@end

@implementation AlarmEngine
{
    NSMutableArray *_alarms;
}

#pragma mark - Initialization

- (id)init
{
    self = [super init];

    if (self) {
        _alarms = [NSMutableArray array];
        [self updateJokes];
    }
    
    return self;
}

#pragma mark - NSCoding

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [self init];
    
    if (self) {
        _alarms = [[decoder decodeObjectForKey:@"alarms"] mutableCopy] ?: [NSMutableArray array];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleAlarmValueChanged:) name:kAlarmValueChangedNotification object:nil];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:_alarms forKey:@"alarms"];
}

#pragma mark - KVO

- (void)handleAlarmValueChanged:(Alarm *)alarm
{
    [self save];
}

#pragma mark - Collection

- (void)addAlarm:(Alarm *)alarm
{
    if ([self.alarms containsObject:alarm]) {
        return;
    }

    [_alarms addObject:alarm];
    [self addAlarm:alarm];
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

- (Alarm *)alarmWithFireDate:(NSDate *)fireDate
{
    NSLog(@"alarms in AlarmEngine: %@", self.alarms);
    for (Alarm *alarm in _alarms) {
        if ([alarm.fireDate isEqual:fireDate]) {
            return alarm;
        }
    }
    return nil;
}

#pragma mark - Jokes

- (void)updateJokes
{
    [self.jokeCollection queryAlarmJokesWithHandler:^(NSArray *alarmJokes, NSError *error) { }];
    [self.jokeCollection querySnoozeJokesWithHandler:^(NSArray *snoozeJokes, NSError *error) { }];
}

#pragma mark - Persistence

+ (instancetype)loadFromSavedData
{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:kAlarmEngineDefaultsKey];
    AlarmEngine *alarmEngine = [NSKeyedUnarchiver unarchiveObjectWithData:data] ?: [[self alloc] init];
    return alarmEngine;
}

- (void)save
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:kAlarmEngineDefaultsKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - Accessors

- (JokeCollection *)jokeCollection
{
    if (!_jokeCollection) {
        self.jokeCollection = [JokeCollection new];
    }
    
    return _jokeCollection;
}

- (NSString *)randomAlarmJoke
{
    return self.jokeCollection.randomAlarmJoke;
}

- (NSString *)randomSnoozeJoke
{
    return self.jokeCollection.randomSnoozeJoke;
}

#pragma mark - Description

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ - Alarms: %@", [super description], _alarms];
}

@end
