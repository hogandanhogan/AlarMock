
//
//  DaysViewController.m
//  AlarMock
//
//  Created by Patrick Hogan on 8/23/14.
//  Copyright (c) 2014 AlarMock Industries. All rights reserved.
//

#import "RepeatViewController.h"
#import "AddAlarmViewController.h"

@interface RepeatViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) NSArray *days;
@property (nonatomic) NSMutableArray *daysChecked;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation RepeatViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.days = @[@"Every Monday",
                  @"Every Tuesday",
                  @"Every Wednesday",
                  @"Every Thursday",
                  @"Every Friday",
                  @"Every Saturday",
                  @"Every Sunday"];
    
    self.daysChecked = [NSMutableArray new];
    
    self.tableView.scrollEnabled = NO;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *day = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    
    if ([self.tableView cellForRowAtIndexPath:indexPath].accessoryType == UITableViewCellAccessoryNone) {
        [self.tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
        [self.daysChecked addObject:day];
        
    } else {
        [self.tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
        [self.daysChecked removeObject:day];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DaysCell"];
    cell.textLabel.text = [self.days objectAtIndex:indexPath.row];
    
    return cell;
}

@end
