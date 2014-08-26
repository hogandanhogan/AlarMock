//
//  TableViewCell.h
//  AlarMock
//
//  Created by Patrick Hogan on 8/25/14.
//  Copyright (c) 2014 AlarMock Industries. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TableViewCellDelegate
-(void)switchDidChangeValue:(BOOL)value;
@end


@interface TableViewCell : UITableViewCell
@property id<TableViewCellDelegate> delegate;
@property UISwitch *switcheroo;
@end
