//
//  ExtractorVideoDataOutputDelegate.h
//  VirtualCoach
//
//  Created by Romain Dubreucq on 11/05/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <Foundation/Foundation.h>

@import CoreMedia;

@protocol ExtractorVideoDataOutputDelegate <NSObject>

- (void)didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer;
- (void)didEstimateFrameCount:(Float64)frameCount;

@end
