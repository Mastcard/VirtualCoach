//
//  UIRecordingDurationLabelView.h
//  VirtualCoach
//
//  Created by Romain Dubreucq on 21/07/2015.
//  Copyright © 2015 Romain Dubreucq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIBaseView.h"

@interface UIRecordingDurationLabelView : UIBaseView

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) BOOL resetAtStopAction;

- (void)startDuration;
- (void)stopDuration;

@end
