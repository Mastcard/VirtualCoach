//
//  UICaptureSessionViewController.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 12/07/2015.
//  Copyright (c) 2015 Romain Dubreucq. All rights reserved.
//

#import "UICaptureSessionViewController.h"
#import "CaptureDevicePropertiesRetriever.h"
#import "CaptureDeviceManager.h"
#import "CaptureDevicePropertiesUtilities.h"
#import "FramesCaptureSessionController.h"
#import "MovieCaptureSessionController.h"

@interface UICaptureSessionViewController ()

@property (nonatomic) BOOL recording;

@property (nonatomic) UITapGestureRecognizer *locateRegionTapGestureRecognizer;

- (void)hideOrShowControlsView;
- (void)referenceFrameProcessDidFinish:(NSNotification *)notification;
- (void)singleTapGestureToLocateRegion:(UITapGestureRecognizer *)recognizer;
- (void)binaryThresholdSliderAction:(UISlider *)sender;
- (void)binaryModeButtonAction;

@end

@implementation UICaptureSessionViewController

- (instancetype)initWithSessionController:(CaptureSessionController *)captureSessionController
{
    self = [super init];
    
    if (self)
    {
        _captureSessionController = captureSessionController;
        
        _captureSessionView = [[UICaptureSessionView alloc] initWithFrame:[UIScreen mainScreen].bounds captureSession:_captureSessionController.captureSession];
        
        [_captureSessionView.controlsView.deviceButton addTarget:self action:@selector(deviceButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_captureSessionView.controlsView.recordButton addTarget:self action:@selector(recordButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_captureSessionView.controlsView.adjustmentButton addTarget:self action:@selector(adjustmentButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_captureSessionView.controlsView.trackerButton addTarget:self action:@selector(trackerButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
        _recording = NO;
        
        [[self navigationController] setNavigationBarHidden:YES animated:NO];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(referenceFrameProcessDidFinish:)
                                                     name:@"referenceframe.action.finished"
                                                   object:nil];
    }
    
    return self;
}

- (void)hideOrShowControlsView
{
    UIColor *colorForControlView = (_recording) ? [UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.5] : [UIColor clearColor];
    
    [UIView animateWithDuration:0.5 animations:^{
        _captureSessionView.controlsView.backgroundColor = colorForControlView;
    }];
}

- (void)deviceButtonAction
{
    AVCaptureDevice *currentDevice = _captureSessionController.captureSession.captureDevice;
    AVCaptureDevicePosition position = (currentDevice.position == AVCaptureDevicePositionBack) ? AVCaptureDevicePositionFront : AVCaptureDevicePositionBack;
    AVCaptureDevice *newDevice = [CaptureDeviceManager uniqueDeviceWithPosition:position];
    [_captureSessionController switchToCaptureDevice:newDevice];
}

- (void)recordButtonAction
{
    [self hideOrShowControlsView];
    
    [_captureSessionView.controlsView.deviceButton setHidden:!_recording];
    [_captureSessionView.controlsView.adjustmentButton setHidden:!_recording];
    [_captureSessionView.controlsView.trackerButton setHidden:!_recording];
    
    [_captureSessionView.controlsView.recordButton transformShape];
    
    if (!_recording)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"recording.action.started" object:self userInfo:[NSDictionary dictionaryWithObject:_videoDirectory forKey:@"video.path"]];
        
        // Starts label time
        
        [_captureSessionView.controlsView.recordingDurationLabelView startDuration];
        [_captureSessionView.controlsView.recordingIconView startFlickering];
    }
    
    else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"recording.action.stopped" object:self userInfo:nil];
        
        [_captureSessionView.controlsView.recordingDurationLabelView stopDuration];
        [_captureSessionView.controlsView.recordingIconView stopFlickering];
    }
    
    _recording = !_recording;
}

- (void)adjustmentButtonAction
{
    [self hideOrShowControlsView];
    
    [_captureSessionView.controlsView.deviceButton setHidden:!_recording];
    [_captureSessionView.controlsView.recordButton setHidden:!_recording];
    [_captureSessionView.controlsView.recordingDurationLabelView setHidden:!_recording];
    [self.navigationItem.leftBarButtonItem setEnabled:!_recording];
    //[((UIApplicationNavigationViewController *)self.navigationController).navigationItem.leftBarButtonItem setEnabled:!_recording];
    //[_captureSessionView.controlsView.adjustmentButton setHidden:!_recording];
    [_captureSessionView.controlsView.trackerButton setHidden:!_recording];
    
    if (!_recording)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"referenceframe.action.started" object:self userInfo:nil];
        
        [_captureSessionView.overlayView addSubview:_captureSessionView.overlayView.adjustmentActivityIndicatorView alignment:UIViewCentered];
        [_captureSessionView.overlayView.adjustmentActivityIndicatorView.activityIndicatorView startAnimating];
    }
    
    else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"referenceframe.action.stopped" object:self userInfo:nil];
        
        [_captureSessionView.overlayView.adjustmentActivityIndicatorView.activityIndicatorView stopAnimating];
        [_captureSessionView.overlayView.adjustmentActivityIndicatorView removeFromSuperview];
    }
    
    _recording = !_recording;
}

