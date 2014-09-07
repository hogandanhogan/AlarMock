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

@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@end

@implementation AlarMockTableViewCell

@synthesize textLabel = _textLabel;

#pragma mark - View setup

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.textLabel.textColor = [UIColor am_whiteColor];
    self.backgroundColor = [UIColor clearColor];
    
    self.cellSwitch.onTintColor = [UIColor am_switchTintColor];
    self.cellSwitch.tintColor = [UIColor am_switchTintColor];
    self.cellSwitch.thumbTintColor = [UIColor am_switchThumbColor];
}

#pragma mark - Accessors

- (void)setSwitchState:(BOOL)on
{
    self.cellSwitch.on = on;
}

- (void)setText:(NSString *)text
{
    [self setText:text timeFormatted:NO];
}

- (void)setText:(NSString *)text timeFormatted:(BOOL)timeFormatted
{
    if (!timeFormatted) {
        self.textLabel.font = [UIFont am_book16];

        self.textLabel.text = text;
    } else {
        self.textLabel.font = [UIFont am_book48];

        NSRange range = NSMakeRange(text.length - 2, 2);
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
        [attributedString addAttribute:NSFontAttributeName value:[UIFont am_book22] range:range];
        self.textLabel.attributedText = attributedString;
    }
}

- (NSString *)text
{
    return self.textLabel.text;
}

@end
