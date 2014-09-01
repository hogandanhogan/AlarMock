//
//  DaysViewController.m
//  AlarMock
//
//  Created by Patrick Hogan on 8/23/14.
//  Copyright (c) 2014 AlarMock Industries. All rights reserved.
//

#import "RepeatViewController.h"
#import "DaysTableViewCell.h"

@interface RepeatViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) DaysTableViewCell *daysTableViewCell;
@end

@implementation RepeatViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.daysTableViewCell = [DaysTableViewCell new];
    
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
    if ([self.tableView cellForRowAtIndexPath:indexPath].accessoryType == UITableViewCellAccessoryNone) {
        [self.tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
        [[self.tableView cellForRowAtIndexPath:indexPath] setSelected:YES];
        
    } else {
        [self.tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
        [[self.tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.daysTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"DaysCell"];
    NSArray *days = [[NSArray alloc] initWithObjects:@"Every Monday",
                     @"Every Tuesday",
                     @"Every Wednesday",
                     @"Every Thursday",
                     @"Every Friday",
                     @"Every Saturday",
                     @"Every Sunday", nil];
    self.daysTableViewCell.textLabel.text = [days objectAtIndex:indexPath.row];

    return self.daysTableViewCell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}

@end
