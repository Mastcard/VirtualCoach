//
//  TrackingProcess.h
//  VirtualCoach
//
//  Created by Romain Dubreucq on 06/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>
#import "Process.h"
#import "TrackingService.h"

#include <core.h>
#include <arithmetic.h>
#include <labelling.h>
#include <characterization.h>
#include <morpho.h>

@interface TrackingProcess : NSObject <AVCaptureVideoDataOutputSampleBufferDelegate, Process>

@property (nonatomic, assign) uint8_t binaryThreshold;
@property (nonatomic, assign) gray8i_t *referenceFrame;

@end
