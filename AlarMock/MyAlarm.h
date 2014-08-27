@import UIKit;

@interface MyAlarm : NSObject
@property NSDate *time;
@property (copy) NSString *message;
@property (copy) NSArray *daysToRepeat;
@property BOOL shouldSnooze;

-(UILocalNotification *)notificationValue;
@end
