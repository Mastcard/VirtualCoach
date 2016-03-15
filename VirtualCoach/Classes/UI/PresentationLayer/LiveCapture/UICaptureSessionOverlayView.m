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
        UIBezierPath* path = [[UIBezierPath alloc]init];
        [path moveToPoint:CGPointMake(0, 0)];
        [path closePath];
    
        _regionBoundShapeView = [[CAShapeLayer alloc] init];
        [_regionBoundShapeView setFillColor:[UIColor clearColor].CGColor];
        [_regionBoundShapeView setStrokeColor:[UIColor redColor].CGColor];
        [_regionBoundShapeView setLineWidth:3.0];
        [_regionBoundShapeView setPath:path.CGPath];
        
        
        CGSize binarySliderSize = CGSizeMake(250, 30);
        
        _binaryThresholdSlider = [[UISlider alloc] initWithFrame:CGRectMake(10, self.frame.size.height - 40, binarySliderSize.width, binarySliderSize.height)];
        [_binaryThresholdSlider setBackgroundColor:[UIColor clearColor]];
        _binaryThresholdSlider.minimumValue = 5.0;
        _binaryThresholdSlider.maximumValue = 150.0;
        _binaryThresholdSlider.continuous = YES;
        _binaryThresholdSlider.value = 50.0;
        _binaryThresholdSlider.hidden = YES;
        
        
        
        _debugImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        
        [self addSubview:_debugImageView];
        
        [[self layer] addSublayer:_regionBoundShapeView];
        
        [self addSubview:_binaryThresholdSlider];
        
        CGSize adjustmentActivityIndicatorViewSize = CGSizeMake(150, 140);
        [_adjustmentActivityIndicatorView setFrame:CGRectMake(0, 0, adjustmentActivityIndicatorViewSize.width, adjustmentActivityIndicatorViewSize.height)];
        
        
        _adjustmentActivityIndicatorView = [[UIActivityIndicatorTitledView alloc] initWithFrame:CGRectMake(0, 0, adjustmentActivityIndicatorViewSize.width, adjustmentActivityIndicatorViewSize.height)];
        
        [_adjustmentActivityIndicatorView layout];
        
        //[self addSubview:_adjustmentActivityIndicatorView alignment:UIViewCentered];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(updateRegionBounds:)
                                                     name:@"tracking.bounds.changed"
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(updateDebugImage:)
                                                     name:@"debug.image.changed"
                                                   object:nil];
    }
    
    return self;
}

- (void)updateDebugImage:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        CGImageRef imageRef = (__bridge CGImageRef)[userInfo objectForKey:@"debugImage"];
        
        UIImage *uiimg = [[UIImage alloc] initWithCGImage:imageRef scale:1.0
                                              orientation: UIImageOrientationUp];//UIImageOrientationRight in case
        
        [_debugImageView setImage:uiimg];
        
    });
}

- (void)updateRegionBounds:(NSNotification *)notification
{
    NSLog(@"(void)updateRegionBounds");
    NSDictionary *userInfo = notification.userInfo;
    
    int starti = 0;
    int startj = 0;
    int endi = 0;
    int endj = 0;
    uint16_t width = 0, height = 0;
    
    if (userInfo != nil)
    {
        starti = ((NSNumber *)[userInfo objectForKey:@"startPoint.i"]).intValue;
        startj = ((NSNumber *)[userInfo objectForKey:@"startPoint.j"]).intValue;
        endi = ((NSNumber *)[userInfo objectForKey:@"endPoint.i"]).intValue;
        endj = ((NSNumber *)[userInfo objectForKey:@"endPoint.j"]).intValue;
        width = ((NSNumber *)[userInfo objectForKey:@"image.width"]).unsignedIntValue;
        height = ((NSNumber *)[userInfo objectForKey:@"image.height"]).unsignedIntValue;
    }
    
    
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width, screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    starti = (int)(starti * (screenHeight / height));
    startj = (int)(startj * (screenWidth / width));
    endi = (int)(endi * (screenHeight / height));
    endj = (int)(endj * (screenWidth / width));
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
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
