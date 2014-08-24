//
//  ViewController.m
//  AlarMock
//
//  Created by Ben Bueltmann on 8/22/14.
//  Copyright (c) 2014 AlarMock Industries. All rights reserved.
//

#import "AlarMockViewController.h"

@interface AlarMockViewController() <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addButton;


@end

#pragma mark View Life Cycle

@implementation AlarMockViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] scheduledLocalNotifications];
    NSArray *timeStrings = [[NSUserDefaults standardUserDefaults] objectForKey:@"timeStrings"];
    self.timeStrings = [[NSMutableArray alloc] initWithArray:timeStrings];
    
    [self.tableView reloadData];
}

#pragma mark Table View Data Source Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.timeStrings.count;
}

#pragma mark Table View Delegate Methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text = [self.timeStrings objectAtIndex:indexPath.row];
    
    UISwitch *switcheroo = [[UISwitch alloc] initWithFrame:CGRectZero];
    [switcheroo addTarget:self
                   action:@selector(changeSwitch:)
         forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:switcheroo];
        cell.accessoryView  = switcheroo;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //Need code to delete local notification and user default
    [self.timeStrings removeObjectAtIndex:indexPath.row];
    [self.tableView reloadData];
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark Other Methods

- (void)changeSwitch:(id)sender
{
    if([sender isOn]) {
        //send local notification
    } else{
        //don't send local notification
    }
}
- (IBAction)enterEditMode:(id)sender {
    
    if ([self.tableView isEditing]) {
        [self.tableView setEditing:NO animated:YES];
        [self.editButton setTitle:@"Edit"];
        self.addButton.enabled = YES;
    }
    else {
        [self.editButton setTitle:@"Done"];
        self.addButton.enabled = NO;
        
        [self.tableView setEditing:YES animated:YES];
    }
}

-(void)setValue:(NSMutableArray* )array
{
    self.timeStrings = [array mutableCopy];
}

-(IBAction)unwindToThisViewController:(UIStoryboardSegue *)unwindSegue
{
    
}

@end
