//
//  TableViewCell.m
//  AlarMock
//
//  Created by Patrick Hogan on 8/25/14.
//  Copyright (c) 2014 AlarMock Industries. All rights reserved.
//

#import "AlarMockTableViewCell.h"

#import "AMColor.h"
#import "AMFont.h"

@interface AlarMockTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@end

@implementation AlarMockTableViewCell

@synthesize textLabel = _textLabel;

#pragma mark - View setup

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.textLabel.textColor = [AMColor whiteColor];
    self.backgroundColor = [UIColor clearColor];
    
    self.cellSwitch.onTintColor = [AMColor switchTintColor];
    self.cellSwitch.tintColor = [AMColor switchTintColor];
    self.cellSwitch.thumbTintColor = [AMColor switchThumbColor];
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    [self prepareForAnimation];
}

- (void)prepareForAnimation
{
    [self.layer removeAllAnimations];
    
    self.alpha = 0;
    
    self.layer.transform = CATransform3DMakeRotation(M_PI_2, 1.0f, 0.0f, 0.0f);
    self.layer.anchorPoint = CGPointMake(0, 0.5);
}

- (void)presentCellAnimated:(BOOL)animated
{
    void (^changes)() = ^{
        self.alpha = 1;
        self.layer.transform = CATransform3DIdentity;
    };
    
    if (animated) {
        [UIView animateWithDuration:0.6
                              delay:0.3
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:changes
                         completion:nil];
    } else {
        changes();
    }
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
        self.textLabel.font = [AMFont book16];
        self.textLabel.text = text;
    } else {
        self.textLabel.font = [AMFont book48];

        NSRange range = NSMakeRange([text stringByReplacingOccurrencesOfString:@" " withString:@""].length - 2, 2);
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[text stringByReplacingOccurrencesOfString:@" " withString:@""]];
        [attributedString addAttribute:NSFontAttributeName value:[AMFont book28] range:range];
        [[attributedString string] stringByReplacingOccurrencesOfString:@" " withString:@""];
        self.textLabel.attributedText = attributedString;
    }
}

- (NSString *)text
{
    return self.textLabel.text;
}

@end
