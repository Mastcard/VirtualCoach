//
//  ImageTools.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 12/05/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "ImageTools.h"

@implementation ImageTools

+ (CGImageRef)grayscaleCgImage:(CGImageRef)image
{
    CGRect imageRect = CGRectMake(0, 0, CGImageGetWidth(image), CGImageGetHeight(image));
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate(nil, CGImageGetWidth(image), CGImageGetHeight(image), 8, 0, colorSpace, kCGImageAlphaNone);
    CGContextDrawImage(context, imageRect, image);
    
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    
    return imageRef;
}

+ (gray8i_t *)cgImageToGrayImage:(CGImageRef)image
{
    CGImageRef grayImage = [ImageTools grayscaleCgImage:image];
    
    size_t width = CGImageGetWidth(grayImage);
    size_t height = CGImageGetHeight(grayImage);
    CGDataProviderRef dataProvider = CGImageGetDataProvider(grayImage);
    CFDataRef imageData = CGDataProviderCopyData(dataProvider);
    uint8_t *rawData = (uint8_t *)CFDataGetBytePtr(imageData);
    
    gray8i_t *dst = gray8iallocwd((uint16_t)width, (uint16_t)height, rawData);
    
    CFRelease(imageData);
    CGImageRelease(grayImage);
    
    return dst;
}

+ (CGImageRef)gray8iToCgImage:(gray8i_t *)src
{
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceGray();
    
    CFDataRef grayData = CFDataCreate(NULL, src->data, src->width * src->height);
    
    CGDataProviderRef provider = CGDataProviderCreateWithCFData(grayData);
    
    CGImageRef grayImageRef = CGImageCreate(src->width, src->height, 8, 8, src->width, colorspace, kCGBitmapByteOrderDefault, provider, NULL, true, kCGRenderingIntentDefault);
    
    CFRelease(grayData);
    CGDataProviderRelease(provider);
    CGColorSpaceRelease(colorspace);
    
    return grayImageRef;
}

+ (rgb8i_t *)cgImageToRGBImage:(CGImageRef)image
{
    return NULL;
}

+ (CGImageRef)scaleCgimage:(CGImageRef)image scale:(CGFloat)scale
{
    size_t newWidth = CGImageGetWidth(image) * scale;
    size_t newHeight = CGImageGetHeight(image) * scale;
    
    CGRect imageRect = CGRectMake(0, 0, newWidth, newHeight);
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(image);
    size_t bitsPerComponents = CGImageGetBitsPerComponent(image);
    size_t bytesPerRow = CGImageGetBytesPerRow(image);
    CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(image);
    
    CGContextRef context = CGBitmapContextCreate(nil, newWidth, newHeight, bitsPerComponents, bytesPerRow, colorSpace, bitmapInfo);
    CGContextDrawImage(context, imageRect, image);
    
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    
    CGContextRelease(context);
    
    return imageRef;
}

+ (CGImageRef)cgImageFromSampleBuffer:(CMSampleBufferRef)sampleBuffer
{
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    CVPixelBufferLockBaseAddress(imageBuffer, 0);
    
    uint8_t *baseAddress = (uint8_t *)CVPixelBufferGetBaseAddressOfPlane(imageBuffer, 0);
    size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
    size_t width = CVPixelBufferGetWidth(imageBuffer);
    size_t height = CVPixelBufferGetHeight(imageBuffer);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef rgbContext = CGBitmapContextCreate(baseAddress, width, height, 8, bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
    CGImageRef rgbImageRef = CGBitmapContextCreateImage(rgbContext);
    
    CGContextRelease(rgbContext);
    CGColorSpaceRelease(colorSpace);
    CVPixelBufferUnlockBaseAddress(imageBuffer,0);
    
    return rgbImageRef;
}

+ (CGImageRef)scaledCgImageFromSampleBuffer:(CMSampleBufferRef)sampleBuffer scale:(CGFloat)scale
{
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    CVPixelBufferLockBaseAddress(imageBuffer, 0);
    
    uint8_t *baseAddress = (uint8_t *)CVPixelBufferGetBaseAddressOfPlane(imageBuffer, 0);
    size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
    size_t width = CVPixelBufferGetWidth(imageBuffer);
    size_t height = CVPixelBufferGetHeight(imageBuffer);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef rgbContext = CGBitmapContextCreate(baseAddress, width, height, 8, bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
    CGImageRef rgbImageRef = CGBitmapContextCreateImage(rgbContext);
    
    CGContextRelease(rgbContext);
    CGColorSpaceRelease(colorSpace);
    CVPixelBufferUnlockBaseAddress(imageBuffer,0);
    
    return rgbImageRef;
}

+ (rgb8i_t *)rgbImageFromSampleBuffer:(CMSampleBufferRef)sampleBuffer
{
    CVPixelBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    CVPixelBufferLockBaseAddress(imageBuffer,0);
    uint8_t * tempAddress = (uint8_t *)CVPixelBufferGetBaseAddress(imageBuffer);
    size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
    size_t width = CVPixelBufferGetWidth(imageBuffer);
    size_t height = CVPixelBufferGetHeight(imageBuffer);
    CVPixelBufferUnlockBaseAddress(imageBuffer,0);
    size_t bufferSize = bytesPerRow * height;
    uint8_t *myPixelBuf = malloc(bufferSize);
    memmove(myPixelBuf, tempAddress, bufferSize);
    
    rgb8i_t *dst = rgb8iallocwd_bgra((uint16_t)width, (uint16_t)height, myPixelBuf);
    free(myPixelBuf);
    
    return dst;
}

@end
