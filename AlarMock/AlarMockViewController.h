//
//  ViewController.h
//  AlarMock
//
//  Created by Ben Bueltmann on 8/22/14.
//  Copyright (c) 2014 AlarMock Industries. All rights reserved.
//

#import "AMViewController.h"

@class AlarmEngine;

@interface AlarMockViewController : AMViewController

@property (nonatomic) AlarmEngine *alarmEngine;
@property (nonatomic) NSString *textLabelText;


@end
