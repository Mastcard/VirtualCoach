//
//  MotionDeductionTest.m
//  VirtualCoach
//
//  Created by Bi ZORO on 09/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MotionDeduction.h"

@interface MotionDeductionTest : XCTestCase

@end

@implementation MotionDeductionTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

/*
 This test uses four histograms:
    - one histogram with maximum hits on 180°
    - one histogram with maximum hits on 0°
    - one histogram with maximum hits on 270°
    - one histogram with maximum hits on 90°
 
 */
- (void)testRecognizeMotionWithHistogram {
    
    Histogram * histogramBackhand = [[Histogram alloc] init];
    Histogram * histogramForehand = [[Histogram alloc] init];
    Histogram * histogramServe = [[Histogram alloc] init];
    Histogram * histogramUnknown = [[Histogram alloc] init];
    histogramBackhand.data [0] = @([[histogramBackhand.data objectAtIndex:0]intValue] + 3600);
    histogramBackhand.data [180] = @([[histogramBackhand.data objectAtIndex:180]intValue] + 10800);
    histogramBackhand.data [270] = @([[histogramBackhand.data objectAtIndex:270]intValue] + 3600);
    
    histogramForehand.data [0] = @([[histogramForehand.data objectAtIndex:0]intValue] + 10800);
    histogramForehand.data [180] = @([[histogramForehand.data objectAtIndex:180]intValue] + 3600);
    histogramForehand.data [270] = @([[histogramForehand.data objectAtIndex:270]intValue] + 3600);
    
    histogramServe.data [0] = @([[histogramServe.data objectAtIndex:0]intValue] + 3600);
    histogramServe.data [180] = @([[histogramServe.data objectAtIndex:180]intValue] + 3600);
    histogramServe.data [270] = @([[histogramServe.data objectAtIndex:270]intValue] + 10800);
    
    histogramUnknown.data [90] = @([[histogramUnknown.data objectAtIndex:90]intValue] + 3600);
    
    NSString* resultBackhandRightHanded= [MotionDeduction recognizeTennisMotionWithHistogram:histogramBackhand andLeftHanded:false];
    NSString* resultForehandRightHanded= [MotionDeduction recognizeTennisMotionWithHistogram:histogramForehand andLeftHanded:false];
    NSString* resultBackhandLeftHanded= [MotionDeduction recognizeTennisMotionWithHistogram:histogramForehand andLeftHanded:true];
    NSString* resultForehandLeftHanded= [MotionDeduction recognizeTennisMotionWithHistogram:histogramBackhand andLeftHanded:true];
    NSString* resultServe= [MotionDeduction recognizeTennisMotionWithHistogram:histogramServe andLeftHanded:false];
    NSString* resultUnknown= [MotionDeduction recognizeTennisMotionWithHistogram:histogramUnknown andLeftHanded:false];
    
    XCTAssertEqual([resultBackhandRightHanded isEqualToString:@"backhand"], YES);
    XCTAssertEqual([resultForehandRightHanded isEqualToString:@"forehand"], YES);
    XCTAssertEqual([resultBackhandLeftHanded isEqualToString:@"backhand"], YES);
    XCTAssertEqual([resultForehandLeftHanded isEqualToString:@"forehand"], YES);
    XCTAssertEqual([resultServe isEqualToString:@"serve"], YES);
    XCTAssertEqual([resultUnknown isEqualToString:@"Motion not recognized 90°:3600"], YES);
}

