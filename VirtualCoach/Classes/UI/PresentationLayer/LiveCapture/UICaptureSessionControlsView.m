//
//  UICaptureSessionControlsView.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 07/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "UICaptureSessionControlsView.h"

@implementation UICaptureSessionControlsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        _recordButton = [[UIRecordingButton alloc] init];
        _deviceButton = [[UIBaseButton alloc] init];
        _adjustmentButton = [[UIBaseButton alloc] init];
        _trackerButton = [[UIBaseButton alloc] init];
        _recordingDurationLabelView = [[UIRecordingDurationLabelView alloc] init];
        _recordingIconView = [[UIRecordingIconView alloc] init];
    }
    
    return self;
}

- (void)prepareView
{
    CGSize controlViewSize = CGSizeMake(100, [UIScreen mainScreen].bounds.size.height);
    CGPoint controlViewOrigin = CGPointMake([UIScreen mainScreen].bounds.size.width - controlViewSize.width, 0);
    
    [self setFrame:CGRectMake(controlViewOrigin.x, controlViewOrigin.y, controlViewSize.width, controlViewSize.height)];
    
    [self setBackgroundColor:[UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.5]];
    
    
    CGSize recordButtonSize = CGSizeMake(55, 55);
    
    _recordButton.layer.borderWidth = 1.f;
    _recordButton.layer.borderColor = [UIColor whiteColor].CGColor;
    _recordButton.layer.cornerRadius = recordButtonSize.width / 2;
    _recordButton.backgroundColor = [UIColor colorWithRed:(242 / 255.f) green:(54 / 255.f) blue:(58 / 255.f) alpha:1.f];
    
    [_recordButton setFrame:CGRectMake(0, 0, recordButtonSize.width, recordButtonSize.height)];
    
    CGSize deviceButtonSize = CGSizeMake(28, 21);
    CGPoint deviceButtonOrigin = CGPointMake(0, ([UIScreen mainScreen].bounds.size.height / 6) - (deviceButtonSize.height / 2));
    
    [_deviceButton setImage:[UIImage imageNamed:@"deviceButton.png"] forState:UIControlStateNormal];
    [_deviceButton setFrame:CGRectMake(0, deviceButtonOrigin.y, deviceButtonSize.width, deviceButtonSize.height)];
    
    
    CGSize adjustmentButtonSize = CGSizeMake(55, 55);
    CGPoint adjustmentButtonOrigin = CGPointMake(0, (([UIScreen mainScreen].bounds.size.height / 6) * 4) - (adjustmentButtonSize.height / 2));
    
    [_adjustmentButton setImage:[UIImage imageNamed:@"adjustmentButton.png"] forState:UIControlStateNormal];
    [_adjustmentButton setFrame:CGRectMake(0, adjustmentButtonOrigin.y, adjustmentButtonSize.width, adjustmentButtonSize.height)];
    
    
    CGSize trackerButtonSize = CGSizeMake(55, 55);
    CGPoint trackerButtonOrigin = CGPointMake(0, (([UIScreen mainScreen].bounds.size.height / 6) * 5) - (trackerButtonSize.height / 2));
    
    [_trackerButton setImage:[UIImage imageNamed:@"trackerButton.png"] forState:UIControlStateNormal];
    [_trackerButton setFrame:CGRectMake(0, trackerButtonOrigin.y, trackerButtonSize.width, trackerButtonSize.height)];
    
    CGSize recordingAnimationViewSize = CGSizeMake(10, 10);
    
    [_recordingIconView setFrame:CGRectMake(5, (([UIScreen mainScreen].bounds.size.height / 6) * 2) - (recordingAnimationViewSize.height / 2), recordingAnimationViewSize.width, recordingAnimationViewSize.height)];
    
    CGSize timeLabelSize = CGSizeMake(80, 30);
    
    [_recordingDurationLabelView setFrame:CGRectMake(_recordingIconView.frame.origin.x + recordingAnimationViewSize.width + 5, (([UIScreen mainScreen].bounds.size.height / 6) * 2) - (timeLabelSize.height / 2), timeLabelSize.width, timeLabelSize.height)];
}

- (void)layout
{
    [super layout];
    
    [self prepareForUse];
    
    [_recordButton layout];
    [_adjustmentButton layout];
    [_trackerButton layout];
    [_recordingDurationLabelView layout];
    [_recordingIconView layout];
    
    [self addSubview:_recordButton alignment:UIViewCentered];
    [self addSubview:_adjustmentButton alignment:UIViewCenteredOnX];
    [self addSubview:_trackerButton alignment:UIViewCenteredOnX];
    [self addSubview:_deviceButton alignment:UIViewCenteredOnX];
    
    
    [self addSubview:_recordingDurationLabelView];
    [self addSubview:_recordingIconView];
}

- (void)prepareForUse
{
    [self prepareView];
}

- (void)prepareForReuse
{
    
}

@end
