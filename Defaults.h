//
//  Defaults.h
//  AlarMock
//
//  Created by Patrick Hogan on 8/23/14.
//  Copyright (c) 2014 AlarMock Industries. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Defaults : NSObject

-(NSURL *)documentsDirectory;
-(void)save;
-(void)load;


@end
