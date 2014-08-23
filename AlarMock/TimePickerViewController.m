//
//  TimePickerViewController.m
//  AlarMock
//
//  Created by Rick Wolchuk on 8/22/14.
//  Copyright (c) 2014 AlarMock Industries. All rights reserved.
//

#import "TimePickerViewController.h"


@interface TimePickerViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *settingsTableView;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UILabel *snoozeTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *seriouslyLabel;
@property NSMutableArray *alarms;

@end

@implementation TimePickerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.alarms = [NSMutableArray new];
    
    self.datePicker.date = [NSDate date];

    self.settingsTableView.scrollEnabled = NO;
    self.settingsTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.slider.hidden = YES;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingsCell"];
    NSArray *settings = [[NSArray alloc] initWithObjects:@"Repeat", @"Sound", @"Snooze", nil];
    cell.textLabel.text = [settings objectAtIndex:indexPath.row];
    UISwitch *switcheroo = [[UISwitch alloc] initWithFrame:CGRectZero];
    [switcheroo addTarget:self
                   action:@selector(changeSwitch:)
         forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:switcheroo];
    if ([cell.textLabel.text isEqualToString:@"Snooze"]) {
        cell.accessoryView  = switcheroo;
    }
    
    return cell;
}

- (void)changeSwitch:(id)sender
{
    if([sender isOn]) {
        self.slider.hidden = NO;
        self.snoozeTimeLabel.hidden = NO;
    } else{
        self.slider.hidden = YES;
        self.snoozeTimeLabel.hidden = YES;
    }
}

- (IBAction)onSavePressed:(id)sender
{
    NSDate *date = [NSDate new];
    date = self.datePicker.date;
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.timeZone = [NSTimeZone defaultTimeZone];
    dateFormatter.dateStyle = NSDateFormatterShortStyle;
    dateFormatter.timeStyle = NSDateFormatterShortStyle;
    [dateFormatter setDateFormat:@"h:mm a"];
    NSString *timeString = [dateFormatter stringFromDate:date];

    [self.alarms addObject:timeString];
    [self saveDefault:timeString];
    
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = self.datePicker.date;
    localNotification.alertBody = @"Wake up fucko";
    localNotification.alertAction = @"Snooze";
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    //localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

- (IBAction)onMoveSlider:(id)sender
{
    UISlider *slider = (UISlider *)sender;
    float val = 1 + slider.value * 58.0f;
    
    if (val == 1) {
        self.snoozeTimeLabel.text =[NSString stringWithFormat:@"Snooze for %ld minute", (long)val];
    } else {
        self.snoozeTimeLabel.text = [NSString stringWithFormat:@"Snooze for %ld minutes", (long)val];
    }
    
    if (val >=1 && val < 21) {
        self.seriouslyLabel.text = @"I suppose this is a reasonable snooze interval";
    } else if (val >= 21 && val <= 58) {
        self.seriouslyLabel.text = @"Seriously, who snoozes for more than 20 minutes?";
    } else if (val > 58) {
        self.seriouslyLabel.text = @"If you think you will need to snooze this long just call in sick";
    }
}

-(void)saveDefault:(NSString *)alarm
{
    NSData *alarmData = [NSKeyedArchiver archivedDataWithRootObject:alarm];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setValue:alarmData forKey:@"alarm"];
    [prefs synchronize];
}


@end

