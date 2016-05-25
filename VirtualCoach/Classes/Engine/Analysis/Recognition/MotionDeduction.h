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
/*
+ (NSNumber *)bhattacharyyaBetweenFirstAngleHistogram:(Histogram *)histo1 andSecondHistogram:(Histogram *)histo2;
*/

/*!
 @method recognizeTennisMotionWithFilterHistogram:histogram  andLeftHanded:leftHanded
 @abstract
 Recognize tennis motion by reading a histogram of angles. In this histogram we look at only the reference angle 0°, 180°, 270°.
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
+ (NSString *)recognizeTennisMotionWithFilterHistogram:(Histogram *)anglesHistogram andLeftHanded:(Boolean)leftHanded;

/*!
 @method compareHistogram:mvt  isPlayerLeftHanded:leftHandedPlayer pathHistogramRef:path isCoachLeftHanded:leftHandedCoatch withThreshold:threshold
 @abstract
 Compare two histograms of angle and gives similarity rate between these histograms
 Case leftHanded or righthanded for the twice : false or true
    - calcul distance between each angle of each histogram (simple distance: difference)
 Case leftHanded or righthanded not for the twice : false and true or true and false
    - firstly change the histogram of leftHanded person (give value of each hits of angle to their symetric regarding sinus axis)
    - calcul distance between each angle of each histogram (simple distance: difference)
 @param mvt
 Histogram of player
 @param leftHandedPlayer
 To precise if the player is lefthanded
 @param path
 Path to the histogram reference of coach
 @param leftHandedCoatch
 To precise if the coach is lefthanded
 @param threshold
 To reduce the level of comparaison
 @discussion
 */
+(NSString *)compareHistogram:(Histogram *)mvt isPlayerLeftHanded:(Boolean)leftHandedPlayer pathHistogramRef:(NSString *)path isCoachLeftHanded:(Boolean)leftHandedCoatch withThreshold:(int)threshold;

//+ (NSNumber *)bhattacharyyaBetweenFirstAngleHistogram:(Histogram *)histo1 andSecondHistogram:(Histogram *)histo2

@end
