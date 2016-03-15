//
//  MotionDeduction.h
//  VirtualCoach
//
//  Created by Bi ZORO on 09/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Histogram.h"

@interface MotionDeduction : NSObject

/*!
 @method recognizeMotionWithHistogram:histogram  andLeftHanded:leftHanded
 @abstract
 Recognize tennis motion by reading a histogram of angles.
 Case leftHanded : false
 If maximum hits is on 180 degree ==> backhand
 If maximum hits is on 0 degree ==> forehand
 If maximum hits is on 270 degree ==> serve
 Case leftHanded : true
 If maximum hits is on 180 degree ==> forehand
 If maximum hits is on 0 degree ==> backhand
 If maximum hits is on 270 degree ==> serve
 @param histogram
 Regroup total hits of each angle obtained at the end of motion video
 @discussion
 */
+ (NSString *)recognizeTennisMotionWithHistogram:(Histogram *)anglesHistogram andLeftHanded:(Boolean)leftHanded;

@end
