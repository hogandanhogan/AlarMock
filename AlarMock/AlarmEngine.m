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
//    static NSString *const kAlarmEngineDefaultsKey = @"kAlarmEngineDefaultsKey";
//    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
//    [NSKeyedUnarchiver unarchiveObjectWithData:prefs];
//    NSArray *defaults = [[NSMutableArray alloc] initWithArray:[prefs objectForKey:@"kAlarmEngineDefaultsKey"]] ?: [[self alloc] init];
//
//    [NSKeyedUnarchiver unarchiveObjectWithData:defaults];
    NSArray *dataArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"kAlarmEngineDefaultsKey"];
    NSArray *alarms = [NSKeyedUnarchiver unarchiveObjectWithData:data];


    return nil;
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
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:[self.alarms lastObject]];
    NSMutableArray *alarmsData = [NSMutableArray array];
    [alarmsData addObject:data];

    static NSString *const kAlarmEngineDefaultsKey = @"kAlarmEngineDefaultsKey";

    [[NSUserDefaults standardUserDefaults] setObject:alarmsData forKey:kAlarmEngineDefaultsKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
