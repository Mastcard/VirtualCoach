//
//  TrackingProcessDelegate.h
//  VirtualCoach
//
//  Created by Romain Dubreucq on 12/05/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TrackingProcessDelegate <NSObject>

- (void)didBinaryThresholdChange:(uint8_t)threshold;
- (void)didEnterInBinaryMode;
- (void)didReceiveSingleTapAt:(CGPoint)touchPoint;

@end
