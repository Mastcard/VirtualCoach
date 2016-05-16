//
//  UIRecordingIconView.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 25/07/2015.
//  Copyright © 2015 Romain Dubreucq. All rights reserved.
//

#import "UIRecordingIconView.h"

@interface UIRecordingIconView ()

@property (nonatomic, assign) BOOL opaque;

@end

@implementation UIRecordingIconView

- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        _opaque = NO;
    }
    
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self.layer setCornerRadius:self.frame.size.width / 2];
}

- (void)layout
{
    [self setBackgroundColor:[UIColor clearColor]];
}

- (void)startFlickering
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.4
                    target:self
                    selector:@selector(repeatableAction)
                    userInfo:nil
                    repeats:YES];
}

- (void)stopFlickering
{
    [_timer invalidate];
    _timer = nil;
    
    if(_opaque)
    {
        self.backgroundColor = [UIColor clearColor];
        _opaque = NO;
    }
}

- (void)repeatableAction
{
    UIColor *colorForAnimatedRecordingView = (!_opaque) ? [UIColor colorWithRed:(242 / 255.f) green:(54 / 255.f) blue:(58 / 255.f) alpha:1.f] : [UIColor clearColor];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.backgroundColor = colorForAnimatedRecordingView;
    }];
    
    _opaque = !_opaque;
}

@end
