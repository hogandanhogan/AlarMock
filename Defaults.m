//
//  Defaults.m
//  AlarMock
//
//  Created by Patrick Hogan on 8/23/14.
//  Copyright (c) 2014 AlarMock Industries. All rights reserved.
//

#import "Defaults.h"
#import "TimePickerViewController.h"

@implementation Defaults

-(NSURL *)documentsDirectory
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *directories = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSLog(@"%@", directories.firstObject);
    return directories.firstObject;
}

-(void)save
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSURL *pList = [[self documentsDirectory] URLByAppendingPathComponent:@"colors.plist"];
    
    [self.alarms writeToURL:pList atomically:YES];
    [defaults setObject:[NSDate date] forKey:@"LastSaved"];
    [defaults synchronize];
}

-(void)load
{
    NSURL *pList = [[self documentsDirectory] URLByAppendingPathComponent:@"colors.plist"];
    self.alarms = [NSMutableArray arrayWithContentsOfURL:pList];
}

@end
