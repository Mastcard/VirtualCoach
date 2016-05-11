//
//  UIRecordingButton.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 19/07/2015.
//  Copyright © 2015 Romain Dubreucq. All rights reserved.
//

#import "UIRecordingButton.h"

@interface UIRecordingButton ()

@property (nonatomic) BOOL recordingMode;

@end

@implementation UIRecordingButton

- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        _recordingMode = NO;
        _animationDuration = 0.5;
    }
    
    return self;
}

- (void)layout
{
    self.layer.borderWidth = 1.f;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    self.layer.cornerRadius = self.frame.size.width / 2;
    self.backgroundColor = [UIColor colorWithRed:(242 / 255.f) green:(54 / 255.f) blue:(58 / 255.f) alpha:1.f];
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    self.layer.cornerRadius = self.frame.size.width / 2;
}

- (void)transformShape
{
    CABasicAnimation *shapeTransformationAnimation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    shapeTransformationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    shapeTransformationAnimation.fromValue = (_recordingMode) ? [NSNumber numberWithFloat:self.layer.cornerRadius] : [NSNumber numberWithFloat:self.layer.cornerRadius];
    shapeTransformationAnimation.toValue = (_recordingMode) ? [NSNumber numberWithFloat:self.frame.size.width / 2] : [NSNumber numberWithFloat:self.layer.cornerRadius / 5];
    shapeTransformationAnimation.duration = _animationDuration;
    
    [self.layer addAnimation:shapeTransformationAnimation forKey:@"cornerRadius"];
    
    self.layer.cornerRadius = (_recordingMode) ? self.frame.size.width / 2 : self.layer.cornerRadius / 5;
    self.layer.borderColor = (_recordingMode) ? [UIColor whiteColor].CGColor : [UIColor darkGrayColor].CGColor;
    
    _recordingMode = !_recordingMode;
}

@end
