//
//  AlarMockView.m
//  AlarMock
//
//  Created by Patrick Hogan on 9/6/14.
//  Copyright (c) 2014 AlarMock Industries. All rights reserved.
//

#import <FXBlurView.h>
#import <Masonry.h>

#import "AlarMockView.h"

#import "AMRadialGradientLayer.h"
#import "UIColor+AMTheme.h"
#import "UIScreen+AMScale.h"

@interface AlarMockView ()

@property (nonatomic, getter = hasLayedOutSubviews) BOOL layedOutSubviews;
@property (nonatomic) AMRadialGradientLayer *gradientLayer;

@end

@implementation AlarMockView

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
    
    [self setupTableView];
}

- (void)setupTableView
{
    self.tableView.allowsSelection = NO;
    self.tableView.allowsSelectionDuringEditing = YES;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.tableHeaderView = nil;
    self.tableView.backgroundColor = [UIColor clearColor];
}

#pragma mark - Layout

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.gradientLayer.frame = (CGRect) { CGPointZero, self.frame.size };
    self.gradientLayer.gradientOrigin = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame));
    self.gradientLayer.gradientRadius = CGRectGetMaxY(self.frame) * 0.9f;
    self.tableView.contentInset = UIEdgeInsetsMake(self.headerView.frame.size.height, 0.0f, 0.0f, 0.0f);
    
    if (!self.hasLayedOutSubviews) {
        [self.tableView scrollRectToVisible:CGRectMake(0, 0, self.tableView.frame.size.width, 1) animated:NO];
    }
    
    self.layedOutSubviews = YES;
}

#pragma mark - Action handlers

- (IBAction)leftBarButtonClicked:(id)sender
{
    [self.delegate alarMockView:self clickedLeftBarButtonItem:sender];
}

- (IBAction)rightBarButtonClicked:(id)sender
{
    [self.delegate alarMockView:self clickedRightBarButtonItem:sender];
}

#pragma mark - Accessors

- (void)setLeftBarButtonEnabled:(BOOL)enabled
{
    self.headerView.leftBarButtonItem.enabled = enabled;
}

- (void)setLeftBarButtonTitle:(NSString *)title
{
    self.headerView.leftBarButtonItem.title = title;
}

@end
