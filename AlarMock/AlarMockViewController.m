//
//  ViewController.m
//  AlarMock
//
//  Created by Ben Bueltmann on 8/22/14.
//  Copyright (c) 2014 AlarMock Industries. All rights reserved.
//

#import "AlarMockViewController.h"
#import "TableViewCell.h"
#import "SnoozeJokes.h"
#import "Jokes.h"
#import "AddAlarmViewController.h"

@interface AlarMockViewController() <UITableViewDelegate, UITableViewDataSource, TableViewCellDelegate, JokesManager, UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addButton;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property Jokes *jokes;
@property NSMutableArray *snoozeJokes;

@end

#pragma mark View Life Cycle

@implementation AlarMockViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.allowsSelection = NO;
    self.tableView.allowsSelectionDuringEditing = YES;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    self.jokes = [[Jokes alloc] init];
    self.jokes.delegate =self;
    [self.jokes querySnoozeJokes];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //create custom class for the collection of local notification data
    self.localNotifications = [[[NSUserDefaults standardUserDefaults] objectForKey:@"localNotificationsData"] mutableCopy];
    [self.tableView reloadData];
}

#pragma mark Table View Data Source Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.localNotifications.count;
}

#pragma mark Table View Delegate Methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[[UIApplication sharedApplication] scheduledLocalNotifications];
    
    NSData *data = [self.localNotifications objectAtIndex:indexPath.row];
    UILocalNotification *localNotification = [NSKeyedUnarchiver unarchiveObjectWithData:data];

    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    [cell setSwitchState:YES];
    //subclass nsobject and compose of 2 properties localnotification and isOn
    cell.delegate = self;
        
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.timeStyle = NSDateFormatterShortStyle;
    [dateFormatter setDateFormat:@"h:mm a"];
    NSString *timeString = [dateFormatter stringFromDate:localNotification.fireDate];
    cell.textLabel.text = timeString;

    return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"localNotificationsData"];
    [self.localNotifications removeObjectAtIndex:indexPath.row];

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

#pragma mark Alert View Delegate Methods

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        UILocalNotification * snoozeNotification = [UILocalNotification new];
        snoozeNotification.alertBody = [NSString stringWithFormat:@"%@", [self.snoozeJokes objectAtIndex:arc4random_uniform((uint32_t)self.snoozeJokes.count)]];
        //snoozeNotification.fireDate = [NSDate dateWithTimeInterval:60 * i * self.sliderVal sinceDate:self.datePicker.date];

        snoozeNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:10];
        snoozeNotification.timeZone = [NSTimeZone defaultTimeZone];

        [[UIApplication sharedApplication] scheduleLocalNotification:snoozeNotification];
        [self saveSnoozeDefault:snoozeNotification];
    }
}
#pragma mark - Table View Cell Delegate Method

-(void)tableViewCell:(TableViewCell *)tableViewCell switchDidChangeValue:(UISwitch *)switcheroo
{
    //set switch on/off functionality
}


#pragma mark - Other Methods

-(void)saveSnoozeDefault:(UILocalNotification *)localNotification
{
    NSData *localNotificationData = [NSKeyedArchiver archivedDataWithRootObject:localNotification];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];

    id encodedNotes = [prefs objectForKey:@"snoozeNotificationsData"];

    NSMutableArray *datas = [[NSMutableArray alloc] initWithArray:encodedNotes];
    [datas addObject:localNotificationData];
    [prefs setObject:datas forKey:@"snoozeNotificationsData"];
    [prefs synchronize];
}

-(void)snoozeJokesReturned:(NSArray *)jokes
{
    self.snoozeJokes = [NSMutableArray array];

    for (SnoozeJokes *joke in jokes)
    {
        [self.snoozeJokes addObject:joke.joke];
    }
}

- (IBAction)enterEditMode:(id)sender
{
    
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

-(IBAction)unwindToAlarmMockViewController:(UIStoryboardSegue *)unwindSegue
{

}
- (IBAction)onSubmitJoke:(id)sender
{
    PFObject *joke = [PFObject objectWithClassName:@"UserJokes"];
    joke[@"joke"] = self.textField.text;
    [joke saveInBackground];
    self.textField.text = @"";
    self.textField.placeholder = self.textField.placeholder;
}

-(IBAction)unwindToAddAlarmViewController:(UIStoryboardSegue *)unwindSegue
{
    
}

-(void)saveDefault:(UILocalNotification *)localNotification
{
    NSData *localNotificationData = [NSKeyedArchiver archivedDataWithRootObject:localNotification];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray *localNotificationsData = [[NSMutableArray alloc] initWithArray:[prefs objectForKey:@"localNotificationsData"]];
    [localNotificationsData addObject:localNotificationData];
    [prefs setObject:localNotificationsData forKey:@"localNotificationsData"];
    self.localNotifications = localNotificationsData;
    [prefs synchronize];
}

@end
