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

@property (strong, nonatomic) AlarMockHeaderView *scrolledHeaderView;
@property (weak, nonatomic) IBOutlet FXBlurView *scrolledHeaderContainerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrolledHeaderContainerViewSeparatorHeightConstraint;

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
    
    [self setupHeaderView];
    [self setupTableView];
}

- (void)setupHeaderView
{
    self.scrolledHeaderContainerView.blurEnabled = YES;
    self.scrolledHeaderContainerView.blurRadius = 10.0f;
    self.scrolledHeaderContainerView.dynamic = YES;
    self.scrolledHeaderContainerView.tintColor = [UIColor colorWithWhite:0.2f alpha:1.0f];
    
    self.scrolledHeaderContainerViewSeparatorHeightConstraint.constant = [[UIScreen mainScreen] am_scaledDimensionWithPixelSize:1.0f];

    self.scrolledHeaderView = [[[NSBundle mainBundle] loadNibNamed:[[AlarMockHeaderView class] description]
                                                              owner:self
                                                            options:nil] firstObject];
    [self.scrolledHeaderContainerView addSubview:self.scrolledHeaderView];
    
    [self.scrolledHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];

    self.unScrolledHeaderView = [[[NSBundle mainBundle] loadNibNamed:[[AlarMockHeaderView class] description]
                                                             owner:self
                                                           options:nil] firstObject];
    [self addSubview:self.unScrolledHeaderView];
    
    [self.unScrolledHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.and.right.mas_equalTo(UIEdgeInsetsMake(self.scrolledHeaderContainerView.frame.size.height, 0.0f, 0.0f, 0.0f));
        make.height.equalTo(self.scrolledHeaderView);
    }];

    self.scrolledHeaderView.leftBarButtonItem.enabled = NO;
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
    self.tableView.contentInset = UIEdgeInsetsMake(self.scrolledHeaderView.frame.size.height, 0.0f, 0.0f, 0.0f);
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
    self.unScrolledHeaderView.leftBarButtonItem.enabled = enabled;
    self.scrolledHeaderView.leftBarButtonItem.enabled = enabled;
}

- (void)setLeftBarButtonTitle:(NSString *)title
{
    self.unScrolledHeaderView.leftBarButtonItem.title = title;
    self.scrolledHeaderView.leftBarButtonItem.title = title;
}

@end
