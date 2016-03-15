//
//  UIRecordingIconView.h
//  VirtualCoach
//
//  Created by Romain Dubreucq on 25/07/2015.
//  Copyright © 2015 Romain Dubreucq. All rights reserved.
//

#import "UIBaseView.h"

@interface UIRecordingIconView : UIBaseView

@property (nonatomic, strong) NSTimer *timer;

- (void)startFlickering;
- (void)stopFlickering;

@end