- (void)testCompareHistogram{


    Histogram * histogramBackhandRightHanded = [[Histogram alloc] init];
    Histogram * histogramForehandRightHanded = [[Histogram alloc] init];
    Histogram * histogramServeRightHanded = [[Histogram alloc] init];
    
    Histogram * histogramBackhandLeftHanded = [[Histogram alloc] init];
    Histogram * histogramForehandLeftHanded = [[Histogram alloc] init];
    
    histogramBackhandRightHanded.data [0] = @([[histogramBackhandRightHanded.data objectAtIndex:0]intValue] + 3600);
    histogramBackhandRightHanded.data [180] = @([[histogramBackhandRightHanded.data objectAtIndex:180]intValue] + 10800);
    histogramBackhandRightHanded.data [270] = @([[histogramBackhandRightHanded.data objectAtIndex:270]intValue] + 3600);
    
    histogramForehandRightHanded.data [0] = @([[histogramForehandRightHanded.data objectAtIndex:0]intValue] + 10800);
    histogramForehandRightHanded.data [180] = @([[histogramForehandRightHanded.data objectAtIndex:180]intValue] + 3600);
    histogramForehandRightHanded.data [270] = @([[histogramForehandRightHanded.data objectAtIndex:270]intValue] + 3600);
    
    histogramServeRightHanded.data [0] = @([[histogramServeRightHanded.data objectAtIndex:0]intValue] + 3600);
    histogramServeRightHanded.data [180] = @([[histogramServeRightHanded.data objectAtIndex:180]intValue] + 3600);
    histogramServeRightHanded.data [270] = @([[histogramServeRightHanded.data objectAtIndex:270]intValue] + 10800);
    
    histogramBackhandLeftHanded.data [0] = @([[histogramBackhandLeftHanded.data objectAtIndex:0]intValue] + 10800);
    histogramBackhandLeftHanded.data [180] = @([[histogramBackhandLeftHanded.data objectAtIndex:180]intValue] + 3600);
    histogramBackhandLeftHanded.data [270] = @([[histogramBackhandLeftHanded.data objectAtIndex:270]intValue] + 3600);
    
    histogramForehandLeftHanded.data [0] = @([[histogramForehandLeftHanded.data objectAtIndex:0]intValue] + 3600);
    histogramForehandLeftHanded.data [180] = @([[histogramForehandLeftHanded.data objectAtIndex:180]intValue] + 10800);
    histogramForehandLeftHanded.data [270] = @([[histogramForehandLeftHanded.data objectAtIndex:270]intValue] + 3600);

    NSString *filePathHistogramBackhandRefRightHanded = [[[NSBundle bundleForClass:[self class]] resourcePath] stringByAppendingString:@"/Engine/Data/Histograms/histogramBackhandRefRightHanded.plist"];
    NSString *filePathHistogramForehandRefRightHanded = [[[NSBundle bundleForClass:[self class]] resourcePath] stringByAppendingString:@"/Engine/Data/Histograms/histogramForehandRefRightHanded.plist"];
    NSString *filePathHistogramServeRefRightHanded = [[[NSBundle bundleForClass:[self class]] resourcePath] stringByAppendingString:@"/Engine/Data/Histograms/histogramServeRefRightHanded.plist"];
    NSString *filePathHistogramBackhandRefLeftHanded = [[[NSBundle bundleForClass:[self class]] resourcePath] stringByAppendingString:@"/Engine/Data/Histograms/histogramBackhandRefLeftHanded.plist"];
    NSString *filePathHistogramForehandRefLeftHanded = [[[NSBundle bundleForClass:[self class]] resourcePath] stringByAppendingString:@"/Engine/Data/Histograms/histogramForehandRefLeftHanded.plist"];
    
    [histogramBackhandRightHanded writeHistogramAtPath:filePathHistogramBackhandRefRightHanded];
    [histogramForehandRightHanded writeHistogramAtPath:filePathHistogramForehandRefRightHanded];
    [histogramServeRightHanded writeHistogramAtPath:filePathHistogramServeRefRightHanded];
    [histogramBackhandLeftHanded writeHistogramAtPath:filePathHistogramBackhandRefLeftHanded];
    [histogramForehandLeftHanded writeHistogramAtPath:filePathHistogramForehandRefLeftHanded];
    
    NSString* resultBackhandRightHanded = [MotionDeduction compareHistogram:histogramBackhandRightHanded isPlayerLeftHanded:false pathHistogramRef:filePathHistogramBackhandRefRightHanded isCoachLeftHanded:false withThreshold:0];
    NSString* resultForehandRightHanded = [MotionDeduction compareHistogram:histogramForehandRightHanded isPlayerLeftHanded:false pathHistogramRef:filePathHistogramForehandRefRightHanded isCoachLeftHanded:false withThreshold:0];
    NSString* resultServeRightHanded = [MotionDeduction compareHistogram:histogramServeRightHanded isPlayerLeftHanded:false pathHistogramRef:filePathHistogramServeRefRightHanded isCoachLeftHanded:false withThreshold:0];
    NSString* resultBackhandLeftHanded = [MotionDeduction compareHistogram:histogramBackhandLeftHanded isPlayerLeftHanded:true pathHistogramRef:filePathHistogramBackhandRefLeftHanded isCoachLeftHanded:true withThreshold:0];
    NSString* resultForehandLeftHanded = [MotionDeduction compareHistogram:histogramForehandLeftHanded isPlayerLeftHanded:true pathHistogramRef:filePathHistogramForehandRefLeftHanded isCoachLeftHanded:true withThreshold:0];
    
    NSString* resultBackhandRightHandedVsBackhandLeftHanded = [MotionDeduction compareHistogram:histogramBackhandRightHanded isPlayerLeftHanded:false pathHistogramRef:filePathHistogramBackhandRefLeftHanded isCoachLeftHanded:true withThreshold:0];
    NSString* resultForehandRightHandedVsForehandLeftHanded = [MotionDeduction compareHistogram:histogramForehandRightHanded isPlayerLeftHanded:false pathHistogramRef:filePathHistogramForehandRefLeftHanded isCoachLeftHanded:true withThreshold:0];
    
    NSString* resultBackhandLeftHandedVsBackhandRightHanded = [MotionDeduction compareHistogram:histogramBackhandLeftHanded isPlayerLeftHanded:true pathHistogramRef:filePathHistogramBackhandRefRightHanded isCoachLeftHanded:false withThreshold:0];
    NSString* resultForehandLeftHandedVsForehandRightHanded = [MotionDeduction compareHistogram:histogramForehandLeftHanded isPlayerLeftHanded:true pathHistogramRef:filePathHistogramForehandRefRightHanded isCoachLeftHanded:false withThreshold:0];
    
    XCTAssertEqual([resultBackhandRightHanded isEqualToString:@"100"], YES);
    XCTAssertEqual([resultForehandRightHanded isEqualToString:@"100"], YES);
    XCTAssertEqual([resultServeRightHanded isEqualToString:@"100"], YES);
    XCTAssertEqual([resultBackhandLeftHanded isEqualToString:@"100"], YES);
    XCTAssertEqual([resultForehandLeftHanded isEqualToString:@"100"], YES);
    
    XCTAssertEqual([resultBackhandRightHandedVsBackhandLeftHanded isEqualToString:@"100"], YES);
    XCTAssertEqual([resultForehandRightHandedVsForehandLeftHanded isEqualToString:@"100"], YES);
    
    XCTAssertEqual([resultBackhandLeftHandedVsBackhandRightHanded isEqualToString:@"100"], YES);
    XCTAssertEqual([resultForehandLeftHandedVsForehandRightHanded isEqualToString:@"100"], YES);
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
