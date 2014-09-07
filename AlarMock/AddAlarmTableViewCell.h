//
//  AddAlarmTableViewCell.h
//  AlarMock
//
//  Created by Patrick Hogan on 9/7/14.
//  Copyright (c) 2014 AlarMock Industries. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddAlarmTableViewCell;

@protocol TableViewCellDelegate

- (void)addAlarmTableViewCell:(AddAlarmTableViewCell *)alarMockTableViewCell switchDidChangeValue:(UISwitch *)switcheroo;

@end


@interface AddAlarmTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) id<TableViewCellDelegate> delegate;

- (void)setSwitchState:(BOOL)on;
@end
