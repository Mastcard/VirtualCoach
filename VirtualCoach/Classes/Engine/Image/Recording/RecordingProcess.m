//
//  RecordingProcess.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 09/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "RecordingProcess.h"

@implementation RecordingProcess

- (void)start
{
    
}

- (void)stop
{
    
}

- (void)pause
{
    
}

- (void)resume
{
    
}

- (BOOL)running
{
    return YES;
}

- (void)captureOutput:(AVCaptureFileOutput *)captureOutput
didStartRecordingToOutputFileAtURL:(NSURL *)fileURL
      fromConnections:(NSArray *)connections
{
    NSLog(@"RecordingProcess running, recording at %@", fileURL.path);
}

- (void)captureOutput:(AVCaptureFileOutput *)captureOutput
didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL
      fromConnections:(NSArray *)connections
                error:(NSError *)error
{
    
}

@end
