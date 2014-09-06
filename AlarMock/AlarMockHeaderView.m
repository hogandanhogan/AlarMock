//
//  AlarMockHeaderView.m
//  AlarMock
//
//  Created by Patrick Hogan on 9/6/14.
//  Copyright (c) 2014 AlarMock Industries. All rights reserved.
//

#import "AlarMockHeaderView.h"

#import "UIScreen+AMScale.h"
#import "UIColor+AMTheme.h"

@interface AlarMockHeaderView ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *separatorHeightConstraint;

@end

@implementation AlarMockHeaderView

#pragma mark - View setup

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.blurEnabled = YES;
    self.blurRadius = 10.0f;
    self.dynamic = YES;
    self.tintColor = [UIColor colorWithWhite:0.2f alpha:1.0f];
    
    self.separatorHeightConstraint.constant = [[UIScreen mainScreen] am_scaledDimensionWithPixelSize:1.0f];
}

@end
