//
//  ViewController.h
//  AlarMock
//
//  Created by Ben Bueltmann on 8/22/14.
//  Copyright (c) 2014 AlarMock Industries. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlarmEngine.h"

@interface AlarMockViewController : UIViewController

@property NSMutableArray *alarms;
@property AlarmEngine *alarmEngine;

@end
