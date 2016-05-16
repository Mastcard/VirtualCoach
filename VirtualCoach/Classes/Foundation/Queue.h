//
//  Queue.h
//  VirtualCoach
//
//  Created by itzseven on 11/07/2015.
//  Copyright (c) 2015 itzseven. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Queue : NSObject

@property (nonatomic) NSUInteger count;
@property (nonatomic) NSUInteger limit;

- (void)enqueue:(id)object;
- (id)dequeue;
- (BOOL)empty;

@end
