//
//  QueueTest.m
//  VirtualCoach
//
//  Created by itzseven on 20/10/2015.
//  Copyright © 2015 itzseven. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Queue.h"

@interface QueueTest : XCTestCase

@property (nonatomic) Queue *queue;

@end

@implementation QueueTest

- (void)setUp
{
    [super setUp];
    
    _queue = [[Queue alloc] init];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testEnqueue
{
    for (NSUInteger i = 2; i < 10; i++)
    {
        [_queue enqueue:[NSNumber numberWithLong:i]];
    }
    
    XCTAssertEqual([_queue count], 8);
    
    [_queue enqueue:[NSNumber numberWithLong:150]];
    
    XCTAssertEqual([_queue count], 9);
}

- (void)testDequeue
{
    for (NSUInteger i = 5; i < 10; i++)
    {
        [_queue enqueue:[NSNumber numberWithLong:i]];
    }
    
    NSNumber *firstElement = (NSNumber *)[_queue dequeue];
    
    XCTAssertEqual(firstElement.intValue, 5);
    
    for (NSUInteger i = 0; i < 3; i++)
    {
        [_queue dequeue];
    }
    
    NSNumber *nElement = (NSNumber *)[_queue dequeue];
    
    XCTAssertEqual(nElement.intValue, 9);
}

- (void)testEmpty
{
    for (NSUInteger i = 5; i < 10; i++)
    {
        [_queue enqueue:[NSNumber numberWithLong:i]];
    }
    
    XCTAssertEqual([_queue empty], NO);
    
    for (NSUInteger i = 5; i < 10; i++)
    {
        [_queue dequeue];
    }
    
    XCTAssertEqual([_queue empty], YES);
}

@end
