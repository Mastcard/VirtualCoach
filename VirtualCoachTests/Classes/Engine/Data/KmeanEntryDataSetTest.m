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
    vect2darray_t * speedVectors0 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    vect2darray_t * speedVectors1 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    vect2darray_t * speedVectors2 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    vect2darray_t * speedVectors3 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    vect2darray_t * speedVectors4 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    
    speedVectors0->length=10000;
    speedVectors0->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    speedVectors1->length=10000;
    speedVectors1->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    speedVectors2->length=10000;
    speedVectors2->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    speedVectors3->length=10000;
    speedVectors3->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    speedVectors4->length=10000;
    speedVectors4->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    
    int i =0;
    for (i=0; i<10000; i++) {
        speedVectors0->data[i].x =0;
        speedVectors0->data[i].y =0;
        speedVectors1->data[i].x =0;
        speedVectors1->data[i].y =0;
        speedVectors2->data[i].x =0;
        speedVectors2->data[i].y =0;
        speedVectors3->data[i].x =0;
        speedVectors3->data[i].y =0;
        speedVectors4->data[i].x =0;
        speedVectors4->data[i].y =0;
    }
    int j=0;
    for (i=interval.start.y; i<interval.end.y; i++) {
        for (j=interval.start.x; j<interval.end.x; j++) {
            speedVectors0->data[PXL_IDX(width, i, j)].x =0;
            speedVectors0->data[PXL_IDX(width, i, j)].y =50;
            speedVectors1->data[PXL_IDX(width, i, j)].x =-200;
            speedVectors1->data[PXL_IDX(width, i, j)].y =0;
            speedVectors2->data[PXL_IDX(width, i, j)].x =-550;
            speedVectors2->data[PXL_IDX(width, i, j)].y =0;
            speedVectors3->data[PXL_IDX(width, i, j)].x =-1000;
            speedVectors3->data[PXL_IDX(width, i, j)].y =0;
            speedVectors4->data[PXL_IDX(width, i, j)].x =1400;
            speedVectors4->data[PXL_IDX(width, i, j)].y =0;
        }
    }
    
    [_datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors0 andSecondSpeedVectorsTab:speedVectors1 betweenInterval:interval andWithImageWidth:width];
    [_datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors1 andSecondSpeedVectorsTab:speedVectors2 betweenInterval:interval andWithImageWidth:width];
    [_datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors2 andSecondSpeedVectorsTab:speedVectors3 betweenInterval:interval andWithImageWidth:width];
    [_datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors3 andSecondSpeedVectorsTab:speedVectors4 betweenInterval:interval andWithImageWidth:width];
    
    XCTAssertEqual((int)_datasetEntry.datacount, 4);
    
    XCTAssertEqual((int)[[_datasetEntry.data objectAtIndex:0] time], 3);
    XCTAssertEqual((int)[[_datasetEntry.data objectAtIndex:0] maxAngle], 180);
    XCTAssertEqual((double)[[_datasetEntry.data objectAtIndex:0] meanAcceleration], 150);
    
    XCTAssertEqual((int)[[_datasetEntry.data objectAtIndex:1] time], 4);
    XCTAssertEqual((int)[[_datasetEntry.data objectAtIndex:1] maxAngle], 180);
    XCTAssertEqual((double)[[_datasetEntry.data objectAtIndex:1] meanAcceleration], 350);
    
    XCTAssertEqual((int)[[_datasetEntry.data objectAtIndex:2] time], 5);
    XCTAssertEqual((int)[[_datasetEntry.data objectAtIndex:2] maxAngle], 180);
    XCTAssertEqual((double)[[_datasetEntry.data objectAtIndex:2] meanAcceleration], 450);
    
    XCTAssertEqual((int)[[_datasetEntry.data objectAtIndex:3] time], 6);
    XCTAssertEqual((int)[[_datasetEntry.data objectAtIndex:3] maxAngle], 0);
    XCTAssertEqual((double)[[_datasetEntry.data objectAtIndex:3] meanAcceleration], 400);
    
    
}

/*
 This test generate 4 KmeanEntry, add them to the KmeanEntryDataSet, save the KmeanEntryDataSet generate in one file and load all values save in one new KmeanEntryDataSet and check if all values add are at the correct place and their values are correct.
 */
