//
//  ViewController.m
//  AlarMock
//
//  Created by Ben Bueltmann on 8/22/14.
//  Copyright (c) 2014 AlarMock Industries. All rights reserved.
//

#import "AlarMockViewController.h"

#import "AddAlarmViewController.h"
#import "Alarm.h"
#import "AlarMockHeaderView.h"
#import "AlarmEngine.h"
#import "AlarMockTableViewCell.h"
#import "AlarMockView.h"
#import "SnoozeJoke.h"

@interface AlarMockViewController() <AlarMockViewDelegate, UITableViewDelegate, UITableViewDataSource, TableViewCellDelegate>

@property (nonatomic) Alarm *currentAlarm;

@property (nonatomic) AlarMockView *view;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet AlarMockHeaderView *headerView;

@end

@implementation AlarMockViewController

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.tableView setEditing:NO animated:YES];
    
    [self.view setLeftBarButtonTitle:@"Edit"];
    [self.view setLeftBarButtonEnabled:YES];
}

#pragma mark - UITableViewDelegate/Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.alarmEngine.alarms.count == 0) {
        [self.view setLeftBarButtonEnabled:NO];
        [self.view setLeftBarButtonTitle:@"Edit"];
    } else {
        [self.view setLeftBarButtonEnabled:YES];
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
    cell.switchState = alarm.on;
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
    [self.tableView beginUpdates];
    [self.alarmEngine removeAlarm:self.alarmEngine.alarms[indexPath.row]];
    [self.tableView deleteRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView endUpdates];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - Table View Cell Delegate Method

- (void)alarMockTableViewCell:(AlarMockTableViewCell *)tableViewCell switchDidChangeValue:(UISwitch *)switcheroo
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:tableViewCell];
    Alarm *alarm = self.alarmEngine.alarms[indexPath.row];
    alarm.on = switcheroo.isOn;
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"addAlarm"]) {
        ((AddAlarmViewController *)[segue destinationViewController]).alarmEngine = self.alarmEngine;
    }
}

#pragma mark - Action Handlers

- (void)alarMockView:(AlarMockView *)alarMockView clickedLeftBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    if ([self.tableView isEditing]) {
        [self.tableView setEditing:NO animated:YES];
        
        [self.view setLeftBarButtonTitle:@"Edit"];
        [self.view setLeftBarButtonEnabled:YES];
    } else {
        [self.view setLeftBarButtonTitle:@"Done"];
        [self.tableView setEditing:YES animated:YES];
    }
}

- (void)alarMockView:(AlarMockView *)alarMockView clickedRightBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    [self performSegueWithIdentifier:@"addAlarm" sender:barButtonItem];
}

@end
