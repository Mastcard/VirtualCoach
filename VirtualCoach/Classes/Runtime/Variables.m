//
//  Variables.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 21/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "Variables.h"

@implementation Variables

static NSMutableDictionary *dictionary;

+ (void)init
{
    dictionary = [[NSMutableDictionary alloc] init];
    
    [dictionary setObject:[NSNumber numberWithBool:NO] forKey:kConnected];
    [dictionary setObject:[NSNull null] forKey:kConnectedUser];
}

+ (NSMutableDictionary *)dictionary
{
    return dictionary;
}

@end
