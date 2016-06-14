//
//  TrackingIrrelevantSequencesRemoverTest.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 14/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TrackingIrrelevantSequencesRemover.h"

@interface TrackingIrrelevantSequencesRemoverTest : XCTestCase

@property (nonatomic, strong) TrackingIrrelevantSequencesRemover *remover;

@end

@implementation TrackingIrrelevantSequencesRemoverTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testOnCompleteSequence
{
    NSArray *motions = @[ @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(1), @(1), @(1), @(1), @(1), @(1), @(1), @(1), @(1), @(1), @(1), @(1), @(1), @(1), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(1), @(1), @(1), @(1), @(1), @(1), @(1), @(1), @(1), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0)];
    
    NSArray *motionsReference = @[ @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(1), @(1), @(1), @(1), @(1), @(1), @(1), @(1), @(1), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0), @(0)];
    
    NSMutableArray *motionsMutable = [motions mutableCopy];
    
    NSMutableArray *objectsPositions = [NSMutableArray array];
    
    for (NSUInteger i = 1; i <= 18; i++)
        [objectsPositions addObject:[TrackingObjectPosition initWithImageId:i startX:0 startY:0 endX:0 endY:0 motionValue:0]];
    
    [objectsPositions addObject:[TrackingObjectPosition initWithImageId:19 startX:545 startY:318 endX:610 endY:460 motionValue:1]]; // 19
    [objectsPositions addObject:[TrackingObjectPosition initWithImageId:20 startX:546 startY:318 endX:610 endY:461 motionValue:1]];
    [objectsPositions addObject:[TrackingObjectPosition initWithImageId:21 startX:544 startY:318 endX:610 endY:462 motionValue:1]];
    [objectsPositions addObject:[TrackingObjectPosition initWithImageId:22 startX:544 startY:318 endX:607 endY:463 motionValue:1]];
    [objectsPositions addObject:[TrackingObjectPosition initWithImageId:23 startX:544 startY:318 endX:610 endY:462 motionValue:1]];
    [objectsPositions addObject:[TrackingObjectPosition initWithImageId:24 startX:544 startY:318 endX:610 endY:456 motionValue:1]];
    [objectsPositions addObject:[TrackingObjectPosition initWithImageId:25 startX:546 startY:318 endX:610 endY:457 motionValue:1]];
    [objectsPositions addObject:[TrackingObjectPosition initWithImageId:26 startX:545 startY:318 endX:610 endY:458 motionValue:1]];
    [objectsPositions addObject:[TrackingObjectPosition initWithImageId:27 startX:546 startY:318 endX:610 endY:459 motionValue:1]];
    [objectsPositions addObject:[TrackingObjectPosition initWithImageId:28 startX:544 startY:318 endX:610 endY:455 motionValue:1]];
    [objectsPositions addObject:[TrackingObjectPosition initWithImageId:29 startX:544 startY:318 endX:610 endY:452 motionValue:1]];
    [objectsPositions addObject:[TrackingObjectPosition initWithImageId:30 startX:542 startY:318 endX:612 endY:456 motionValue:1]];
    [objectsPositions addObject:[TrackingObjectPosition initWithImageId:31 startX:545 startY:318 endX:611 endY:456 motionValue:1]];
    [objectsPositions addObject:[TrackingObjectPosition initWithImageId:32 startX:545 startY:318 endX:610 endY:458 motionValue:1]];
    
    for (NSUInteger i = 33; i <= 51; i++)
        [objectsPositions addObject:[TrackingObjectPosition initWithImageId:i startX:0 startY:0 endX:0 endY:0 motionValue:0]];
    
    [objectsPositions addObject:[TrackingObjectPosition initWithImageId:52 startX:540 startY:319 endX:619 endY:458 motionValue:1]];
    [objectsPositions addObject:[TrackingObjectPosition initWithImageId:53 startX:530 startY:319 endX:619 endY:458 motionValue:1]];
    [objectsPositions addObject:[TrackingObjectPosition initWithImageId:54 startX:520 startY:319 endX:619 endY:458 motionValue:1]];
    [objectsPositions addObject:[TrackingObjectPosition initWithImageId:55 startX:470 startY:319 endX:619 endY:458 motionValue:1]];
    [objectsPositions addObject:[TrackingObjectPosition initWithImageId:56 startX:480 startY:319 endX:619 endY:458 motionValue:1]];
    [objectsPositions addObject:[TrackingObjectPosition initWithImageId:57 startX:530 startY:319 endX:619 endY:458 motionValue:1]];
    [objectsPositions addObject:[TrackingObjectPosition initWithImageId:58 startX:545 startY:319 endX:619 endY:458 motionValue:1]];
    [objectsPositions addObject:[TrackingObjectPosition initWithImageId:59 startX:545 startY:319 endX:619 endY:458 motionValue:1]];
    [objectsPositions addObject:[TrackingObjectPosition initWithImageId:60 startX:545 startY:319 endX:619 endY:458 motionValue:1]];
    
    for (NSUInteger i = 61; i <= 78; i++)
        [objectsPositions addObject:[TrackingObjectPosition initWithImageId:i startX:0 startY:0 endX:0 endY:0 motionValue:0]];
    
    _remover = [[TrackingIrrelevantSequencesRemover alloc] initWithMotionArray:motionsMutable objectsPosition:objectsPositions];
    [_remover removeIrrelevantSequences];
    
    XCTAssertEqual([motionsReference isEqualToArray:motionsMutable], YES);
}

@end
