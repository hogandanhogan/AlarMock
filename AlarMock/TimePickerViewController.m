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

@end

@implementation TimePickerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.datePicker.date = [NSDate date];
    
    self.settingsTableView.scrollEnabled = NO;
    self.settingsTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
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
    UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectZero];
    if ([cell.textLabel.text isEqualToString:@"Snooze"]) {
        cell.accessoryView  = switchView;
    }
    
    return cell;
}

@end
