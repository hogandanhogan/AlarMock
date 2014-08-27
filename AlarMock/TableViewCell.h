//
//  TableViewCell.h
//  AlarMock
//
//  Created by Patrick Hogan on 8/25/14.
//  Copyright (c) 2014 AlarMock Industries. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TableViewCell;

@protocol TableViewCellDelegate

-(void)tableViewCell:(TableViewCell *)tableViewCell switchDidChangeValue:(UISwitch *)switcheroo;

@end


@interface TableViewCell : UITableViewCell

@property (nonatomic, weak) id<TableViewCellDelegate> delegate;

-(void)setSwitchState:(BOOL)on;

@end
