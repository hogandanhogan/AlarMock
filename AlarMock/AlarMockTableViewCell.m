//
//  TableViewCell.m
//  AlarMock
//
//  Created by Patrick Hogan on 8/25/14.
//  Copyright (c) 2014 AlarMock Industries. All rights reserved.
//

#import "AlarMockTableViewCell.h"

#import "UIColor+AMTheme.h"
#import "UIFont+AMTheme.h"

@interface AlarMockTableViewCell ()

@property (nonatomic, weak) IBOutlet UISwitch *switcheroo;

@end

@implementation AlarMockTableViewCell

@synthesize textLabel = _textLabel;

#pragma mark - View setup

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.textLabel.font = [UIFont bookWithSize:48];
    self.textLabel.textColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor clearColor];
    
    NSRange range = NSMakeRange(self.textLabel.text.length - 2, 2);
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.textLabel.text];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont book22] range:range];
    
    self.switcheroo.onTintColor = [UIColor am_switchTintColor];
    self.switcheroo.tintColor = [UIColor am_switchTintColor];
    self.switcheroo.thumbTintColor = [UIColor am_switchThumbColor];
}

#pragma mark - Action Handlers

- (IBAction)switchDidChangeValue:(UISwitch *)sender
{
    [self.delegate alarMockTableViewCell:self switchDidChangeValue:sender];
}

#pragma mark - Accessors

- (void)setSwitchState:(BOOL)on
{
    self.switcheroo.on = on;
}

@end