- (void)trackerButtonAction
{
    [self hideOrShowControlsView];
    
    [_captureSessionView.controlsView.deviceButton setHidden:!_recording];
    [_captureSessionView.controlsView.recordButton setHidden:!_recording];
    [_captureSessionView.controlsView.adjustmentButton setHidden:!_recording];
    [_captureSessionView.controlsView.recordingDurationLabelView setHidden:!_recording];
    [_captureSessionView.overlayView.controlsView setHidden:_recording];
    
    if (!_recording)
    {
        _locateRegionTapGestureRecognizer = [[UITapGestureRecognizer alloc]
                                                 initWithTarget:self action:@selector(singleTapGestureToLocateRegion:)];
        
        _locateRegionTapGestureRecognizer.numberOfTapsRequired = 1;
        _locateRegionTapGestureRecognizer.cancelsTouchesInView = NO;
        [_captureSessionView.overlayView.gestureView addGestureRecognizer:_locateRegionTapGestureRecognizer];
        
        UIBezierPath* path = [[UIBezierPath alloc]init];
        [path moveToPoint:CGPointMake(0, 0)];
        [path closePath];
        
        [_captureSessionView.overlayView.regionBoundShapeView setPath:path.CGPath];
        [_captureSessionView.overlayView.layer addSublayer:_captureSessionView.overlayView.regionBoundShapeView];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"tracker.action.started" object:self userInfo:nil];
    }
    
    else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"tracker.action.stopped" object:self userInfo:nil];
        [self.view removeGestureRecognizer:_locateRegionTapGestureRecognizer];
        
        [_captureSessionView.overlayView.regionBoundShapeView removeFromSuperlayer];
        
        if (_captureSessionView.overlayView.debugImageView.image != nil)
            [self binaryModeButtonAction];
    }
    
    _recording = !_recording;
}

- (void)loadView
{
    [super loadView];
    
    [self.view addSubview:_captureSessionView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    AVCaptureConnection *previewLayerConnection=_captureSessionView.captureVideoPreviewLayer.connection;
    
    if ([previewLayerConnection isVideoOrientationSupported])
        [previewLayerConnection setVideoOrientation:AVCaptureVideoOrientationLandscapeRight];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    
    [_captureSessionController startSession];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = nil;
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [_captureSessionController stopSession];
}

- (void)prepareForUse
{
    [_captureSessionView layout];
    
    [_captureSessionView.overlayView.controlsView.binaryThresholdSlider addTarget:self action:@selector(binaryThresholdSliderAction:) forControlEvents:UIControlEventValueChanged];
    [_captureSessionView.overlayView.controlsView.binaryModeButton addTarget:self action:@selector(binaryModeButtonAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)prepareForReuse
{
    return;
}

- (void)binaryThresholdSliderAction:(UISlider *)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"tracking.binarythreshold.changed" object:self userInfo:[NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:sender.value] forKey:@"threshold"]];
}

- (void)binaryModeButtonAction
{
    if (_captureSessionView.overlayView.debugImageView.image == nil)
    {
        [_captureSessionView.captureVideoPreviewLayer removeFromSuperlayer];
    }
    
    else
    {
        [[_captureSessionView layer] insertSublayer:_captureSessionView.captureVideoPreviewLayer atIndex:0];
        [_captureSessionView.overlayView.debugImageView setImage:nil];
    }
    
    _captureSessionView.overlayView.controlsView.binaryModeButton.selected = !_captureSessionView.overlayView.controlsView.binaryModeButton.selected;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"tracking.binarymode.button.clicked" object:self userInfo:nil];
}

- (void)referenceFrameProcessDidFinish:(NSNotification *)notification
{
    NSLog(@"referenceFrameProcessDidFinish notification received");
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self hideOrShowControlsView];
        
        [_captureSessionView.controlsView.deviceButton setHidden:NO];
        [_captureSessionView.controlsView.recordButton setHidden:NO];
        [_captureSessionView.controlsView.recordingDurationLabelView setHidden:NO];
        [_captureSessionView.controlsView.trackerButton setHidden:NO];
        
        [_captureSessionView.overlayView.adjustmentActivityIndicatorView.activityIndicatorView stopAnimating];
        [_captureSessionView.overlayView.adjustmentActivityIndicatorView removeFromSuperview];
        
        _recording = !_recording;
    });
}

- (void)singleTapGestureToLocateRegion:(UITapGestureRecognizer *)recognizer
{
    CGPoint touchPoint = [recognizer locationInView:_captureSessionView.overlayView];
    NSLog(@"touchPoint : (%f, %f)", touchPoint.x, touchPoint.y);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"overlay.view.singletap.region.detected" object:self userInfo:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSNumber numberWithFloat:touchPoint.x], [NSNumber numberWithFloat:touchPoint.y], nil] forKeys:[NSArray arrayWithObjects:@"touchPoint.x", @"touchPoint.y", nil]]];
}

@end
