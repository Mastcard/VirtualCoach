//
//  CaptureProcessManager.h
//  VirtualCoach
//
//  Created by Romain Dubreucq on 13/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

#import "TrackingProcess.h"
#import "RecordingProcess.h"
#import "ReferenceFrameProcess.h"
#import "HybridCaptureSessionController.h"
#import "CaptureSessionControllerFactory.h"

@interface CaptureProcessManager : NSObject

+ (instancetype)sharedInstance;

- (HybridCaptureSessionController *)captureSessionController;
- (TrackingProcess *)trackingProcess;
- (ReferenceFrameProcess *)referenceFrameProcess;
- (RecordingProcess *)recordingProcess;

@end
