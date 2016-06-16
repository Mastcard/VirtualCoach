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

#define ALPHA 0.8
#define BETA -1
#define GRAV_SPEED_THRESHOLD 5

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

@property (nonatomic, assign) float previousGravityCenterSpeed;

// temp
@property (nonatomic) NSUInteger count;
@property (nonatomic) NSUInteger lazyCount;

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
        _previousGravityCenterSpeed = 0.f;
        
        _canTrackRegion = NO;
        
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
        
        //rgb8i_t *rgb = rgb8ialloc((uint16_t)width, (uint16_t)height);
        
        gray8i_t *grayscaleImg = gray8ialloc((uint16_t)width, (uint16_t)height);
        //gray8i_t *grayscaleSubstract = subgray8i(grayscaleImg, _referenceFrame); //
        bini_t *binaryImg = binialloc((uint16_t)width, (uint16_t)height);
        
        unsigned long length = width * height * 4;
        unsigned int i = 0, j = 0;
        
        for (i = 0; i < length; i+=4)
        {
            uint8_t r = myPixelBuf[i+2];
            uint8_t g = myPixelBuf[i+1];
            uint8_t b = myPixelBuf[i];
            
            grayscaleImg->data[j] = (uint8_t)((r + g + b) / 3);
            binaryImg->data[j] = !(abs(grayscaleImg->data[j] - _referenceFrame->data[j]) > _binaryThreshold);
            
            j++;
        }
        
        free(myPixelBuf);
        
        /** DO BELOW IN ONE LOOP TO OPTIMIZE **/
        
//        rgb8i_t *rgb = rgb8iallocwd_bgra((uint16_t)width, (uint16_t)height, myPixelBuf);
//        free(myPixelBuf);
//        
//        gray8i_t *grayscaleImg = grayscale(rgb);
//        gray8i_t *grayscaleSubstract = subgray8i(grayscaleImg, _referenceFrame);
//        bini_t *binaryImg = binarise(grayscaleSubstract, _binaryThreshold);
        
        /** DO ABOVE IN ONE LOOP TO OPTIMIZE **/
        
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
            
            [_delegate didSendImage:binaryImageRef];
            
            gray8ifree(unbinaryImg);
        }
        
        if (_canLabelAndEstablish)
        {
            labels_t *nextLabels = label(binaryImg);
            charact_t *charact = characterize(NULL, grayscaleImg, nextLabels);
            
            if (_canTrackRegion)
            {
                int32_t bestRegId = overlappingreg(_previousReg, _previousLabels, nextLabels);
                
                //NSLog(@"bestRegId : %d", bestRegId);
                
                if ((bestRegId > 0) && (bestRegId <= charact->count))
                {
                    regchar_t *bestReg = charact->data[bestRegId-1];
                    
//                    vect2d_t gravvect;
//                    gravvect.x = (double)bestReg->gravity.x - (double)_previousReg->gravity.x;
//                    gravvect.y = (double)bestReg->gravity.y - (double)_previousReg->gravity.y;
                    
                    //printf("gravvect.x : %f, gravvect.y : %f\n", gravvect.x, gravvect.y);
                    
//                    float gravityCenterSpeed = gravCenterSpeed(gravvect, _previousGravityCenterSpeed, ALPHA, BETA);
                    
                    //printf("gravityCenterSpeed : %f\n", gravityCenterSpeed);
                    
//                    _previousGravityCenterSpeed = gravityCenterSpeed;
                    
//                    unsigned int reg_bounds_x_diff = bestReg->bounds.end.x - bestReg->bounds.start.x;
//                    float grav_speed_threshold = 0.025 * reg_bounds_x_diff; //0.024593
                    //printf("gravityCenterSpeed %f < grav_speed_threshold %f\n", gravityCenterSpeed, grav_speed_threshold);
                    
                    //[_delegate didDetectObjectMotion:gravityCenterSpeed < grav_speed_threshold ? NO : YES];
                    
                    _playerBounds.start.x = bestReg->bounds.start.x;
                    _playerBounds.start.y = bestReg->bounds.start.y;
                    _playerBounds.end.x = bestReg->bounds.end.x;
                    _playerBounds.end.y = bestReg->bounds.end.y;
                    
                    free(_previousReg);
                    _previousReg = regcharcpy(bestReg);
                    labfree(_previousLabels);
                    _previousLabels = nextLabels;
                }
                
                else
                {
                    labfree(nextLabels);
                }
                
//                NSLog(@"");
//                NSLog(@"BOUNDS : (%u, %u, %u, %u)", _playerBounds.start.x, _playerBounds.start.y, _playerBounds.end.x, _playerBounds.end.y);
                
                [_delegate didSendRegionBounds:_playerBounds forImageSize:CGSizeMake((CGFloat)width, (CGFloat)height)];
            }
            
            else
            {
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
        //gray8ifree(grayscaleSubstract);
        gray8ifree(grayscaleImg);
        
        //rgb8ifree(rgb);
    }
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didDropSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
    
}

// testing delegate

- (void)didBinaryThresholdChange:(uint8_t)threshold
{
    _binaryThreshold = threshold;
}

- (void)didEnterInBinaryMode
{
    _shouldSendBinaryFrames = !_shouldSendBinaryFrames;
}

- (void)didReceiveSingleTapAt:(CGPoint)touchPoint
{
    CGFloat x = touchPoint.x;
    CGFloat y = touchPoint.y;
    
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

@end
