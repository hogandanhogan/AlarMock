//
//  TimePickerViewController.m
//  AlarMock
//
//  Created by Rick Wolchuk on 8/22/14.
//  Copyright (c) 2014 AlarMock Industries. All rights reserved.
//

#import "AddAlarmViewController.h"
#import "RepeatViewController.h"


@interface AddAlarmViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UILabel *snoozeTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *snoozeMockLabel;
@property float sliderVal;
@property NSMutableArray *passedSelectedDays;

@end

@implementation AddAlarmViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.localNotifications = [NSMutableArray new];
    
    self.datePicker.date = [NSDate date];

    self.tableView.scrollEnabled = NO;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.slider.hidden = YES;

    self.passedSelectedDays = [NSMutableArray new];
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        RepeatViewController *dvc = [self.storyboard instantiateViewControllerWithIdentifier:@"daysVC"];
        [self presentViewController:dvc animated:YES completion:nil];
        dvc.navigationController.navigationBarHidden = NO;
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
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    
    //localNotification.fireDate = self.datePicker.date;
    //notification fires in 4 seconds while testing
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:4];
    localNotification.alertBody = @"Wake up";
    localNotification.alertAction = @"Snooze";
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
    [self saveDefault:localNotification];
    
    [self.navigationController popToRootViewControllerAnimated:YES];


}

- (IBAction)onMoveSlider:(id)sender
{
    UISlider *slider = (UISlider *)sender;
    float val = 1 + slider.value * 58.0f;
    self.sliderVal = val;
    
    if (val == 1) {
        self.snoozeTimeLabel.text =[NSString stringWithFormat:@"Snooze for %ld minute", (long)val];
    } else {
        self.snoozeTimeLabel.text = [NSString stringWithFormat:@"Snooze for %ld minutes", (long)val];
    }
    
    if (val >=1 && val < 21) {
        self.snoozeMockLabel.text = @"We suppose this is a reasonable snooze interval";
    } else if (val >= 21 && val <= 58) {
        self.snoozeMockLabel.text = @"Seriously, who snoozes for more than 20 minutes?";
    } else if (val == 59) {
        self.snoozeMockLabel.text = @"If you think you will need to snooze this long just call in sick";
    }
}

-(void)saveDefault:(UILocalNotification *)localNotification
{
    NSData *localNotificationData = [NSKeyedArchiver archivedDataWithRootObject:localNotification];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setValue:localNotificationData forKey:@"localNotificationData"];
    
    NSMutableArray *localNotificationsDatas = [[NSMutableArray alloc] initWithArray:[prefs objectForKey:@"localNotificationsDatas"]];
    [localNotificationsDatas addObject:localNotificationData];
    [prefs setObject:localNotificationsDatas forKey:@"localNotificationsDatas"];
    self.localNotifications = localNotificationsDatas;
    [prefs synchronize];
}
-(IBAction)unwindToAddAlarmViewController:(UIStoryboardSegue *)unwindSegue
{
    RepeatViewController *repeatVC = unwindSegue.sourceViewController;
    self.passedSelectedDays = repeatVC.selectedDays;
}





@end

