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


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Parse setApplicationId:@"I62Vun47l0d1KLv218eijHMxPG9dK6nxy54DtqQl" clientKey:@"rLVtvCOQVMqLrb5qijsmuC2y0MZAHVyZubSrFYqC"];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    return YES;
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{

    [[NSNotificationCenter defaultCenter] postNotificationName:@"openedWithNotification" object:nil];
//    id vc = self.window.rootViewController;
//    vc = [vc viewControllers].firstObject;
// I believe this may be the place where we need to put the av player and the MPMediaItemPropertyAssetURL shit
}

@end
