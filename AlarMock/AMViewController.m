//
//  AMViewController.m
//  AlarMock
//
//  Created by Patrick Hogan on 9/6/14.
//  Copyright (c) 2014 AlarMock Industries. All rights reserved.
//

#import "AMViewController.h"

@interface AMViewController ()

@property (nonatomic) AMViewControllerState state;

@end

@implementation AMViewController

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.state = AMViewControllerStateLoaded;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.state = AMViewControllerStateAppearing;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.state = AMViewControllerStateAppeared;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.state = AMViewControllerStateDisappearing;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.state = AMViewControllerStateDisappeared;
}

@end
