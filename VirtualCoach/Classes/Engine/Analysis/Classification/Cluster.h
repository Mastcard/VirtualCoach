//
//  Cluster.h
//  VirtualCoach
//
//  Created by Bi ZORO on 15/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KmeanEntry.h"

@interface Cluster : NSObject

@property (nonatomic) KmeanEntry * center;
@property (nonatomic) unsigned int countMember;
@property (nonatomic) NSMutableArray * members;

@end
