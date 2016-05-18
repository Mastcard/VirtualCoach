//
//  ReferenceFrameProcess.h
//  VirtualCoach
//
//  Created by Romain Dubreucq on 08/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>
#import "Process.h"
#import "ReferenceFrameProcessDelegate.h"

#include <core.h>

#include <io.h>

@interface ReferenceFrameProcess : NSObject <AVCaptureVideoDataOutputSampleBufferDelegate, Process>

@property (nonatomic, assign) unsigned int maxAccumulatedFrames;

@property (nonatomic, weak) id <ReferenceFrameProcessDelegate> delegate;

- (gray8i_t *)retrieveReferenceFrame;

@end
