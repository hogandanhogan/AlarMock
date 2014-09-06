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

@interface AlarMockViewController() <AlarMockViewDelegate, UITableViewDelegate, UITableViewDataSource, TableViewCellDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerViewTopToSuperviewConstraint;

@property (weak, nonatomic) IBOutlet UIView *scrolledHeaderContainerView;
@property (weak, nonatomic) IBOutlet AlarMockView *alarMockView;
@property (nonatomic) Alarm *currentAlarm;

@end

@implementation AlarMockViewController

#pragma mark - View lifecycle

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.alarMockView.tableView setEditing:NO animated:YES];
    
    [self.alarMockView setLeftBarButtonTitle:@"Edit"];
    [self.alarMockView setLeftBarButtonEnabled:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.alarMockView.tableView reloadData];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat scrollPercent = MAX(0.0f, MIN(1.0f, (scrollView.contentOffset.y + scrollView.contentInset.top)/scrollView.contentInset.top));
    self.scrolledHeaderContainerView.alpha = scrollPercent;
    self.alarMockView.unScrolledHeaderView.alpha = 1.0f - MIN(1.0f, 2.0f *scrollPercent);
    self.headerViewTopToSuperviewConstraint.constant = MIN(44.0f, MAX(0.0f, scrollView.contentInset.top + scrollView.contentOffset.y));
}

#pragma mark - UITableViewDelegate/Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.alarmEngine.alarms.count == 0) {
        [self.alarMockView setLeftBarButtonEnabled:NO];
        [self.alarMockView setLeftBarButtonTitle:@"Edit"];
    } else {
        [self.alarMockView setLeftBarButtonEnabled:YES];
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
    [self.alarMockView.tableView beginUpdates];
    [self.alarmEngine removeAlarm:self.alarmEngine.alarms[indexPath.row]];
    [self.alarMockView.tableView deleteRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.alarMockView.tableView endUpdates];
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
    if ([self.alarMockView.tableView isEditing]) {
        [self.alarMockView.tableView setEditing:NO animated:YES];
        
        [self.alarMockView setLeftBarButtonTitle:@"Edit"];
        [self.alarMockView setLeftBarButtonEnabled:YES];
    } else {
        [self.alarMockView setLeftBarButtonTitle:@"Done"];
        [self.alarMockView.tableView setEditing:YES animated:YES];
    }
}

- (void)alarMockView:(AlarMockView *)alarMockView clickedRightBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    [self performSegueWithIdentifier:@"addAlarm" sender:barButtonItem];
}

@end
