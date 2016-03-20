//
//  TrackingProcess.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 06/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "TrackingProcess.h"

#include <drawing.h>
#include "charact_ext.h"

@interface TrackingProcess ()

@property (nonatomic) BOOL canRetrieveFrames;
@property (nonatomic) BOOL shouldSendBinaryFrames;
@property (nonatomic, assign) BOOL canLabelAndEstablish;
@property (nonatomic, assign) BOOL canFindRegionFromZone;
@property (nonatomic, assign) BOOL canTrackRegion;

@property (nonatomic, assign) regchar_t *previousReg;
@property (nonatomic, assign) labels_t *previousLabels;
@property (nonatomic, assign) rect_t clicRegionZone;

@property (nonatomic, assign) unsigned int clicRegionZoneRadius;

// temp
@property (nonatomic) NSUInteger count;
@property (nonatomic) NSUInteger lazyCount;

- (void)setBinaryThresholdFromNotification:(NSNotification *)notification;
- (void)setShouldSendBinaryFramesFromNotification:(NSNotification *)notification;
- (void)tapOnScreenToLocateRegionNotification:(NSNotification *)notification;

@end

@implementation TrackingProcess

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        _canRetrieveFrames = NO;
        _shouldSendBinaryFrames = NO;
        _canLabelAndEstablish = NO;
        _canFindRegionFromZone = NO;
        _count = 0;
        _binaryThreshold = 30;
        _referenceFrame = NULL;
        _clicRegionZoneRadius = 20;
        
        _canTrackRegion = NO;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(setBinaryThresholdFromNotification:)
                                                     name:@"tracking.binarythreshold.changed"
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(tapOnScreenToLocateRegionNotification:)
                                                     name:@"overlay.view.singletap.region.detected"
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(setShouldSendBinaryFramesFromNotification:)
                                                     name:@"tracking.binarymode.button.clicked"
                                                   object:nil];
        
        _clicRegionZone.start.x = 0;
        _clicRegionZone.start.y = 0;
        _clicRegionZone.end.x = 0;
        _clicRegionZone.end.y = 0;
        
        _previousReg = regcharalloc(0);
        _previousLabels = laballoc(1, 1);
    }
    
    return self;
}

- (void)start
{
    _canRetrieveFrames = YES;
}

- (void)stop
{
    _canRetrieveFrames = NO;
}

- (void)pause
{
    
}

- (void)resume
{
    
}

