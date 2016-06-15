//
//  ImageTools.h
//  VirtualCoach
//
//  Created by Romain Dubreucq on 12/05/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <CoreMedia/CoreMedia.h>

#include <core.h>

@interface ImageTools : NSObject

+ (CGImageRef)grayscaleCgImage:(CGImageRef)image; //tested
+ (gray8i_t *)cgImageToGrayImage:(CGImageRef)image; //tested
+ (CGImageRef)gray8iToCgImage:(gray8i_t *)src;
+ (rgb8i_t *)cgImageToRGBImage:(CGImageRef)image;
+ (CGImageRef)scaleCgimage:(CGImageRef)image scale:(CGFloat)scale; //tested
+ (CGImageRef)cgImageFromSampleBuffer:(CMSampleBufferRef)sampleBuffer; //tested
+ (rgb8i_t *)rgbImageFromSampleBuffer:(CMSampleBufferRef)sampleBuffer; //tested

@end
