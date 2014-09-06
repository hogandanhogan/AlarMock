//
//  ViewController.m
//  AlarMock
//
//  Created by Ben Bueltmann on 8/22/14.
//  Copyright (c) 2014 AlarMock Industries. All rights reserved.
//

#import "AlarMockViewController.h"
#import "AlarMockTableViewCell.h"
#import "SnoozeJoke.h"
#import "AddAlarmViewController.h"
#import "Alarm.h"
#import "AlarmEngine.h"
#import "AlarMockView.h"

@interface AlarMockViewController() <UITableViewDelegate, UITableViewDataSource, TableViewCellDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerViewTopToSuperviewConstraint;

@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (nonatomic) AlarMockView *alarMockView;
@property (nonatomic) Alarm *currentAlarm;

@end

@implementation AlarMockViewController

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.alarMockView.tableView reloadData];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat guess = (scrollView.contentOffset.y + scrollView.contentInset.top)/scrollView.contentInset.top;
    self.headerView.alpha = MAX(0.0f, MIN(1.0f, guess));
    self.headerViewTopToSuperviewConstraint.constant = MIN(44.0f, MAX(0.0f, scrollView.contentInset.top + scrollView.contentOffset.y));
}

#pragma mark - UITableViewDelegate/Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.alarmEngine.alarms.count == 0) {
        self.alarMockView.editButton.enabled = NO;
    } else {
        self.alarMockView.editButton.enabled = YES;
    }
    return self.alarmEngine.alarms.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 88;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Alarm *alarm = self.alarmEngine.alarms[indexPath.row];
    AlarMockTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    [cell setSwitchState:YES];
    //subclass nsobject and compose of 2 properties localnotification and isOn
    cell.delegate = self;
        
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.timeStyle = NSDateFormatterShortStyle;
    [dateFormatter setDateFormat:@"h:mm a"];
    NSString *timeString = [dateFormatter stringFromDate:alarm.fireDate];
    cell.textLabel.text = timeString;
    self.currentAlarm = self.alarmEngine.alarms[indexPath.row];


    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.alarmEngine removeAlarm:self.alarmEngine.alarms[indexPath.row]];
    [self.alarMockView.tableView reloadData];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.alarMockView.tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - Table View Cell Delegate Method

- (void)alarMockTableViewCell:(AlarMockTableViewCell *)tableViewCell switchDidChangeValue:(UISwitch *)switcheroo
{
    NSIndexPath *indexPath = [self.alarMockView.tableView indexPathForCell:tableViewCell];
    Alarm *alarm = self.alarmEngine.alarms[indexPath.row];
    alarm.on = switcheroo.isEnabled;
    
//    if (alarm.on) {
//        [alarm alarmWillFire];
//    } else {
//        [alarm alarmWillNotFire];
//    }
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"editAlarm"]) {
        //TODO: edit current alarm
        ((AddAlarmViewController *)[segue destinationViewController]).title = @"Edit Alarm";
        ((AddAlarmViewController *)[segue destinationViewController]).currentAlarm = self.currentAlarm;
    } else if ([segue.identifier isEqualToString:@"addAlarm"]) {
        ((AddAlarmViewController *)[segue destinationViewController]).alarmEngine = self.alarmEngine;
    }
}

#pragma mark - Action Handlers

- (IBAction)leftNavigationButtonClicked:(id)sender
{
    if ([self.alarMockView.tableView isEditing]) {
        [self.alarMockView.tableView setEditing:NO animated:YES];
        
        [self.alarMockView.editButton setTitle:@"Edit"];
        self.alarMockView.addButton.enabled = YES;
    }
    else {
        [self.alarMockView.editButton setTitle:@"Done"];
        [self.alarMockView.tableView setEditing:YES animated:YES];
    }
}

- (IBAction)unwindToAlarmMockViewController:(UIStoryboardSegue *)unwindSegue
{

}

@end
