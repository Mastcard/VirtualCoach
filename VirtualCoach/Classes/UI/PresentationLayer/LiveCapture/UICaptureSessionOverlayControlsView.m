//
//  UICaptureSessionOverlayControlsView.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 20/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "UICaptureSessionOverlayControlsView.h"

@implementation UICaptureSessionOverlayControlsView

- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

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
    [self setHidden:YES];
    
    CGSize binarySliderSize = CGSizeMake(250, 30);
    
    [_binaryThresholdSlider setFrame:CGRectMake(10, self.frame.size.height - (binarySliderSize.height + 10), binarySliderSize.width, binarySliderSize.height)];
    
    [_binaryThresholdSlider setBackgroundColor:[UIColor clearColor]];
    _binaryThresholdSlider.minimumValue = 5.0;
    _binaryThresholdSlider.maximumValue = 100.0;
    _binaryThresholdSlider.continuous = YES;
    _binaryThresholdSlider.value = 20.0;
    
    CGSize binaryModeButtonSize = CGSizeMake(55, 55);
    
    _binaryModeButton = [[UIBaseButton alloc] initWithFrame:CGRectMake(10, _binaryThresholdSlider.frame.origin.y - 10 - binaryModeButtonSize.height, binaryModeButtonSize.width, binaryModeButtonSize.height)];
    [_binaryModeButton setImage:[UIImage imageNamed:@"binaryModeButton.png"] forState:UIControlStateNormal];
    [_binaryModeButton setImage:[UIImage imageNamed:@"rgbModeButton.png"] forState:UIControlStateSelected];
}

- (void)layout
{
    [super layout];
    
    [self prepareForUse];
    
    [self addSubview:_binaryThresholdSlider];
    [self addSubview:_binaryModeButton];
}

- (void)prepareForUse
{
    [self prepareView];
}

@end
