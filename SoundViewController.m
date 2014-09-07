//
//  SoundViewController.m
//  AlarMock
//
//  Created by Patrick Hogan on 9/3/14.
//  Copyright (c) 2014 AlarMock Industries. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>

#import "SoundViewController.h"

#import "AddAlarmViewController.h"
#import "AMRadialGradientLayer.h"
#import "UIColor+AMTheme.h"
#import "UIScreen+AMScale.h"
#import "UIColor+AMTheme.h"

@interface SoundViewController () <UITableViewDataSource, UITableViewDelegate, MPMediaPickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) MPMediaItem *alarmSong;
@property (nonatomic) NSString *notificationSound;
@property (nonatomic) AMRadialGradientLayer *gradientLayer;
@property (nonatomic) NSArray *sounds;

@end

@implementation SoundViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.sounds = @[@"Alert 1", @"Alert 2", @"Alert 3", @"Alert 4"];
    
    self.gradientLayer = ({
        AMRadialGradientLayer *gradientLayer = [AMRadialGradientLayer layer];
        
        gradientLayer.colors = [UIColor am_backgroundGradientColors];
        
        gradientLayer.locations = @[@0.0f, @1.0f];
        
        [gradientLayer setStartPoint:CGPointMake(0.0f, 0.0f)];
        [gradientLayer setEndPoint:CGPointMake(0.0f, 1.0f)];
        
        gradientLayer;
    });
    
    [self.view.layer insertSublayer:self.gradientLayer atIndex:0];

    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.backgroundColor = [UIColor clearColor];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 4;
    } else {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"Alarm Sounds";
    } else {
        return @"Music";
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-  (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 15)];
    UILabel *label = [[UILabel alloc] initWithFrame:view.frame];
    label.textColor = [UIColor am_whiteColor];

    [view addSubview:label];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        MPMediaPickerController *mediaPicker = [[MPMediaPickerController alloc] initWithMediaTypes:MPMediaTypeAnyAudio];
        mediaPicker.delegate = self;
        mediaPicker.allowsPickingMultipleItems = NO;
        mediaPicker.prompt = @"What would you like stuck in your head?";
        [self presentViewController:mediaPicker animated:YES completion:nil];
    } else {
        self.notificationSound = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
        
        [self.tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *sounds = @[@"Alert 1", @"Alert 2", @"Alert 3", @"Alert 4"];

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SoundCell"];
    cell.textLabel.textColor = [UIColor am_whiteColor];
    
    if (indexPath.section == 0) {
        cell.textLabel.text = [self.sounds objectAtIndex:indexPath.row];
    } else {
        cell.textLabel.text = @"Choose a song from your Library";
    }
    return cell;
}

#pragma mark - MPMediaPickerControllerDelegate

- (void)mediaPicker:(MPMediaPickerController *)mediaPicker didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection
{
    [self dismissViewControllerAnimated:YES completion:^{
        self.alarmSong = [mediaItemCollection.items objectAtIndex:0];
        [[[UIAlertView alloc] initWithTitle:@"If you choose a song as your alarm tone, the phone must be locked with Alarm Mock open in the background"
                                    message:nil
                                   delegate:self
                          cancelButtonTitle:nil
                          otherButtonTitles:@"Ok",nil] show];
    }];
}

-(void)mediaPickerDidCancel:(MPMediaPickerController *)mediaPicker
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[AddAlarmViewController class]]) {
        ((AddAlarmViewController *)[segue destinationViewController]).alarmSong = self.alarmSong;
        ((AddAlarmViewController *)[segue destinationViewController]).notificationSound = self.notificationSound;
    }
}

@end
