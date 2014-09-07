//
//  AddAlarmView.m
//  AlarMock
//
//  Created by Patrick Hogan on 9/6/14.
//  Copyright (c) 2014 AlarMock Industries. All rights reserved.
//

#import "AddAlarmView.h"

#import "AlarMockHeaderView.h"
#import "AMRadialGradientLayer.h"
#import "UIColor+AMTheme.h"

#import <Masonry.h>

@interface AddAlarmView ()

@property (weak, nonatomic) IBOutlet AlarMockHeaderView *headerView;
@property (nonatomic) AMRadialGradientLayer *gradientLayer;

@end

@implementation AddAlarmView

#pragma mark - View setup

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.gradientLayer = ({
        AMRadialGradientLayer *gradientLayer = [AMRadialGradientLayer layer];
        
        gradientLayer.colors = [UIColor am_backgroundGradientColors];
        
        gradientLayer.locations = @[@0.0f, @1.0f];
        
        [gradientLayer setStartPoint:CGPointMake(0.0f, 0.0f)];
        [gradientLayer setEndPoint:CGPointMake(0.0f, 1.0f)];
        
        gradientLayer;
    });
    [self.layer insertSublayer:self.gradientLayer atIndex:0];
}

#pragma mark - Layout

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.gradientLayer.frame = (CGRect) { CGPointZero, self.frame.size };
    self.gradientLayer.gradientOrigin = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame));
    self.gradientLayer.gradientRadius = CGRectGetMaxY(self.frame) * 0.9f;
}

#pragma mark - Action handlers

- (IBAction)leftBarButtonClicked:(id)sender
{
    [self.delegate addAlarmView:self clickedLeftBarButtonItem:sender];
}

- (IBAction)rightBarButtonClicked:(id)sender
{
    [self.delegate addAlarmView:self clickedRightBarButtonItem:sender];
}

@end