- (BOOL)running
{
    return _canRetrieveFrames;
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
    _lazyCount++;
    
    if (_canRetrieveFrames)// && (_lazyCount > 80))
    {
        NSLog(@"TrackingProcess running");
        _count++;
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
        
        rgb8i_t *rgb = rgb8iallocwd_bgra((uint16_t)width, (uint16_t)height, myPixelBuf);
        free(myPixelBuf);
        
        gray8i_t *grayscaleImg = grayscale(rgb);
        gray8i_t *grayscaleSubstract = subgray8i(grayscaleImg, _referenceFrame);
        bini_t *binaryImg = binarise(grayscaleSubstract, _binaryThreshold);
        
        if (_shouldSendBinaryFrames)
        {
            gray8i_t *unbinaryImg = unbinarise(binaryImg);
            
            CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceGray();
            CFDataRef rgbData = CFDataCreate(NULL, unbinaryImg->data, width * height);
            CGDataProviderRef provider = CGDataProviderCreateWithCFData(rgbData);
            CGImageRef binaryImageRef = CGImageCreate(width, height, 8, 8, width, colorspace, kCGBitmapByteOrderDefault, provider, NULL, true, kCGRenderingIntentDefault);
            CFRelease(rgbData);
            CGDataProviderRelease(provider);
            CGColorSpaceRelease(colorspace);
            
            NSDictionary *userInfoDebugImage = [NSDictionary dictionaryWithObject:(__bridge id _Nonnull)(binaryImageRef) forKey:@"debugImage"];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"debug.image.changed" object:self userInfo:userInfoDebugImage];
            
            gray8ifree(unbinaryImg);
        }
        
        if (_canLabelAndEstablish)
        {
            labels_t *nextLabels = label(binaryImg);
            charact_t *charact = characterize(NULL, grayscaleImg, nextLabels);
            
            if (_canTrackRegion)
            {
                //int32_t bestRegId = [TrackingService trackRegion:previousReg byOverlapping:previousLabels withReferenceLabels:nextLabels];
                int32_t bestRegId = overlappingreg(_previousReg, _previousLabels, nextLabels, width);
                
                NSLog(@"bestRegId : %d", bestRegId);
                
                NSDictionary *userInfo = nil;
                
                if ((bestRegId > 0) && (bestRegId <= charact->count))
                {
                    regchar_t *bestReg = charact->data[bestRegId-1];
                    
                    userInfo = [NSDictionary dictionaryWithObjects:[NSArray
                                                                    arrayWithObjects:
                                                                    [NSNumber numberWithInt:bestReg->bounds.start.y],
                                                                    [NSNumber numberWithInt:bestReg->bounds.start.x],
                                                                    [NSNumber numberWithInt:bestReg->bounds.end.y],
                                                                    [NSNumber numberWithInt:bestReg->bounds.end.x],
                                                                    [NSNumber numberWithUnsignedInt:(uint16_t)width],
                                                                    [NSNumber numberWithUnsignedInt:(uint16_t)height],
                                                                    nil]
                                                           forKeys:[NSArray arrayWithObjects:
                                                                    @"startPoint.i",
                                                                    @"startPoint.j",
                                                                    @"endPoint.i",
                                                                    @"endPoint.j",
                                                                    @"image.width",
                                                                    @"image.height", nil]];
                    
                    free(_previousReg);
                    _previousReg = regcharcpy(bestReg);
                    labfree(_previousLabels);
                    _previousLabels = nextLabels;
                }
                
                else
                {
                    labfree(nextLabels);
                }
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"tracking.bounds.changed" object:self userInfo:userInfo];
            }
            
            else
            {
                NSLog(@"Trying to find region... at (%u, %u)", _clicRegionZone.start.x + _clicRegionZoneRadius, _clicRegionZone.start.y + _clicRegionZoneRadius);
                
                int32_t foundRegionByClick = regionAtZone(_clicRegionZone, nextLabels);
                
                if (foundRegionByClick > 0 && foundRegionByClick <= charact->count)
                {
                    regchar_t *regClicked = charact->data[foundRegionByClick-1];
                    
                    if (regClicked->size > 40)
                    {
                        free(_previousReg);
                        _previousReg = regcharcpy(charact->data[foundRegionByClick-1]);
                        _canTrackRegion = YES;
                    }
                }
                
                labfree(_previousLabels);
                _previousLabels = nextLabels;
            }
            
            charactfree(charact);
        }
        
        binifree(binaryImg);
        gray8ifree(grayscaleSubstract);
        gray8ifree(grayscaleImg);
        
        rgb8ifree(rgb);
    }
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didDropSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
    
}

- (void)setBinaryThresholdFromNotification:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    
    if (userInfo)
    {
        uint8_t binaryThreshold = (uint8_t)[[userInfo objectForKey:@"threshold"] intValue];
        _binaryThreshold = binaryThreshold;
    }
}

- (void)setShouldSendBinaryFramesFromNotification:(NSNotification *)notification
{
    _shouldSendBinaryFrames = !_shouldSendBinaryFrames;
}

- (void)tapOnScreenToLocateRegionNotification:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    
    if (userInfo)
    {
        NSLog(@"tapOnScreenToLocateRegionNotification");
        uint32_t x = ((NSNumber *)[userInfo objectForKey:@"touchPoint.x"]).unsignedIntValue;
        uint32_t y = ((NSNumber *)[userInfo objectForKey:@"touchPoint.y"]).unsignedIntValue;
        
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width, screenHeight = [UIScreen mainScreen].bounds.size.height;
        
        unsigned int touch_x = x * (1280 / screenWidth);
        unsigned int touch_y = y * (720 / screenHeight);
        
        _clicRegionZone.start.x = touch_x - _clicRegionZoneRadius;
        _clicRegionZone.start.y = touch_y - _clicRegionZoneRadius;
        _clicRegionZone.end.x = touch_x + _clicRegionZoneRadius;
        _clicRegionZone.end.y = touch_y + _clicRegionZoneRadius;
        
        _canLabelAndEstablish = YES;
        _canFindRegionFromZone = YES;
        _canTrackRegion = NO;
    }
}

@end
