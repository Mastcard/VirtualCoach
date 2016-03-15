//
//  RecordingProcess.h
//  VirtualCoach
//
//  Created by Romain Dubreucq on 09/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "Process.h"

@interface RecordingProcess : NSObject <AVCaptureFileOutputRecordingDelegate, Process>

@end
