//
//  TrackingProcess.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 06/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "TrackingProcess.h"

@interface TrackingProcess ()

@property (nonatomic) BOOL canRetrieveFrames;

// temp
@property (nonatomic) NSUInteger count;

- (void)setBinaryThresholdFromNotification:(NSNotification *)notification;

@end

@implementation TrackingProcess

regchar_t *previousReg;
labels_t *previousLabels;

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        _canRetrieveFrames = NO;
        _count = 0;
        _binaryThreshold = 30;
        _referenceFrame = NULL;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(setBinaryThresholdFromNotification:)
                                                     name:@"tracking.binarythreshold.changed"
                                                   object:nil];
        
        previousReg = regcharalloc(0);
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
    if (_canRetrieveFrames)
    {
        //NSLog(@"TrackingProcess running");
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
        
        unsigned long size = width * height;
        
        gray8i_t *grayscaleImg = grayscale(rgb);
        gray8i_t *grayscaleSubstract = subgray8i(grayscaleImg, _referenceFrame);
        bini_t *binaryImg = binarise(grayscaleSubstract, _binaryThreshold);
        //bini_t *erodedImg = erosion(binaryImg, 1);
        gray8i_t *unbinaryImg = unbinarise(binaryImg);
        labels_t *nextLabels = label(binaryImg);
        charact_t *charact = characterize(NULL, grayscaleImg, nextLabels);
        
//        CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceGray();
//        CFDataRef rgbData = CFDataCreate(NULL, unbinaryImg->data, width * height);
//        CGDataProviderRef provider = CGDataProviderCreateWithCFData(rgbData);
//        CGImageRef binaryImageRef = CGImageCreate(width, height, 8, 8, width, colorspace, kCGBitmapByteOrderDefault, provider, NULL, true, kCGRenderingIntentDefault);
//        CFRelease(rgbData);
//        CGDataProviderRelease(provider);
//        CGColorSpaceRelease(colorspace);
//        
//        NSDictionary *userInfoDebugImage = [NSDictionary dictionaryWithObject:(__bridge id _Nonnull)(binaryImageRef) forKey:@"debugImage"];
//        
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"debug.image.changed" object:self userInfo:userInfoDebugImage];
        
        if (previousReg->id == 0)
        {
            uint32_t firstRegIndex = 0, firstRegSize = 0;

            int a = 0;

            for (a = 0; a < charact->count; a++)
            {
                if (charact->data[a]->size > firstRegSize)
                {
                    firstRegSize = charact->data[a]->size;
                    firstRegIndex = a;
                }
            }

            free(previousReg);
            previousReg = regcharcpy(charact->data[firstRegIndex]);
            previousLabels = nextLabels;
        }

        else
        {
            int32_t bestRegId = overlappingreg(previousReg, previousLabels, nextLabels, width);

            //printf("bestRegId : %d\n", bestRegId);

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

                free(previousReg);
                previousReg = regcharcpy(bestReg);
                labfree(previousLabels);
                previousLabels = nextLabels;
            }

            else
            {
                labfree(nextLabels);
            }

            [[NSNotificationCenter defaultCenter] postNotificationName:@"tracking.bounds.changed" object:self userInfo:userInfo];
        }
        
        //labfree(nextLabels);
        charactfree(charact);
        gray8ifree(unbinaryImg);
        //binifree(erodedImg);
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

@end
