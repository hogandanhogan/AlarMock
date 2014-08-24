//
//  DaysViewController.m
//  AlarMock
//
//  Created by Patrick Hogan on 8/23/14.
//  Copyright (c) 2014 AlarMock Industries. All rights reserved.
//

#import "DaysViewController.h"

@interface DaysViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation DaysViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.scrollEnabled = NO;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DaysCell"];
    NSArray *days = [[NSArray alloc] initWithObjects:@"Monday",
                     @"Tuesday",
                     @"Wednesday",
                     @"Thursday",
                     @"Friday",
                     @"Saturday",
                     @"Sunday", nil];
    cell.textLabel.text = [days objectAtIndex:indexPath.row];
    
    return cell;
}

@end
