//
//  ExtractorProcess.h
//  VirtualCoach
//
//  Created by Romain Dubreucq on 08/05/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <ImageIO/ImageIO.h>
#import "Process.h"
#import "Configurable.h"

#include <core.h>
#include <io.h>

@interface ExtractorProcess : NSObject <Process, Configurable>

@property (nonatomic) NSString *framesDirectoryPath;

- (instancetype)initWithFile:(NSString *)filePath;

@end
