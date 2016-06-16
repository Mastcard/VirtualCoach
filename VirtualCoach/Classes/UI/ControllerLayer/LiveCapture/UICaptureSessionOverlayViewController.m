//
//  UICaptureSessionOverlayViewController.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 12/05/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "UICaptureSessionOverlayViewController.h"

@implementation UICaptureSessionOverlayViewController

- (void)didSendImage:(CGImageRef)image
{
    @autoreleasepool {
        UIImage *uiimg = [[UIImage alloc] initWithCGImage:image scale:1.0
                                              orientation: UIImageOrientationUp];//UIImageOrientationRight in case
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            
            [_overlayView.imageView setImage:uiimg];
            CGImageRelease(image);
        });
    }
}

- (void)didSendRegionBounds:(rect_t)bounds forImageSize:(CGSize)size
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        uint32_t starti = bounds.start.y;
        uint32_t startj = bounds.start.x;
        uint32_t endi = bounds.end.y;
        uint32_t endj = bounds.end.x;
        
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width, screenHeight = [UIScreen mainScreen].bounds.size.height;
        
        starti = (uint32_t)(starti * (screenHeight / size.height));
        startj = (uint32_t)(startj * (screenWidth / size.width));
        endi = (uint32_t)(endi * (screenHeight / size.height));
        endj = (uint32_t)(endj * (screenWidth / size.width));
        
        //NSLog(@"bounds ((%d, %d) (%d, %d))", startj, starti, endj, endi);
        
        UIBezierPath *bounds = [[UIBezierPath alloc] init];
        
        [bounds moveToPoint:CGPointMake(startj, starti)];
        [bounds addLineToPoint:CGPointMake(endj, starti)];
        [bounds addLineToPoint:CGPointMake(endj, endi)];
        [bounds addLineToPoint:CGPointMake(startj, endi)];
        [bounds closePath];
        
        [_overlayView.regionBoundsShapeView setPath:bounds.CGPath];
        [_overlayView.regionBoundsShapeView didChangeValueForKey:@"path"];
    });
}

- (void)didDetectObjectMotion:(BOOL)moved
{
//    CGColorRef colorRef;
//    colorRef = moved ? [UIColor redColor].CGColor : [UIColor greenColor].CGColor;
//    [_overlayView.regionBoundsShapeView setStrokeColor:moved ? [UIColor redColor].CGColor : [UIColor greenColor].CGColor];
}

@end
