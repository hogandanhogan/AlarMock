//
//  AlarmLogic.h
//  AlarMock
//
//  Created by Patrick Hogan on 8/27/14.
//  Copyright (c) 2014 AlarMock Industries. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ChimneyLabelDelegate
-(void)houseContainingNaughtyChildNamed:(NSString *)name;
-(void)houseContainingNiceChildNamed:(NSString *)name;
@end

@interface AlarmLogic : NSObject

@property id<ChimneyLabelDelegate> delegate;

@end
