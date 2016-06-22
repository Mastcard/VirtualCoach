//
//  Variables.h
//  VirtualCoach
//
//  Created by Romain Dubreucq on 21/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kConnected @"CONNECTED"
#define kConnectedUser @"CONNECTED_USER"

@interface Variables : NSObject

+ (void)init;
+ (NSMutableDictionary *)dictionary;

@end
