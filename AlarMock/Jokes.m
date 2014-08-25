//
//  Jokes.m
//  AlarMock
//
//  Created by Ben Bueltmann on 8/25/14.
//  Copyright (c) 2014 AlarMock Industries. All rights reserved.
//

#import "Jokes.h"

@implementation Jokes

//-(void)makeJokes
//{
//    self.snoozeJokes = [NSArray arrayWithObjects:@"What did you do last night that you've pressed snooze 8 times?", @"Ouch, that hurts", @"I'm trying not to take this personally", nil];
//    self.alarmJokes = [NSArray arrayWithObjects:@"Well, you're another day closer to death…", @"So, you've finally decided to get out of bed…", @"If I had a hand, I'd slap you…", @"Time to make the donuts…", nil];
//}

-(id)init
{
    if (self = [super init])
    {
        self.snoozeJokes = [NSArray arrayWithObjects:@"What did you do last night that you've pressed snooze 8 times?",
                            @"Ouch, that hurts", @"I'm trying not to take this personally",
                            nil];
        self.alarmJokes = [NSArray arrayWithObjects:@"Well, you're another day closer to death…",
                           @"So, you've finally decided to get out of bed…",
                           @"If I had a hand, I'd slap you…", @"Time to make the donuts…",
                           nil];
    }
    return self;

}
@end
