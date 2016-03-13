//
//  ReferenceFrameProcess.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 08/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "ReferenceFrameProcess.h"

@interface ReferenceFrameProcess ()

@property (nonatomic) BOOL canRetrieveFrames;

@property (nonatomic, assign) gray8i_t *result;

@property (assign) unsigned int* acc;

@property (nonatomic) NSUInteger count;
@property (nonatomic) uint16_t width;
@property (nonatomic) uint16_t height;
@property (nonatomic) uint32_t size;

@end

@implementation ReferenceFrameProcess

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        _canRetrieveFrames = NO;
        _maxAccumulatedFrames = 200;
        _result = NULL;
        _width = 0;
        _height = 0;
    }
    
    return self;
}

- (void)buildReferenceFrame
{
    _result = gray8ialloc(_width, _height);
    
    unsigned int i = 0;
    
    for (i = 0; i < _size; i++)
        _result->data[i] = (uint8_t)(_acc[i] / _count);
}

- (gray8i_t *)retrieveReferenceFrame
{
    return _result;
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

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
    if (_canRetrieveFrames)
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
        
        rgb8i_t *rgb = rgb8iallocwd_bgra(_width, _height, myPixelBuf);
        free(myPixelBuf);
        
        if (_count < _maxAccumulatedFrames)
        {
            if (_count == 1)
            {
                _width = (uint16_t)width;
                _height = (uint16_t)height;
                _size = _width * _height;
                _acc = (unsigned int *)calloc(_size, sizeof(unsigned int));
            }
            
            unsigned int i = 0;
            
            for (i = 0; i < _size; i++)
            {
                rgb8 p = rgb->data[i];
                _acc[i] += (unsigned int)((p.r + p.g + p.b) / 3);
            }
        }
        
        else
        {
            [self stop];
            [self buildReferenceFrame];
        }
        
        rgb8ifree(rgb);
    }
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didDropSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
    
}

- (void)dealloc
{
    free(_acc);
}

@end
