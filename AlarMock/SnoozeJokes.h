//
//  SnoozeJokes.h
//  AlarMock
//
//  Created by Ben Bueltmann on 8/25/14.
//  Copyright (c) 2014 AlarMock Industries. All rights reserved.
//

#import <Parse/Parse.h>
#import <Parse/PFObject+Subclass.h>

@interface SnoozeJokes : PFObject<PFSubclassing>

@property NSString *joke;

+(void)load;

@end