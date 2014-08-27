//
//  Jokes.m
//  AlarMock
//
//  Created by Ben Bueltmann on 8/25/14.
//  Copyright (c) 2014 AlarMock Industries. All rights reserved.
//

#import "Jokes.h"

@implementation Jokes


-(id)init
{
    if (self = [super init])
    {

    }
    return self;

}

-(void)queryAlarmJokes
{
    PFQuery *query = [PFQuery queryWithClassName:@"AlarmJokes"];
    query.cachePolicy = kPFCachePolicyNetworkElseCache;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error)
        {
            NSLog(@"%@", error);
        }
        else
        {
            [self.delegate alarmJokesReturned:objects];
        
        }
    }];
}

-(void)querySnoozeJokes
{
    PFQuery *query = [PFQuery queryWithClassName:@"SnoozeJokes"];
    query.cachePolicy = kPFCachePolicyNetworkElseCache;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"%@", error);
        }
        else {
            [self.delegate snoozeJokesReturned:objects];
        }
    }];
}
@end
