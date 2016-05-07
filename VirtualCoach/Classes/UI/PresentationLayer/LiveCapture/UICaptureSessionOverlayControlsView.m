//
//  UICaptureSessionOverlayControlsView.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 20/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "UICaptureSessionOverlayControlsView.h"

@implementation UICaptureSessionOverlayControlsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        _binaryThresholdSlider = [[UISlider alloc] init];
        _binaryModeButton = [[UIBaseButton alloc] init];
    }
    
    return self;
}

- (void)prepareView
{
    [self setBackgroundColor:[UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.5]];
    
    CGSize binarySliderSize = CGSizeMake(250, 30);
    
    [_binaryThresholdSlider setFrame:CGRectMake(10, self.frame.size.height - 40, binarySliderSize.width, binarySliderSize.height)];
    
    [_binaryThresholdSlider setBackgroundColor:[UIColor clearColor]];
    _binaryThresholdSlider.minimumValue = 5.0;
    _binaryThresholdSlider.maximumValue = 150.0;
    _binaryThresholdSlider.continuous = YES;
    _binaryThresholdSlider.value = 20.0;
    _binaryThresholdSlider.hidden = YES;
}

- (void)layout
{
    [super layout];
    
    [self prepareForUse];
}

- (void)prepareForUse
{
    [self prepareView];
}

@end
