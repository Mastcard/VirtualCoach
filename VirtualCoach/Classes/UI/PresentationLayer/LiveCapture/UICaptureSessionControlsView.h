//
//  UICaptureSessionControlsView.h
//  VirtualCoach
//
//  Created by Romain Dubreucq on 07/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "UIBaseView.h"
#import "UIRecordingButton.h"
#import "UIRecordingDurationLabelView.h"
#import "UIRecordingIconView.h"

@interface UICaptureSessionControlsView : UIBaseView

@property (nonatomic, strong) UIRecordingButton *recordButton;
@property (nonatomic, strong) UIBaseButton *deviceButton;

@property (nonatomic, strong) UIRecordingDurationLabelView *recordingDurationLabelView;
@property (nonatomic, strong) UIRecordingIconView *recordingIconView;

@property (nonatomic, strong) UIBaseButton *adjustmentButton;
@property (nonatomic, strong) UIBaseButton *trackerButton;

@end
