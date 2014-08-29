//
//  Alarm.m
//  AlarMock
//
//  Created by Patrick Hogan on 8/29/14.
//  Copyright (c) 2014 AlarMock Industries. All rights reserved.
//

#import "Alarm.h"

@implementation Alarm

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    
    if (!self) {
        self.notification = [decoder decodeObjectForKey:@"notification"];
        self.snoozeInterval = [[decoder decodeObjectForKey:@"snoozeInterval"] floatValue];
        self.alarmSong = [decoder decodeObjectForKey:@"alarmSong"];
        self.on = [[decoder decodeObjectForKey:@"on"] boolValue];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    if (self.on) {
        [encoder encodeObject:self.notification forKey:@"notification"];
        [encoder encodeObject:@(self.snoozeInterval) forKey:@"snoozeInterval"];
        [encoder encodeObject:self.alarmSong forKey:@"alarmSong"];
        [encoder encodeObject:@(self.on) forKey:@"on"];
        
    }
    
}

@end