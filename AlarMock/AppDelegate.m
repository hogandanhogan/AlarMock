//
//  AppDelegate.m
//  AlarMock
//
//  Created by Ben Bueltmann on 8/22/14.
//  Copyright (c) 2014 AlarMock Industries. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import "Jokes.h"
#import "AlarMockViewController.h"
#import "AddAlarmViewController.h"
#import "Alarm.h"



@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Parse setApplicationId:@"I62Vun47l0d1KLv218eijHMxPG9dK6nxy54DtqQl" clientKey:@"rLVtvCOQVMqLrb5qijsmuC2y0MZAHVyZubSrFYqC"];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    return YES;
}

+ (Alarm *)loadFromSavedData;
{
    return nil;
}


- (void)application:(UIApplication *)application
didReceiveLocalNotification:(UILocalNotification *)notification
{
    id vc = self.window.rootViewController;
    vc = [vc viewControllers].firstObject;
    
    Jokes *snoozejoke = [Jokes new];
    [snoozejoke queryAlarmJokes];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Wake the fuck up"
                                                        message:nil
                                                       delegate:vc
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"Snooze",
                                                                @"Dismiss",nil];
    [alertView show];
}

@end
