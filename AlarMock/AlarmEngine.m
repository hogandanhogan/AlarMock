//
//  AlarmLogic.m
//  AlarMock
//
//  Created by Patrick Hogan on 8/27/14.
//  Copyright (c) 2014 AlarMock Industries. All rights reserved.
//

#import "AlarmEngine.h"

@implementation AlarmEngine

+ (AlarmEngine *)loadFromSavedData
{
//Call this in the AppDelegate to instantiate from serialized data.  Use NSKeyedUnarchiver to deserialize this object from the defaults.
    return nil;
}

- (Alarm *)addAlarm
{
//(return the created alarm in case you need to turn it off or on immediately)
    return nil;
}

- (void)snoozeAlarmWithFireDate:(NSDate *)fireDate
{
    
}

- (void)removeAlarmWithFireDate:(NSDate *)fireDate
{
    
}

- (void)removeAlarm:(Alarm *)alarm
{
    
    
}

- (void)save
{
    
    //Call this every time you add or remove an alarm inside of the public methods listed above.

}
- alarmWithFireDate:(NSDate *)fireDate
{
    //(iterate through array of alarms and find the alarm with the given fire date and return it.  This will be useful when you are trying to remove or snooze an alarm that just went off)
    return nil;
}
@end
