//
//  UICaptureSessionOverlayViewController.h
//  VirtualCoach
//
//  Created by Romain Dubreucq on 12/05/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "UIBaseViewController.h"

#import "UICaptureSessionOverlayView.h"

#import "TrackingDrawingDelegate.h"

@interface UICaptureSessionOverlayViewController : UIBaseViewController <TrackingDrawingDelegate>

@property (nonatomic, strong) UICaptureSessionOverlayView *overlayView;

@end
