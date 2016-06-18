//
//  TrackingAnalysisProcessTest.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 18/05/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "TrackingAnalysisProcess.h"
#import "ExtractorVideoDataOutputProcess.h"

@interface TrackingAnalysisProcessTest : XCTestCase

@property (nonatomic, strong) TrackingAnalysisProcess *analysisProcess;
@property (nonatomic, strong) ExtractorVideoDataOutputProcess *extractorProcess;

@end

@implementation TrackingAnalysisProcessTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testPartialSequencesOnMovingSquareWithImageMotionFactor2
{
    NSString *videoPath = [[[NSBundle bundleForClass:[self class]] resourcePath] stringByAppendingString:@"/Engine/Process/TrackingAnalysisProcess/TrackingAnalysisProcessTest-movingquare.mov"];
    NSString *referenceFramePath = [[[NSBundle bundleForClass:[self class]] resourcePath] stringByAppendingString:@"/Engine/Process/TrackingAnalysisProcess/TrackingAnalysisProcessTest-movingquare-reference.pgm"];
    NSString *videoInfoPath = [[[NSBundle bundleForClass:[self class]] resourcePath] stringByAppendingString:@"/Engine/Process/TrackingAnalysisProcess/TrackingAnalysisProcessTest-movingquare-data.plist"];
    
    NSMutableDictionary *videoInfo = [NSMutableDictionary dictionaryWithContentsOfFile:videoInfoPath];
    
    [videoInfo setObject:videoPath forKey:@"videoPath"];
    [videoInfo setObject:referenceFramePath forKey:@"referenceFramePath"];
    
    _extractorProcess = [[ExtractorVideoDataOutputProcess alloc] initWithFile:videoPath];
    _analysisProcess = [[TrackingAnalysisProcess alloc] initWithDictionary:videoInfo];
    
    _analysisProcess.scale = 1;
    _analysisProcess.skippedFrameCount = 1;
    _analysisProcess.motionImageFactor = 2;
    _analysisProcess.overlappingRate = 0.6;
    
    [_extractorProcess setDelegate:_analysisProcess];
    
    [_extractorProcess setup];
    [_analysisProcess setup];
    
    [_extractorProcess start];
    
    NSDictionary *motionData = [_analysisProcess motionData];
    
    NSArray *motionsExpectedResults = @[@(0), @(-1), @(1), @(-1), @(1), @(-1), @(1), @(-1), @(1), @(-1), @(1), @(-1), @(1), @(-1), @(1), @(-1), @(1), @(-1), @(1), @(-1), @(1), @(-1), @(1), @(-1), @(1), @(-1), @(1), @(-1), @(1), @(-1), @(1), @(-1), @(1), @(-1), @(1), @(-1), @(1), @(-1), @(1), @(-1), @(1), @(-1), @(1), @(-1), @(1), @(-1), @(1), @(-1), @(1), @(-1), @(1), @(-1), @(1), @(-1), @(1), @(-1), @(1), @(-1), @(1), @(-1), @(1), @(-1), @(1), @(-1), @(1), @(-1), @(1), @(-1), @(1), @(-1), @(1), @(-1), @(1), @(-1), @(1), @(-1), @(1), @(-1), @(1), @(-1), @(1), @(-1), @(1), @(-1), @(1), @(-1), @(1), @(-1), @(1), @(-1), @(1), @(-1), @(1), @(-1), @(1), @(-1), @(1), @(-1), @(1), @(-1), @(1), @(-1), @(1), @(-1), @(1), @(-1), @(1), @(-1), @(1), @(-1), @(1), @(-1), @(1), @(-1), @(1), @(-1), @(1), @(-1), @(1), @(-1), @(1)];
    
    NSArray *objectsMotion = (NSArray *)[motionData objectForKey:@"objectsMotion"];
    
    XCTAssertEqual([objectsMotion isEqualToArray:motionsExpectedResults], YES);
}

