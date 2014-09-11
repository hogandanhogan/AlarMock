//
//  MZFormSheetView.m
//  AlarMock
//
//  Created by Patrick Hogan on 9/10/14.
//  Copyright (c) 2014 AlarMock Industries. All rights reserved.
//

#import "MZFormSheetView.h"
#import <MZFormSheetController.h>

@implementation MZFormSheetView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
        [[MZFormSheetBackgroundWindow appearance] setBackgroundBlurEffect:YES];
        [[MZFormSheetBackgroundWindow appearance] setBlurRadius:5.0];
        [[MZFormSheetBackgroundWindow appearance] setBackgroundColor:[UIColor clearColor]];
        [[MZFormSheetController sharedBackgroundWindow] setBackgroundBlurEffect:YES];
        [[MZFormSheetController sharedBackgroundWindow] setBlurRadius:5.0];
        [[MZFormSheetController sharedBackgroundWindow] setBackgroundColor:[UIColor clearColor]];
}

@end
