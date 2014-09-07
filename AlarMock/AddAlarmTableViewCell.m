//
//  AddAlarmTableViewCell.m
//  AlarMock
//
//  Created by Patrick Hogan on 9/7/14.
//  Copyright (c) 2014 AlarMock Industries. All rights reserved.
//

#import "AddAlarmTableViewCell.h"

#import "UIColor+AMTheme.h"
#import "UIFont+AMTheme.h"

@interface AddAlarmTableViewCell ()

@property (nonatomic, weak) IBOutlet UISwitch *switcheroo;

@end

@implementation AddAlarmTableViewCell

@synthesize textLabel = _textLabel;

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (IBAction)switchDidChangeValue:(UISwitch *)sender
{
    [self.delegate addAlarmTableViewCell:self switchDidChangeValue:sender];
}

#pragma mark - Accessors

- (void)setSwitchState:(BOOL)on
{
    self.switcheroo.on = on;
}

@end
