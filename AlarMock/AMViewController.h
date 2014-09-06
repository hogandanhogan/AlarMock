//
//  AMViewController.h
//  AlarMock
//
//  Created by Patrick Hogan on 9/6/14.
//  Copyright (c) 2014 AlarMock Industries. All rights reserved.
//

typedef NS_ENUM(NSUInteger, AMViewControllerState) {
    AMViewControllerStateNotLoaded = 0,
    AMViewControllerStateLoaded,
    AMViewControllerStateAppearing,
    AMViewControllerStateAppeared,
    AMViewControllerStateDisappearing,
    AMViewControllerStateDisappeared
};

@interface AMViewController : UIViewController

@property (nonatomic, readonly) AMViewControllerState state;

@end
