//
//  DaysViewController.m
//  AlarMock
//
//  Created by Patrick Hogan on 8/23/14.
//  Copyright (c) 2014 AlarMock Industries. All rights reserved.
//

#import "RepeatViewController.h"

@interface RepeatViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property NSArray *days;
@property NSMutableArray *selectedDays;

@end

@implementation RepeatViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.scrollEnabled = NO;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    self.days = [NSArray new];
    self.selectedDays = [NSMutableArray new];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.tableView cellForRowAtIndexPath:indexPath].accessoryType == UITableViewCellAccessoryNone) {
        [self.tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;

        //add the day from the selected cell to selectedDays array
        [self.selectedDays addObject:[self.days objectAtIndex:indexPath.row]];


    } else {
        [self.tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DaysCell"];
    self.days = [[NSArray alloc] initWithObjects:@"Every Monday",
                     @"Every Tuesday",
                     @"Every Wednesday",
                     @"Every Thursday",
                     @"Every Friday",
                     @"Every Saturday",
                     @"Every Sunday", nil];
    cell.textLabel.text = [self.days objectAtIndex:indexPath.row];
    return cell;
}

-(void)scheduleRepeatedDay
{
    self.selectedDays = 


}



-(IBAction)unwindToAddAlarmViewController:(UIStoryboardSegue *)unwindSegue
{
    
}
@end