- (void)testPartialSequencesOnMovingSquareWithImageMotionFactor5
{
    NSString *videoPath = [[[NSBundle bundleForClass:[self class]] resourcePath] stringByAppendingString:@"/Engine/Process/TrackingAnalysisProcess/TrackingAnalysisProcessTest-movingquare.mov"];
    NSString *referenceFramePath = [[[NSBundle bundleForClass:[self class]] resourcePath] stringByAppendingString:@"/Engine/Process/TrackingAnalysisProcess/TrackingAnalysisProcessTest-movingquare-reference.pgm"];
    NSString *videoInfoPath = [[[NSBundle bundleForClass:[self class]] resourcePath] stringByAppendingString:@"/Engine/Process/TrackingAnalysisProcess/TrackingAnalysisProcessTest-movingquare-data.plist"];
    
    NSMutableDictionary *videoInfo = [NSMutableDictionary dictionaryWithContentsOfFile:videoInfoPath];
    
    [videoInfo setObject:videoPath forKey:@"videoPath"];
    [videoInfo setObject:referenceFramePath forKey:@"referenceFramePath"];
    
    _extractorProcess = [[ExtractorVideoDataOutputProcess alloc] initWithFile:videoPath];
    _analysisProcess = [[TrackingAnalysisProcess alloc] initWithDictionary:videoInfo];
    
    _analysisProcess.scale = 1;
    _analysisProcess.skippedFrameCount = 1;
    _analysisProcess.motionImageFactor = 5;
    _analysisProcess.overlappingRate = 0.6;
    
    [_extractorProcess setDelegate:_analysisProcess];
    
    [_extractorProcess setup];
    [_analysisProcess setup];
    
    [_extractorProcess start];
    
    NSDictionary *motionData = [_analysisProcess motionData];
    
    NSArray *motionsExpectedResults = @[@(0), @(-1), @(-1), @(-1), @(-1), @(1), @(-1), @(-1), @(-1), @(-1), @(1), @(-1), @(-1), @(-1), @(-1), @(1), @(-1), @(-1), @(-1), @(-1), @(1), @(-1), @(-1), @(-1), @(-1), @(1), @(-1), @(-1), @(-1), @(-1), @(1), @(-1), @(-1), @(-1), @(-1), @(1), @(-1), @(-1), @(-1), @(-1), @(1), @(-1), @(-1), @(-1), @(-1), @(1), @(-1), @(-1), @(-1), @(-1), @(1), @(-1), @(-1), @(-1), @(-1), @(0), @(-1), @(-1), @(-1), @(-1), @(1), @(-1), @(-1), @(-1), @(-1), @(1), @(-1), @(-1), @(-1), @(-1), @(1), @(-1), @(-1), @(-1), @(-1), @(0), @(-1), @(-1), @(-1), @(-1), @(0), @(-1), @(-1), @(-1), @(-1), @(1), @(-1), @(-1), @(-1), @(-1), @(1), @(-1), @(-1), @(-1), @(-1), @(1), @(-1), @(-1), @(-1), @(-1), @(1), @(-1), @(-1), @(-1), @(-1), @(0), @(-1), @(-1), @(-1), @(-1), @(0), @(-1), @(-1), @(-1), @(-1), @(1), @(-1), @(-1), @(-1), @(-1), @(1)];
    
    NSArray *objectsMotion = (NSArray *)[motionData objectForKey:@"objectsMotion"];
    
    XCTAssertEqual([objectsMotion isEqualToArray:motionsExpectedResults], YES);
}

- (void)testPartialSequencesOnMovingSquareWithImageMotionFactor10
{
    NSString *videoPath = [[[NSBundle bundleForClass:[self class]] resourcePath] stringByAppendingString:@"/Engine/Process/TrackingAnalysisProcess/TrackingAnalysisProcessTest-movingquare.mov"];
    NSString *referenceFramePath = [[[NSBundle bundleForClass:[self class]] resourcePath] stringByAppendingString:@"/Engine/Process/TrackingAnalysisProcess/TrackingAnalysisProcessTest-movingquare-reference.pgm"];
    NSString *videoInfoPath = [[[NSBundle bundleForClass:[self class]] resourcePath] stringByAppendingString:@"/Engine/Process/TrackingAnalysisProcess/TrackingAnalysisProcessTest-movingquare-data.plist"];
    
    NSMutableDictionary *videoInfo = [NSMutableDictionary dictionaryWithContentsOfFile:videoInfoPath];
    
    [videoInfo setObject:videoPath forKey:@"videoPath"];
    [videoInfo setObject:referenceFramePath forKey:@"referenceFramePath"];
    
    _extractorProcess = [[ExtractorVideoDataOutputProcess alloc] initWithFile:videoPath];
    _analysisProcess = [[TrackingAnalysisProcess alloc] initWithDictionary:videoInfo];
    
    _analysisProcess.scale = 1;
    _analysisProcess.skippedFrameCount = 1;
    _analysisProcess.motionImageFactor = 10;
    _analysisProcess.overlappingRate = 0.6;
    
    [_extractorProcess setDelegate:_analysisProcess];
    
    [_extractorProcess setup];
    [_analysisProcess setup];
    
    [_extractorProcess start];
    
    NSDictionary *motionData = [_analysisProcess motionData];
    
    
    NSArray *motionsExpectedResults = @[@(0), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(0), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(0), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(0), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(1)];
    
    NSArray *objectsMotion = (NSArray *)[motionData objectForKey:@"objectsMotion"];
    
    XCTAssertEqual([objectsMotion isEqualToArray:motionsExpectedResults], YES);
}

@end
