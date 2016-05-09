//
//  UICaptureSessionView.h
//  APICaptureForiOS
//
//  Created by Romain Dubreucq on 09/07/2015.
//  Copyright (c) 2015 Romain Dubreucq. All rights reserved.
//

#import "CaptureSession.h"
#import "UIRecordingButton.h"
#import "UIBaseView.h"
#import "UIRecordingDurationLabelView.h"
#import "UIRecordingIconView.h"
#import "UICaptureSessionOverlayView.h"

#import "UICaptureSessionControlsView.h"

@interface UICaptureSessionView : UIBaseView

@property (nonatomic, strong) CaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;

@property (nonatomic, strong) UICaptureSessionControlsView *controlsView;
@property (nonatomic, strong) UICaptureSessionOverlayView *overlayView;

- (instancetype)initWithFrame:(CGRect)frameRect captureSession:(CaptureSession *)captureSession;

@end
