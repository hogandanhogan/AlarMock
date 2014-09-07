//
//  AlarMockHeaderView.m
//  AlarMock
//
//  Created by Patrick Hogan on 9/6/14.
//  Copyright (c) 2014 AlarMock Industries. All rights reserved.
//

#import "AlarMockHeaderView.h"

#import "UIColor+AMTheme.h"
#import "UIScreen+AMScale.h"

#import <Masonry.h>

@interface AlarMockHeaderView ()

@end

@implementation AlarMockHeaderView

#pragma mark - View setup

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.dynamic = YES;
    self.blurEnabled = YES;
    self.blurRadius = 10.0f;
    self.tintColor = [UIColor am_black];
    
    UIView *separatorView = [[UIView alloc] init];
    separatorView.backgroundColor = [UIColor am_lightGray];
    [self addSubview:separatorView];
    
    [separatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.and.right.mas_equalTo(UIEdgeInsetsZero);
        make.height.mas_equalTo([[UIScreen mainScreen] am_scaledDimensionWithPixelSize:1.0f]);
    }];
}

@end
