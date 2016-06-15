//
//  UILaunchView.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 06/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "UILaunchView.h"

@implementation UILaunchView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, 200, 50)];
        [_titleLabel setText:@"VirtualCoach"];
        [_titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:30.f]];
        
        [self addSubview:_titleLabel alignment:UIViewCenteredOnX];
    }
    
    return self;
}

@end
