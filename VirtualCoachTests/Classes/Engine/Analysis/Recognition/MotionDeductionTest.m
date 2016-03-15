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

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
