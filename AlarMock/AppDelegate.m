//
//  AppDelegate.m
//  AlarMock
//
//  Created by Ben Bueltmann on 8/22/14.
//  Copyright (c) 2014 AlarMock Industries. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "AppDelegate.h"
#import <Parse/Parse.h>
#import "AlarmJoke.h"
#import "SnoozeJoke.h"
#import "AlarMockViewController.h"
#import "AddAlarmViewController.h"
#import "Alarm.h"
#import "AlarmEngine.h"

@interface AppDelegate ()

@property (nonatomic) AlarmEngine *alarmEngine;
@property (nonatomic, readonly) AlarMockViewController *rootViewController;
@property (nonatomic) AVPlayer *aVPlayer;

@property (nonatomic) NSMutableOrderedSet *alarmQueue;

@end

@implementation AppDelegate

#pragma mark - Application Lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Parse setApplicationId:@"I62Vun47l0d1KLv218eijHMxPG9dK6nxy54DtqQl" clientKey:@"rLVtvCOQVMqLrb5qijsmuC2y0MZAHVyZubSrFYqC"];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];

    self.alarmEngine = [AlarmEngine loadFromSavedData];
    self.rootViewController.alarmEngine = self.alarmEngine;
    
    return YES;
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    Alarm *alarm = [self.alarmEngine alarmWithFireDate:notification.fireDate];
    if (alarm) {
        [self.alarmQueue addObject:alarm];
        [self updateAlarmQueue];
    } else {
        NSLog(@"WARNING: Alarm fired, but was not saved in alarm engine persistence layer.");
    }
}

#pragma mark - Alarm Queue

- (void)updateAlarmQueue
{
    Alarm *firstFiredAlarm = self.alarmQueue.firstObject;
    if (firstFiredAlarm) {
        [[[UIAlertView alloc] initWithTitle:self.alarmEngine.randomAlarmJoke
                                    message:nil
                                   delegate:self
                          cancelButtonTitle:nil
                          otherButtonTitles:@"Snooze", @"Dismiss",nil] show];
        NSURL *songUrl = [firstFiredAlarm.alarmSong valueForProperty:MPMediaItemPropertyAssetURL];
        
        //MPMusicPlayerController *mPMusicPlayerController = [MPMusicPlayerController new];
        //TODO:This might be a bad idea. There is no way to do this anymore. The other alarms do it though
        //mPMusicPlayerController.volume = 1.0f;
        
        self.aVPlayer = [[AVPlayer alloc] initWithURL:songUrl];
        [self.aVPlayer play];
    }
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    Alarm *firstFiredAlarm = self.alarmQueue.firstObject;
    if (buttonIndex == 0) {
        [firstFiredAlarm snooze];
        [self.aVPlayer pause];
    } else {
        [firstFiredAlarm stop];
        [self.alarmQueue removeObject:firstFiredAlarm];
        [self.aVPlayer pause];
    }
    
}

#pragma mark - Accessors

- (AlarMockViewController *)rootViewController
{
    return ((UINavigationController *)self.window.rootViewController).viewControllers.firstObject;
}

- (NSMutableOrderedSet *)alarmQueue
{
    if (!_alarmQueue) {
        self.alarmQueue = [NSMutableOrderedSet new];
    }
    
    return _alarmQueue;
}

@end
