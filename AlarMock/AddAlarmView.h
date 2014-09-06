//
//  AddAlarmView.h
//  AlarMock
//
//  Created by Patrick Hogan on 9/6/14.
//  Copyright (c) 2014 AlarMock Industries. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddAlarmViewDelegate;

@interface AddAlarmView : UIView

@property (weak, nonatomic) IBOutlet id <AddAlarmViewDelegate> delegate;

@end

@protocol AddAlarmViewDelegate

- (void)addAlarmView:(AddAlarmView *)alarMockView clickedLeftBarButtonItem:(UIBarButtonItem *)barButtonItem;
- (void)addAlarmView:(AddAlarmView *)alarMockView clickedRightBarButtonItem:(UIBarButtonItem *)barButtonItem;

@end

