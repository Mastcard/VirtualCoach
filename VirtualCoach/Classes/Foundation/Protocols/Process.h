//
//  Process.h
//  VirtualCoach
//
//  Created by Romain Dubreucq on 06/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Process <NSObject>

@required
- (void)start;
- (void)stop;

@optional
- (void)pause;
- (void)resume;
- (BOOL)running;

@end
