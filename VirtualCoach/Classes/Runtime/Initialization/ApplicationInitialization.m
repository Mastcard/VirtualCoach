//
//  ApplicationInitialization.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 21/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "ApplicationInitialization.h"

@implementation ApplicationInitialization

+ (void)start
{
    NSString * dbPath = [[NSBundle mainBundle]
                                pathForResource:@"VirtualCoach"
                                ofType:@"db"];
    
    NSLog(@"dbPath : %@", dbPath);
    
    [DatabaseService initWithFile:dbPath];
}

@end
