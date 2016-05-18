//
//  Cluster.m
//  VirtualCoach
//
//  Created by Bi ZORO on 15/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "Cluster.h"

@implementation Cluster

- (instancetype)init{
    self = [super init];
    if (self){
        _center = [[KmeanEntry alloc] init];
        _countMember = 0;
        _members = [[NSMutableArray alloc] init];
    }
    return  self;
}


@end
