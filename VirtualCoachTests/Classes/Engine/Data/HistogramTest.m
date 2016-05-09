//
//  HistogramTest.m
//  VirtualCoach
//
//  Created by Bi ZORO on 02/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Histogram.h"

@interface HistogramTest : XCTestCase

@property (nonatomic) Histogram * angleHistogram;

@end

@implementation HistogramTest

- (void)setUp {
    [super setUp];
    _angleHistogram=[[Histogram alloc] init];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}
/*
 Generate an histogram of angle by using five tables of speeds.
 The first, the third and the fourth table of speed generate 10800 hit of angle 180 (speed.x < 0 and speed.y = 0)
 The second table of speed generate 3600 hit of angle 0 (speed.x > 0 and speed.y = 0)
 The last table of speed generate 3600 hit of angle 270 (speed.x = 0 and speed.y > 0)
 So in the histogram we have 3600 hits of angle 0, 3600 hits of angle 270, 10800 hits of angle 180
 */
- (void)testGenerateHistogramFromSpeedVector {
    
    rect_t interval;
    uint16_t width= 100;
    interval.start.x = 30;
    interval.start.y = 30;
    interval.end.x = 90;
    interval.end.y = 90;
    speedVector * speedVectors0 = (speedVector *) calloc(10000, sizeof(speedVector));
    speedVector * speedVectors1 = (speedVector *) calloc(10000, sizeof(speedVector));
    speedVector * speedVectors2 = (speedVector *) calloc(10000, sizeof(speedVector));
    speedVector * speedVectors3 = (speedVector *) calloc(10000, sizeof(speedVector));
    speedVector * speedVectors4 = (speedVector *) calloc(10000, sizeof(speedVector));
    int i =0;
    for (i=0; i<10000; i++) {
        speedVectors0[i].u =0;
        speedVectors0[i].v =0;
        speedVectors1[i].u =0;
        speedVectors1[i].v =0;
        speedVectors2[i].u =0;
        speedVectors2[i].v =0;
        speedVectors3[i].u =0;
        speedVectors3[i].v =0;
        speedVectors4[i].u =0;
        speedVectors4[i].v =0;
    }
    int j=0;
    for (i=interval.start.y; i<interval.end.y; i++) {
        for (j=interval.start.x; j<interval.end.x; j++) {
            speedVectors0[PXL_IDX(width, i, j)].u =-200;
            speedVectors0[PXL_IDX(width, i, j)].v =0;
            speedVectors1[PXL_IDX(width, i, j)].u =200;
            speedVectors1[PXL_IDX(width, i, j)].v =0;
            speedVectors2[PXL_IDX(width, i, j)].u =-200;
            speedVectors2[PXL_IDX(width, i, j)].v =0;
            speedVectors3[PXL_IDX(width, i, j)].u =-200;
            speedVectors3[PXL_IDX(width, i, j)].v =0;
            speedVectors4[PXL_IDX(width, i, j)].u =0;
            speedVectors4[PXL_IDX(width, i, j)].v =200;
        }
    }
    [_angleHistogram generateHistogramFromSpeedVector:speedVectors0 betweenInterval:interval andWithImageWidth:width];
    [_angleHistogram generateHistogramFromSpeedVector:speedVectors1 betweenInterval:interval andWithImageWidth:width];
    [_angleHistogram generateHistogramFromSpeedVector:speedVectors2 betweenInterval:interval andWithImageWidth:width];
    [_angleHistogram generateHistogramFromSpeedVector:speedVectors3 betweenInterval:interval andWithImageWidth:width];
    [_angleHistogram generateHistogramFromSpeedVector:speedVectors4 betweenInterval:interval andWithImageWidth:width];
    
    for (NSInteger k=0; k<_angleHistogram.data.count; k++) {
        
        if (k==180) {
            XCTAssertEqual([[_angleHistogram.data objectAtIndex:k] intValue], 10800);
        }
        else if(k==0){
            XCTAssertEqual([[_angleHistogram.data objectAtIndex:k] intValue], 3600);
        }
        else if(k==270){
            XCTAssertEqual([[_angleHistogram.data objectAtIndex:k] intValue], 3600);
        }
        else{
            XCTAssertEqual([[_angleHistogram.data objectAtIndex:k] intValue], 0);
        }
    }
}

