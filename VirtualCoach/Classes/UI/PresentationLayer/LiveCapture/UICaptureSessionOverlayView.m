//
//  UICaptureSessionOverlayView.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 06/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "UICaptureSessionOverlayView.h"

@implementation UICaptureSessionOverlayView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        _regionBoundsShapeView = [[CAShapeLayer alloc] init];
        _controlsView = [[UICaptureSessionOverlayControlsView alloc] init];
        _gestureView = [[UIBaseView alloc] init];
        _imageView = [[UIImageView alloc] init];
        _adjustmentActivityIndicatorView = [[UIActivityIndicatorTitledView alloc] init];
    }
    
    return self;
}

- (void)prepareView
{
    UIBezierPath* path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(0, 0)];
    [path closePath];
    
    [_regionBoundsShapeView setFillColor:[UIColor clearColor].CGColor];
    [_regionBoundsShapeView setStrokeColor:[UIColor blueColor].CGColor];
    [_regionBoundsShapeView setLineWidth:3.0];
    [_regionBoundsShapeView setPath:path.CGPath];
    
    [_controlsView setFrame:CGRectMake(0, self.frame.size.height - 105, 270, 105)];
    
    [_gestureView setFrame:self.frame];
    [_imageView setFrame:self.bounds];
    
    CGSize adjustmentActivityIndicatorViewSize = CGSizeMake(150, 140);
    [_adjustmentActivityIndicatorView setFrame:CGRectMake(0, 0, adjustmentActivityIndicatorViewSize.width, adjustmentActivityIndicatorViewSize.height)];
}

- (void)layout
{
    [super layout];
    
    [self prepareForUse];
    
    [_controlsView layout];
    [_adjustmentActivityIndicatorView layout];
    
    [self addSubview:_gestureView];
    //[self addSubview:_imageView];
    [self addSubview:_controlsView];
}

- (void)prepareForUse
{
    [self prepareView];
}

@end
