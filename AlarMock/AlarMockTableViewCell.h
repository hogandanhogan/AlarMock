//
//  TableViewCell.h
//  AlarMock
//
//  Created by Patrick Hogan on 8/25/14.
//  Copyright (c) 2014 AlarMock Industries. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AlarMockTableViewCell;

@protocol TableViewCellDelegate

- (void)alarMockTableViewCell:(AlarMockTableViewCell *)alarMockTableViewCell switchDidChangeValue:(UISwitch *)switcheroo;

@end


@interface AlarMockTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) id<TableViewCellDelegate> delegate;

- (void)setSwitchState:(BOOL)on;

@end
