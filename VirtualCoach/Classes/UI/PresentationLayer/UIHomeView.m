//
//  UIHomeView.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 06/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "UIHomeView.h"

@implementation UIHomeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        _captureButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_captureButton setFrame:CGRectMake(100, 100, 100, 30)];
        
        _processButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_processButton setFrame:CGRectMake(250, 100, 100, 30)];
        
        [_captureButton setTitle:@"Capture" forState:UIControlStateNormal];
        [_processButton setTitle:@"Process" forState:UIControlStateNormal];
        
        [self addSubview:_captureButton];
        [self addSubview:_processButton];
    }
    
    return self;
}

@end
