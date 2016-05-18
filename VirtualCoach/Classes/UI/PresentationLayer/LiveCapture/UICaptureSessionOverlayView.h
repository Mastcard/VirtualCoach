//
//  UICaptureSessionOverlayView.h
//  VirtualCoach
//
//  Created by Romain Dubreucq on 06/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "UIBaseView.h"
#import "UIBaseButton.h"
#import "UICaptureSessionOverlayControlsView.h"

#import "UIActivityIndicatorTitledView.h"

@interface UICaptureSessionOverlayView : UIBaseView

@property (nonatomic, strong) UIBezierPath *trackedRegionBoundsPath;
@property (nonatomic, strong) CAShapeLayer *regionBoundsShapeView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIActivityIndicatorTitledView *adjustmentActivityIndicatorView;
@property (nonatomic, strong) UICaptureSessionOverlayControlsView *controlsView;
@property (nonatomic, strong) UIBaseView *gestureView;

@end
