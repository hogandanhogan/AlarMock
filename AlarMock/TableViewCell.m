//
//  TableViewCell.m
//  AlarMock
//
//  Created by Patrick Hogan on 8/25/14.
//  Copyright (c) 2014 AlarMock Industries. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.switcheroo = [[UISwitch alloc] initWithFrame:CGRectZero];
        [self.switcheroo addTarget:self
                            action:@selector(switchDidChangeValue:)
                  forControlEvents:UIControlEventValueChanged];
    }
    return self;
}

-(void)switchDidChangeValue:(UISwitch *)sender
{
    [self.delegate switchDidChangeValue:sender.on];
}


@end
