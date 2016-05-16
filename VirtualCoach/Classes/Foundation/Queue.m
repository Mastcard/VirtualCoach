//
//  Queue.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 11/07/2015.
//  Copyright (c) 2015 Romain Dubreucq. All rights reserved.
//

#import "Queue.h"

@interface Queue ()

@property (nonatomic) NSMutableArray *objects;

@end

@implementation Queue

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        _objects = [[NSMutableArray alloc] init];
        _count = 0;
        _limit = -1;
    }
    
    return self;
}

- (void)enqueue:(id)object
{
    if (object && (_limit > 0) && (_count < _limit))
    {
        [_objects addObject:object];
        _count++;
    }
}

- (id)dequeue
{
    id headObject = [_objects objectAtIndex:0];
    
    if (headObject != nil)
    {
        [_objects removeObjectAtIndex:0];
        _count--;
    }
    
    return headObject;
}

- (BOOL)empty
{
    return _count == 0;
}

@end
