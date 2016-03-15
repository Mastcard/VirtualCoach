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

- (void)hideOrShowControlsView;

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
        
        [_captureSessionView.overlayView.binaryThresholdSlider addTarget:self action:@selector(binaryThresholdSliderAction:) forControlEvents:UIControlEventValueChanged];
        
        _recording = NO;
        
        [[self navigationController] setNavigationBarHidden:YES animated:NO];
        
//        [[NSNotificationCenter defaultCenter] addObserver:[self class]
//                                                 selector:@selector(startReferenceFrameProcess:)
//                                                     name:@"referenceframe.action.finished"
//                                                   object:nil];
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
    
    _videoDirectory = [NSURL fileURLWithPath:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]];
    
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
    //[_captureSessionView.controlsView.adjustmentButton setHidden:!_recording];
    [_captureSessionView.controlsView.trackerButton setHidden:!_recording];
    
    if (!_recording)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"referenceframe.action.started" object:self userInfo:nil];
    }
    
    else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"referenceframe.action.stopped" object:self userInfo:nil];
    }
    
    _recording = !_recording;
}

- (void)trackerButtonAction
{
    [self hideOrShowControlsView];
    
    [_captureSessionView.controlsView.deviceButton setHidden:!_recording];
    [_captureSessionView.controlsView.recordButton setHidden:!_recording];
    [_captureSessionView.controlsView.adjustmentButton setHidden:!_recording];
    //[_captureSessionView.controlsView.trackerButton setHidden:!_recording];
    [_captureSessionView.overlayView.binaryThresholdSlider setHidden:_recording];
    
    if (!_recording)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"tracker.action.started" object:self userInfo:nil];
    }
    
    else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"tracker.action.stopped" object:self userInfo:nil];
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
    
    AVCaptureConnection *previewLayerConnection=_captureSessionView.captureVideoPreviewLayer.connection;
    
    if ([previewLayerConnection isVideoOrientationSupported])
        [previewLayerConnection setVideoOrientation:AVCaptureVideoOrientationLandscapeRight];
    
    // Starting session
    
    [_captureSessionController startSession];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [_captureSessionController stopSession];
}

- (void)prepareForUse
{
    [_captureSessionView layout];
}

- (void)prepareForReuse
{
    return;
}

- (void)binaryThresholdSliderAction:(UISlider *)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"tracking.binarythreshold.changed" object:self userInfo:[NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:sender.value] forKey:@"threshold"]];
}

@end
