//
//  TimePickerViewController.m
//  AlarMock
//
//  Created by Rick Wolchuk on 8/22/14.
//  Copyright (c) 2014 AlarMock Industries. All rights reserved.
//

#import "TimePickerViewController.h"
#import "DaysViewController.h"


@interface TimePickerViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UILabel *snoozeTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *snoozeMockLabel;

@end

@implementation TimePickerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.timeStrings = [NSMutableArray new];
    
    self.datePicker.date = [NSDate date];

    self.tableView.scrollEnabled = NO;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        DaysViewController *dvc = [self.storyboard instantiateViewControllerWithIdentifier:@"daysVC"];
        [self presentViewController:dvc animated:YES completion:nil];
    }
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
    [self saveDefault:timeString];
    
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    
    //localNotification.fireDate = self.datePicker.date;
    //notification fires in 4 seconds while testing
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:4];
    localNotification.alertBody = @"Wake up fucko";
    localNotification.alertAction = @"Snooze";
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
    TableViewController *tvc = [[TableViewController alloc] initWithNibName:@"TableViewController" bundle: nil];
    [tvc setValue:self.timeStrings];
    [self.navigationController popToRootViewControllerAnimated:YES];
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
        self.snoozeMockLabel.text = @"We suppose this is a reasonable snooze interval";
    } else if (val >= 21 && val <= 58) {
        self.snoozeMockLabel.text = @"Seriously, who snoozes for more than 20 minutes?";
    } else if (val > 58) {
        self.snoozeMockLabel.text = @"If you think you will need to snooze this long just call in sick";
    }
}

-(void)saveDefault:(NSString *)timeString
{
    NSData *timeStringData = [NSKeyedArchiver archivedDataWithRootObject:timeString];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setValue:timeStringData forKey:@"timeString"];
    
    NSMutableArray *timeStrings = [[NSMutableArray alloc] initWithArray:[prefs objectForKey:@"timeStrings"]];
    [timeStrings addObject:timeString];
    [prefs setObject:timeStrings forKey:@"timeStrings"];
    self.timeStrings = timeStrings;
    [prefs synchronize];
}


@end

