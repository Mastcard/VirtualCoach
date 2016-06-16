//
//  SimpleProcessStatusDelegate.h
//  VirtualCoach
//
//  Created by Romain Dubreucq on 12/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SimpleProcessStatusDelegate <NSObject>

- (void)didUpdateStatusWithProgress:(float)progress message:(NSString *)message;

@end
