//
//  UIRecordingButton.h
//  VirtualCoach
//
//  Created by Romain Dubreucq on 19/07/2015.
//  Copyright © 2015 Romain Dubreucq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIBaseButton.h"

@interface UIRecordingButton : UIBaseButton

@property (nonatomic) CFTimeInterval animationDuration;

- (void)transformShape;

@end
