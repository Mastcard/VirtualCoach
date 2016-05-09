//
//  UICaptureSessionOverlayView.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 06/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "UICaptureSessionOverlayView.h"

@interface UICaptureSessionOverlayView ()

@end

@implementation UICaptureSessionOverlayView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        _regionBoundShapeView = [[CAShapeLayer alloc] init];
        _controlsView = [[UICaptureSessionOverlayControlsView alloc] init];
        _gestureView = [[UIBaseView alloc] init];
        _debugImageView = [[UIImageView alloc] init];
        _adjustmentActivityIndicatorView = [[UIActivityIndicatorTitledView alloc] init];
    }
    
    return self;
}

- (void)prepareView
{
    UIBezierPath* path = [[UIBezierPath alloc]init];
    [path moveToPoint:CGPointMake(0, 0)];
    [path closePath];
    
    _regionBoundsColor = [UIColor redColor];
    
    [_regionBoundShapeView setFillColor:[UIColor clearColor].CGColor];
    [_regionBoundShapeView setStrokeColor:_regionBoundsColor.CGColor];
    [_regionBoundShapeView setLineWidth:3.0];
    [_regionBoundShapeView setPath:path.CGPath];
    
    [_controlsView setFrame:CGRectMake(0, self.frame.size.height - 105, 270, 105)];
    
    [_gestureView setFrame:self.frame];
    [_debugImageView setFrame:self.bounds];
    
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
    [self addSubview:_debugImageView];
    [self addSubview:_controlsView];
}

- (void)prepareForUse
{
    [self prepareView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateRegionBounds:)
                                                 name:@"tracking.bounds.changed"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateDebugImage:)
                                                 name:@"debug.image.changed"
                                               object:nil];
}

- (void)updateDebugImage:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    
    CGImageRef imageRef = (__bridge CGImageRef)[userInfo objectForKey:@"debugImage"];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
        
        UIImage *uiimg = [[UIImage alloc] initWithCGImage:imageRef scale:1.0
                                              orientation: UIImageOrientationUp];//UIImageOrientationRight in case
        
        [_debugImageView setImage:uiimg];
        
    });
    
    CGImageRelease(imageRef);
}

- (void)updateRegionBounds:(NSNotification *)notification
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSDictionary *userInfo = notification.userInfo;
        
        int starti = 0;
        int startj = 0;
        int endi = 0;
        int endj = 0;
        uint16_t width = 0, height = 0;
        uint8_t colorRedComponent = 0, colorGreenComponent = 0, colorBlueComponent = 0;
        
        if (userInfo != nil)
        {
            starti = ((NSNumber *)[userInfo objectForKey:@"startPoint.i"]).intValue;
            startj = ((NSNumber *)[userInfo objectForKey:@"startPoint.j"]).intValue;
            endi = ((NSNumber *)[userInfo objectForKey:@"endPoint.i"]).intValue;
            endj = ((NSNumber *)[userInfo objectForKey:@"endPoint.j"]).intValue;
            width = ((NSNumber *)[userInfo objectForKey:@"image.width"]).unsignedIntValue;
            height = ((NSNumber *)[userInfo objectForKey:@"image.height"]).unsignedIntValue;
            colorRedComponent = ((NSNumber *)[userInfo objectForKey:@"color.red"]).unsignedIntValue;
            colorGreenComponent = ((NSNumber *)[userInfo objectForKey:@"color.green"]).unsignedIntValue;
            colorBlueComponent = ((NSNumber *)[userInfo objectForKey:@"color.blue"]).unsignedIntValue;
        }
        
//        if (colorRedComponent > 0 || colorGreenComponent > 0 || colorBlueComponent > 0)
//            [_regionBoundShapeView setStrokeColor:[UIColor colorWithRed:(colorRedComponent / 255.f) green:(colorGreenComponent / 255.f) blue:(colorBlueComponent / 255.f) alpha:1.0].CGColor];
        
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width, screenHeight = [UIScreen mainScreen].bounds.size.height;
        
        starti = (int)(starti * (screenHeight / height));
        startj = (int)(startj * (screenWidth / width));
        endi = (int)(endi * (screenHeight / height));
        endj = (int)(endj * (screenWidth / width));
        
        //NSLog(@"bounds ((%d, %d) (%d, %d))", startj, starti, endj, endi);
        
        UIBezierPath *bounds = [[UIBezierPath alloc] init];
        
        [bounds moveToPoint:CGPointMake(startj, starti)];
        [bounds addLineToPoint:CGPointMake(endj, starti)];
        [bounds addLineToPoint:CGPointMake(endj, endi)];
        [bounds addLineToPoint:CGPointMake(startj, endi)];
        [bounds closePath];
        
        [_regionBoundShapeView setPath:bounds.CGPath];
        [_regionBoundShapeView didChangeValueForKey:@"path"];
    });
}

@end