/*
 Generate an histogram of angle by using five tables of speeds. Save this histogram in a file and then oad this histogram in new object histogram and we check that the value saved stay the same
 The first, the third and the fourth table of speed generate 10800 hit of angle 180 (speed.x < 0 and speed.y = 0)
 The second table of speed generate 3600 hit of angle 0 (speed.x > 0 and speed.y = 0)
 The last table of speed generate 3600 hit of angle 270 (speed.x = 0 and speed.y > 0)
 So in the histogram we have 3600 hits of angle 0, 3600 hits of angle 270, 10800 hits of angle 180
 */
- (void)testIOHistogram{
    NSString * filePathHistogram = @"/Users/bizoro/Documents/master2/Projet_Synthese/VirtualCoach/histogramTest.plist";
    
    rect_t interval;
    uint16_t width= 100;
    interval.start.x = 30;
    interval.start.y = 30;
    interval.end.x = 90;
    interval.end.y = 90;
    speedVector * speedVectors0 = (speedVector *) calloc(10000, sizeof(speedVector));
    speedVector * speedVectors1 = (speedVector *) calloc(10000, sizeof(speedVector));
    speedVector * speedVectors2 = (speedVector *) calloc(10000, sizeof(speedVector));
    speedVector * speedVectors3 = (speedVector *) calloc(10000, sizeof(speedVector));
    speedVector * speedVectors4 = (speedVector *) calloc(10000, sizeof(speedVector));
    int i =0;
    for (i=0; i<10000; i++) {
        speedVectors0[i].u =0;
        speedVectors0[i].v =0;
        speedVectors1[i].u =0;
        speedVectors1[i].v =0;
        speedVectors2[i].u =0;
        speedVectors2[i].v =0;
        speedVectors3[i].u =0;
        speedVectors3[i].v =0;
        speedVectors4[i].u =0;
        speedVectors4[i].v =0;
    }
    int j=0;
    for (i=interval.start.y; i<interval.end.y; i++) {
        for (j=interval.start.x; j<interval.end.x; j++) {
            speedVectors0[PXL_IDX(width, i, j)].u =-200;
            speedVectors0[PXL_IDX(width, i, j)].v =0;
            speedVectors1[PXL_IDX(width, i, j)].u =200;
            speedVectors1[PXL_IDX(width, i, j)].v =0;
            speedVectors2[PXL_IDX(width, i, j)].u =-200;
            speedVectors2[PXL_IDX(width, i, j)].v =0;
            speedVectors3[PXL_IDX(width, i, j)].u =-200;
            speedVectors3[PXL_IDX(width, i, j)].v =0;
            speedVectors4[PXL_IDX(width, i, j)].u =0;
            speedVectors4[PXL_IDX(width, i, j)].v =200;
        }
    }
    [_angleHistogram generateHistogramFromSpeedVector:speedVectors0 betweenInterval:interval andWithImageWidth:width];
    [_angleHistogram generateHistogramFromSpeedVector:speedVectors1 betweenInterval:interval andWithImageWidth:width];
    [_angleHistogram generateHistogramFromSpeedVector:speedVectors2 betweenInterval:interval andWithImageWidth:width];
    [_angleHistogram generateHistogramFromSpeedVector:speedVectors3 betweenInterval:interval andWithImageWidth:width];
    [_angleHistogram generateHistogramFromSpeedVector:speedVectors4 betweenInterval:interval andWithImageWidth:width];
    
    
    [_angleHistogram writeHistogramAtPath:filePathHistogram];
    
    Histogram * result = [Histogram loadHistogramAtPath:filePathHistogram];
    for (NSInteger j=0; j<result.data.count; j++){
        
        if (j==180) {
            XCTAssertEqual([[result.data objectAtIndex:j] intValue], 10800);
        }
        else if(j==0){
            XCTAssertEqual([[result.data objectAtIndex:j] intValue], 3600);
        }
        else if(j==270){
            XCTAssertEqual([[result.data objectAtIndex:j] intValue], 3600);
        }
        else{
            XCTAssertEqual([[result.data objectAtIndex:j] intValue], 0);
        }
    }
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
