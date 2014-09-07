//
//  TimePickerViewController.m
//  AlarMock
//
//  Created by Rick Wolchuk on 8/22/14.
//  Copyright (c) 2014 AlarMock Industries. All rights reserved.
//

#import "AddAlarmViewController.h"
#import "RepeatViewController.h"
#import "AlarmJoke.h"
#import "AlarmEngine.h"
#import "SoundViewController.h"
#import "AddAlarmView.h"
#import "AddAlarmTableViewCell.h"

@interface AddAlarmViewController () <AddAlarmViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UILabel *snoozeTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *snoozeMockLabel;
@property float sliderVal;
@property (nonatomic) Alarm *alarm;

@end

@implementation AddAlarmViewController

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.datePicker.date = [NSDate date];

    self.tableView.scrollEnabled = NO;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.backgroundColor = [UIColor clearColor];

    self.slider.hidden = YES;
}

#pragma mark - UITableViewDelegate/DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        return NO;
    } else {
        return YES;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddAlarmTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingsCell"];
    NSArray *settings = @[@"Sound", @"Snooze"];
    cell.textLabel.text = [settings objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor clearColor];


//    UISwitch *switcheroo = [[UISwitch alloc] initWithFrame:CGRectZero];
//    [switcheroo addTarget:self
//                   action:@selector(changeSnoozeSwitch:)
//         forControlEvents:UIControlEventValueChanged];
//    
//    [self.view addSubview:switcheroo];
//    if ([cell.textLabel.text isEqualToString:@"Snooze"]) {
//        cell.accessoryView  = switcheroo;
//    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    if (indexPath.row == 0) {
//        RepeatViewController *dvc = [self.storyboard instantiateViewControllerWithIdentifier:@"daysVC"];
//        [self.navigationController pushViewController:dvc animated:YES];
//    }
    if (indexPath.row == 0) {
        SoundViewController *svc = [self.storyboard instantiateViewControllerWithIdentifier:@"soundVC"];
        [self.navigationController pushViewController:svc animated:YES];
    }
}

#pragma mark - Table view delegate methods


#pragma mark - AddAlarmViewDelegate

- (void)addAlarmView:(AddAlarmView *)alarMockView clickedLeftBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)addAlarmView:(AddAlarmView *)alarMockView clickedRightBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    self.alarm = [[Alarm alloc] initWithJokeCollection:self.alarmEngine.jokeCollection];
    //self.alarm.fireDate = [NSDate dateWithTimeIntervalSinceNow:10];
    //[self.alarm getDateOfSpecificDay:self.alarm.daysChecked.count];
    self.alarm.fireDate = self.datePicker.date;
    //notification fires in 4 seconds while testing
    self.alarm.snoozeInterval = self.sliderVal * 60;
    self.alarm.alarmSong = self.alarmSong;
    self.alarm.notificationSound = self.notificationSound;
    
    [self.alarmEngine addAlarm:self.alarm];
    
    //    for (NSString *dayChecked in self.daysChecked) {
    //        NSInteger dayCheckedIntVal = dayChecked.integerValue;
    //        [self.alarm getDateOfSpecificDay:dayCheckedIntVal];
    //    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Action handlers

- (void)changeSnoozeSwitch:(id)sender
{
    if([sender isOn]) {
        self.slider.hidden = NO;
        self.snoozeTimeLabel.hidden = NO;
        self.snoozeMockLabel.hidden = NO;
    } else {
        self.slider.hidden = YES;
        self.snoozeTimeLabel.hidden = YES;
        self.snoozeMockLabel.hidden = YES;
    }
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
        self.snoozeMockLabel.text = @"I suppose this is a reasonable snooze interval";
    } else if (val >= 21 && val <= 58) {
        self.snoozeMockLabel.text = @"Seriously, who snoozes for more than 20 minutes?";
    } else if (val == 59) {
        self.snoozeMockLabel.text = @"If you think you will need to snooze this long just call in sick";
    }
}

- (IBAction)unwindToAddAlarmViewController:(UIStoryboardSegue *)unwindSegue
{
    
}

@end

#import <objc/runtime.h>

@implementation UILabel (WhiteUIDatePickerLabels)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleInstanceSelector:@selector(setTextColor:)
                      withNewSelector:@selector(swizzledSetTextColor:)];
        [self swizzleInstanceSelector:@selector(willMoveToSuperview:)
                      withNewSelector:@selector(swizzledWillMoveToSuperview:)];
    });
}

-(void) swizzledSetTextColor:(UIColor *)textColor {
    if([self view:self hasSuperviewOfClass:[UIDatePicker class]] ||
       [self view:self hasSuperviewOfClass:NSClassFromString(@"UIDatePickerWeekMonthDayView")] ||
       [self view:self hasSuperviewOfClass:NSClassFromString(@"UIDatePickerContentView")]){
        [self swizzledSetTextColor:[UIColor whiteColor]];
    } else {
        [self swizzledSetTextColor:textColor];
    }
}

- (void) swizzledWillMoveToSuperview:(UIView *)newSuperview {
    [self swizzledSetTextColor:self.textColor];
    [self swizzledWillMoveToSuperview:newSuperview];
}

- (BOOL) view:(UIView *) view hasSuperviewOfClass:(Class) class {
    if(view.superview){
        if ([view.superview isKindOfClass:class]){
            return true;
        }
        return [self view:view.superview hasSuperviewOfClass:class];
    }
    return false;
}

+ (void) swizzleInstanceSelector:(SEL)originalSelector
                 withNewSelector:(SEL)newSelector
{
    Method originalMethod = class_getInstanceMethod(self, originalSelector);
    Method newMethod = class_getInstanceMethod(self, newSelector);

    BOOL methodAdded = class_addMethod([self class],
                                       originalSelector,
                                       method_getImplementation(newMethod),
                                       method_getTypeEncoding(newMethod));

    if (methodAdded) {
        class_replaceMethod([self class],
                            newSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, newMethod);
    }
}

@end

