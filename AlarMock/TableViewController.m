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
@property NSArray *alarms;
@end

@implementation TableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (IBAction)unwindToThisViewController:(UIStoryboardSegue *)unwindSegue
{
    
}



@end
