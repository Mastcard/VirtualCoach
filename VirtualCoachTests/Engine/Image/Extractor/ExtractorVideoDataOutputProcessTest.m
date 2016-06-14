//
//  ExtractorVideoDataOutputProcessTest.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 18/05/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <CoreMedia/CoreMedia.h>
#import "ExtractorVideoDataOutputProcess.h"
#import "ExtractorVideoDataOutputDelegate.h"

#include <io.h>

@interface ExtractorVDOP : NSObject <ExtractorVideoDataOutputDelegate>

@property (nonatomic, strong) NSString *extractedImageDir;

@property (nonatomic) NSUInteger count;

@property (nonatomic) int comparisonCount;

@end

@implementation ExtractorVDOP

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        _count = 0;
        _comparisonCount = 0;
    }
    
    return self;
}

- (void)didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer
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
    
    rgb8i_t *rgb = rgb8iallocwd_bgra((uint16_t)width, (uint16_t)height, myPixelBuf);
    free(myPixelBuf);
    
    NSString *imagePath = [_extractedImageDir stringByAppendingPathComponent:[NSString stringWithFormat:@"out%03d.ppm", (int)_count]];
    
    rgb8i_t *extractedRgb = ppmopen([imagePath cStringUsingEncoding:NSASCIIStringEncoding]);
    
    int comparison = rgb8icmp(rgb, extractedRgb);
    
    _comparisonCount += comparison;
    
    rgb8ifree(rgb);
    rgb8ifree(extractedRgb);
}

- (void)didEstimateFrameCount:(Float64)frameCount
{
    
}

@end

@interface ExtractorVideoDataOutputProcessTest : XCTestCase

@property (nonatomic, strong) NSMutableDictionary *videoInfo;
@property (nonatomic, strong) NSString *videoPath;

@property (nonatomic, strong) ExtractorVDOP *extractorDelegate;
@property (nonatomic, strong) ExtractorVideoDataOutputProcess *extractorVideoDataOutputProcess;

@end

@implementation ExtractorVideoDataOutputProcessTest

- (void)setUp {
    [super setUp];
    
    _extractorDelegate = [[ExtractorVDOP alloc] init];
    [_extractorDelegate setExtractedImageDir:[[[NSBundle bundleForClass:[self class]] resourcePath] stringByAppendingString:@"/Engine/Image/Extractor/extracted"]];
    
    _videoPath = [[[NSBundle bundleForClass:[self class]] resourcePath] stringByAppendingString:@"/Engine/Image/Extractor/ExtractorVideoDataOutputProcessVideoTest.mov"];
    
    _extractorVideoDataOutputProcess = [[ExtractorVideoDataOutputProcess alloc] initWithFile:_videoPath];
    [_extractorVideoDataOutputProcess setDelegate:_extractorDelegate];
    
    [_extractorVideoDataOutputProcess setup];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExtractorAndSampleCount
{
    [_extractorVideoDataOutputProcess start];
    
    XCTAssertEqual([_extractorVideoDataOutputProcess estimatedFrameCount], 30);
    XCTAssertEqual([_extractorDelegate comparisonCount], 0);
}

@end
