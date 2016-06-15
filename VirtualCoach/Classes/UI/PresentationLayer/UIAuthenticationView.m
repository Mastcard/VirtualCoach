//
//  UIAuthenticationView.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 06/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "UIAuthenticationView.h"

@implementation UIAuthenticationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        _credentialsView = [[UIAuthenticationCredentialsView alloc] init];
        _mainTitle = [[UIBaseLabel alloc] init];
    }
    
    return self;
}

- (void)prepareView
{
    [_credentialsView setFrame:CGRectMake(0, 0, 295, 205)];
    
    [_mainTitle setFrame:CGRectMake(0, 75, 200, 100)];
    [_mainTitle setFont:[UIFont systemFontOfSize:50.f]];
    [_mainTitle setTextColor:[UIColor whiteColor]];
    [_mainTitle setText:@"VirtualCoach"];
    [_mainTitle resizeToFitText];
}

- (void)layout
{
    [super layout];
    
    [self prepareForUse];
    
    [_credentialsView layout];
    
    [self addSubview:_credentialsView alignment:UIViewCentered];
    [self addSubview:_mainTitle alignment:UIViewCenteredOnX];
}

- (void)prepareForUse
{
    [self prepareView];
}

@end