- (void)testIOKmeanEntryDataSet {
    
    NSString *filePathKmeanEntryDataset = [[[NSBundle bundleForClass:[self class]] resourcePath] stringByAppendingString:@"/Engine/Data/KmeanEntryDataSet/KmeanEntryDataSetTest.plist"];
    
    rect_t interval;
    uint16_t width= 100;
    interval.start.x = 30;
    interval.start.y = 30;
    interval.end.x = 90;
    interval.end.y = 90;
    vect2darray_t * speedVectors0 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    vect2darray_t * speedVectors1 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    vect2darray_t * speedVectors2 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    vect2darray_t * speedVectors3 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    vect2darray_t * speedVectors4 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    
    speedVectors0->length=10000;
    speedVectors0->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    speedVectors1->length=10000;
    speedVectors1->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    speedVectors2->length=10000;
    speedVectors2->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    speedVectors3->length=10000;
    speedVectors3->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    speedVectors4->length=10000;
    speedVectors4->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    
    int i =0;
    for (i=0; i<10000; i++) {
        speedVectors0->data[i].x =0;
        speedVectors0->data[i].y =0;
        speedVectors1->data[i].x =0;
        speedVectors1->data[i].y =0;
        speedVectors2->data[i].x =0;
        speedVectors2->data[i].y =0;
        speedVectors3->data[i].x =0;
        speedVectors3->data[i].y =0;
        speedVectors4->data[i].x =0;
        speedVectors4->data[i].y =0;
    }
    int j=0;
    for (i=interval.start.y; i<interval.end.y; i++) {
        for (j=interval.start.x; j<interval.end.x; j++) {
            speedVectors0->data[PXL_IDX(width, i, j)].x =0;
            speedVectors0->data[PXL_IDX(width, i, j)].y =50;
            speedVectors1->data[PXL_IDX(width, i, j)].x =-200;
            speedVectors1->data[PXL_IDX(width, i, j)].y =0;
            speedVectors2->data[PXL_IDX(width, i, j)].x =-550;
            speedVectors2->data[PXL_IDX(width, i, j)].y =0;
            speedVectors3->data[PXL_IDX(width, i, j)].x =-1000;
            speedVectors3->data[PXL_IDX(width, i, j)].y =0;
            speedVectors4->data[PXL_IDX(width, i, j)].x =1400;
            speedVectors4->data[PXL_IDX(width, i, j)].y =0;
        }
    }
    
    [_datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors0 andSecondSpeedVectorsTab:speedVectors1 betweenInterval:interval andWithImageWidth:width];
    [_datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors1 andSecondSpeedVectorsTab:speedVectors2 betweenInterval:interval andWithImageWidth:width];
    [_datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors2 andSecondSpeedVectorsTab:speedVectors3 betweenInterval:interval andWithImageWidth:width];
    [_datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors3 andSecondSpeedVectorsTab:speedVectors4 betweenInterval:interval andWithImageWidth:width];
    
    [_datasetEntry writeKmeanDatasetAtPath:filePathKmeanEntryDataset];
    
    KmeanEntryDataSet * result = [KmeanEntryDataSet loadKmeanDatasetAtPath:filePathKmeanEntryDataset];
    
    
    XCTAssertEqual((int)result.datacount, 4);
    
    XCTAssertEqual((int)[[result.data objectAtIndex:0] time], 3);
    XCTAssertEqual((int)[[result.data objectAtIndex:0] maxAngle], 180);
    XCTAssertEqual((double)[[result.data objectAtIndex:0] meanAcceleration], 150);
    
    XCTAssertEqual((int)[[result.data objectAtIndex:1] time], 4);
    XCTAssertEqual((int)[[result.data objectAtIndex:1] maxAngle], 180);
    XCTAssertEqual((double)[[result.data objectAtIndex:1] meanAcceleration], 350);
    
    XCTAssertEqual((int)[[result.data objectAtIndex:2] time], 5);
    XCTAssertEqual((int)[[result.data objectAtIndex:2] maxAngle], 180);
    XCTAssertEqual((double)[[result.data objectAtIndex:2] meanAcceleration], 450);
    
    XCTAssertEqual((int)[[result.data objectAtIndex:3] time], 6);
    XCTAssertEqual((int)[[result.data objectAtIndex:3] maxAngle], 0);
    XCTAssertEqual((double)[[result.data objectAtIndex:3] meanAcceleration], 400);
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
