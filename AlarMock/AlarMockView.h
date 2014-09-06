//
//  AlarMockView.h
//  AlarMock
//
//  Created by Patrick Hogan on 9/6/14.
//  Copyright (c) 2014 AlarMock Industries. All rights reserved.
//

#import "AlarMockHeaderView.h"

@protocol AlarMockViewDelegate;

@interface AlarMockView : UIView

@property (nonatomic) AlarMockHeaderView *unScrolledHeaderView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet id <AlarMockViewDelegate> delegate;

- (void)setLeftBarButtonEnabled:(BOOL)enabled;
- (void)setLeftBarButtonTitle:(NSString *)title;

@end

@protocol AlarMockViewDelegate

- (void)alarMockView:(AlarMockView *)alarMockView clickedLeftBarButtonItem:(UIBarButtonItem *)barButtonItem;
- (void)alarMockView:(AlarMockView *)alarMockView clickedRightBarButtonItem:(UIBarButtonItem *)barButtonItem;

@end
