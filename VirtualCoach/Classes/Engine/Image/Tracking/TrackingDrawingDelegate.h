//
//  TrackingDrawingDelegate.h
//  VirtualCoach
//
//  Created by Romain Dubreucq on 12/05/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <Foundation/Foundation.h>

#include <core.h>
#include <geometry.h>

@protocol TrackingDrawingDelegate <NSObject>

- (void)didSendImage:(CGImageRef)image;
- (void)didSendRegionBounds:(rect_t)bounds forImageSize:(CGSize)size;
- (void)didDetectObjectMotion:(BOOL)moved;

@end
