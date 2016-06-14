//
//  ExtractorVideoDataOutputProcess.h
//  VirtualCoach
//
//  Created by Romain Dubreucq on 11/05/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "ExtractorVideoDataOutputDelegate.h"
#import "Configurable.h"
#import "Process.h"

@interface ExtractorVideoDataOutputProcess : NSObject <Configurable, Process>

@property (nonatomic, weak) id <ExtractorVideoDataOutputDelegate> delegate;

- (instancetype)initWithFile:(NSString *)filePath;
- (NSUInteger)estimatedFrameCount;

@end
