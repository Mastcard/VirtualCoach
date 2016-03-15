//
//  UICaptureSessionOverlayView.h
//  VirtualCoach
//
//  Created by Romain Dubreucq on 06/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "UIBaseView.h"

#import "UIActivityIndicatorTitledView.h"

@interface UICaptureSessionOverlayView : UIBaseView

@property (nonatomic, strong) UIBezierPath *trackedRegionBoundsPath;
@property (nonatomic, strong) CAShapeLayer *regionBoundShapeView;
@property (nonatomic, strong) UISlider *binaryThresholdSlider;
@property (nonatomic, strong) UIImageView *debugImageView;
@property (nonatomic, strong) UIActivityIndicatorTitledView *adjustmentActivityIndicatorView;

- (void)updateDebugImage:(NSNotification *)notification;
- (void)updateRegionBounds:(NSNotification *)notification;

@end
