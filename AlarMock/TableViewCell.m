//
//  TableViewCell.m
//  AlarMock
//
//  Created by Patrick Hogan on 8/25/14.
//  Copyright (c) 2014 AlarMock Industries. All rights reserved.
//

#import "TableViewCell.h"

@interface TableViewCell ()

@property (nonatomic, weak) IBOutlet UISwitch *switcheroo;

@end

@implementation TableViewCell

-(IBAction)switchDidChangeValue:(UISwitch *)sender
{
    [self.delegate tableViewCell:self switchDidChangeValue:sender];
}

-(void)setSwitchState:(BOOL)on
{
    self.switcheroo.on = on;
}

@end
