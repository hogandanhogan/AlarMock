//
//  ViewController.m
//  AlarMock
//
//  Created by Ben Bueltmann on 8/22/14.
//  Copyright (c) 2014 AlarMock Industries. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController() <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    
    NSArray *timeStrings = [[NSUserDefaults standardUserDefaults] objectForKey:@"timeStrings"];
    self.timeStrings = [[NSMutableArray alloc] initWithArray:timeStrings];
}

-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] scheduledLocalNotifications];
    [self.tableView reloadData];
}

-(void)setValue:(NSMutableArray* )array
{
    self.timeStrings = [array mutableCopy];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text = [self.timeStrings objectAtIndex:indexPath.row];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.timeStrings.count;
}

- (IBAction)unwindToThisViewController:(UIStoryboardSegue *)unwindSegue
{
    
}

@end
