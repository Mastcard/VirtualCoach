//
//  KmeanEntryDataSetTest.m
//  VirtualCoach
//
//  Created by Bi ZORO on 05/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "KmeanEntryDataSet.h"

@interface KmeanEntryDataSetTest : XCTestCase

@property (nonatomic) KmeanEntryDataSet * datasetEntry;

@end

@implementation KmeanEntryDataSetTest

- (void)setUp {
    [super setUp];
    _datasetEntry = [[KmeanEntryDataSet alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

/*
 This test generate 4 KmeanEntry, add them to the KmeanEntryDataSet and check if all values add are at the correct place and their values are correct.
 */
- (void)testaddKmeanEntryToDataSet {
    
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
            speedVectors0[PXL_IDX(width, i, j)].u =0;
            speedVectors0[PXL_IDX(width, i, j)].v =50;
            speedVectors1[PXL_IDX(width, i, j)].u =-200;
            speedVectors1[PXL_IDX(width, i, j)].v =0;
            speedVectors2[PXL_IDX(width, i, j)].u =-550;
            speedVectors2[PXL_IDX(width, i, j)].v =0;
            speedVectors3[PXL_IDX(width, i, j)].u =-1000;
            speedVectors3[PXL_IDX(width, i, j)].v =0;
            speedVectors4[PXL_IDX(width, i, j)].u =1400;
            speedVectors4[PXL_IDX(width, i, j)].v =0;
        }
    }
    
    [_datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors0 andSecondSpeedVectorsTab:speedVectors1 betweenInterval:interval andWithImageWidth:width];
    [_datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors1 andSecondSpeedVectorsTab:speedVectors2 betweenInterval:interval andWithImageWidth:width];
    [_datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors2 andSecondSpeedVectorsTab:speedVectors3 betweenInterval:interval andWithImageWidth:width];
    [_datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors3 andSecondSpeedVectorsTab:speedVectors4 betweenInterval:interval andWithImageWidth:width];
    
    XCTAssertEqual((unsigned int)_datasetEntry.datacount, 4);
    
    XCTAssertEqual((unsigned int)[[_datasetEntry.data objectAtIndex:0] time], 1);
    XCTAssertEqual((unsigned int)[[_datasetEntry.data objectAtIndex:0] maxAngle], 180);
    XCTAssertEqual((double)[[_datasetEntry.data objectAtIndex:0] meanAcceleration], 540000.000000);

    XCTAssertEqual((unsigned int)[[_datasetEntry.data objectAtIndex:1] time], 2);
    XCTAssertEqual((unsigned int)[[_datasetEntry.data objectAtIndex:1] maxAngle], 180);
    XCTAssertEqual((double)[[_datasetEntry.data objectAtIndex:1] meanAcceleration], 1260000.000000);

    XCTAssertEqual((unsigned int)[[_datasetEntry.data objectAtIndex:2] time], 3);
    XCTAssertEqual((unsigned int)[[_datasetEntry.data objectAtIndex:2] maxAngle], 180);
    XCTAssertEqual((double)[[_datasetEntry.data objectAtIndex:2] meanAcceleration], 1620000.000000);

    XCTAssertEqual((unsigned int)[[_datasetEntry.data objectAtIndex:3] time], 4);
    XCTAssertEqual((unsigned int)[[_datasetEntry.data objectAtIndex:3] maxAngle], 0);
    XCTAssertEqual((double)[[_datasetEntry.data objectAtIndex:3] meanAcceleration], 1440000.000000);

    
}

/*
 This test generate 4 KmeanEntry, add them to the KmeanEntryDataSet, save the KmeanEntryDataSet generate in one file and load all values save in one new KmeanEntryDataSet and check if all values add are at the correct place and their values are correct.
 */
- (void)testIOKmeanEntryDataSet {
    NSString * filePathKmeanEntryDataset = @"/Users/bizoro/Documents/master2/Projet_Synthese/VirtualCoach/KmeanEntryDataSetTest.plist";
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
            speedVectors0[PXL_IDX(width, i, j)].u =0;
            speedVectors0[PXL_IDX(width, i, j)].v =50;
            speedVectors1[PXL_IDX(width, i, j)].u =-200;
            speedVectors1[PXL_IDX(width, i, j)].v =0;
            speedVectors2[PXL_IDX(width, i, j)].u =-550;
            speedVectors2[PXL_IDX(width, i, j)].v =0;
            speedVectors3[PXL_IDX(width, i, j)].u =-1000;
            speedVectors3[PXL_IDX(width, i, j)].v =0;
            speedVectors4[PXL_IDX(width, i, j)].u =1400;
            speedVectors4[PXL_IDX(width, i, j)].v =0;
        }
    }
    
    [_datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors0 andSecondSpeedVectorsTab:speedVectors1 betweenInterval:interval andWithImageWidth:width];
    [_datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors1 andSecondSpeedVectorsTab:speedVectors2 betweenInterval:interval andWithImageWidth:width];
    [_datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors2 andSecondSpeedVectorsTab:speedVectors3 betweenInterval:interval andWithImageWidth:width];
    [_datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors3 andSecondSpeedVectorsTab:speedVectors4 betweenInterval:interval andWithImageWidth:width];
    
    [_datasetEntry writeKmeanDatasetAtPath:filePathKmeanEntryDataset];
    
    KmeanEntryDataSet * result = [KmeanEntryDataSet loadKmeanDatasetAtPath:filePathKmeanEntryDataset];
    
    
    XCTAssertEqual((unsigned int)result.datacount, 4);
    
    XCTAssertEqual((unsigned int)[[result.data objectAtIndex:0] time], 1);
    XCTAssertEqual((unsigned int)[[result.data objectAtIndex:0] maxAngle], 180);
    XCTAssertEqual((double)[[result.data objectAtIndex:0] meanAcceleration], 540000.000000);
    
    XCTAssertEqual((unsigned int)[[result.data objectAtIndex:1] time], 2);
    XCTAssertEqual((unsigned int)[[result.data objectAtIndex:1] maxAngle], 180);
    XCTAssertEqual((double)[[result.data objectAtIndex:1] meanAcceleration], 1260000.000000);
    
    XCTAssertEqual((unsigned int)[[result.data objectAtIndex:2] time], 3);
    XCTAssertEqual((unsigned int)[[result.data objectAtIndex:2] maxAngle], 180);
    XCTAssertEqual((double)[[result.data objectAtIndex:2] meanAcceleration], 1620000.000000);
    
    XCTAssertEqual((unsigned int)[[result.data objectAtIndex:3] time], 4);
    XCTAssertEqual((unsigned int)[[result.data objectAtIndex:3] maxAngle], 0);
    XCTAssertEqual((double)[[result.data objectAtIndex:3] meanAcceleration], 1440000.000000);
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
