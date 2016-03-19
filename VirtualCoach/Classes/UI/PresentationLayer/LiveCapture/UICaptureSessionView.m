//
//  UICaptureSessionView.m
//  APICaptureForiOS
//
//  Created by Romain Dubreucq on 09/07/2015.
//  Copyright (c) 2015 Romain Dubreucq. All rights reserved.
//

#import "UICaptureSessionView.h"

@implementation UICaptureSessionView

- (instancetype)initWithFrame:(CGRect)frameRect captureSession:(CaptureSession *)captureSession
{
    self = [super initWithFrame:frameRect];
    
    if (self)
    {
        _captureSession = captureSession;
        
        _captureVideoPreviewLayer = [AVCaptureVideoPreviewLayer layerWithSession:_captureSession.captureSession];
        _captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResize;
        
        [_captureVideoPreviewLayer setFrame:self.bounds];
        
        _controlsView = [[UICaptureSessionControlsView alloc] initWithFrame:self.bounds];
        
        _overlayView = [[UICaptureSessionOverlayView alloc] initWithFrame:self.bounds];
    }
    
    return self;
}

- (void)layout
{
    [super layout];
    
    [[self layer] addSublayer:_captureVideoPreviewLayer];
    
    [_controlsView layout];
    
    [self addSubview:_overlayView];
    [self addSubview:_controlsView];
}

- (void)prepareForUse
{
    
}

- (void)prepareForReuse
{
    
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
}

@end
