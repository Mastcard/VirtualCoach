//
//  UICaptureSessionOverlayControlsView.h
//  VirtualCoach
//
//  Created by Romain Dubreucq on 20/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "UIBaseView.h"

#import "UIBaseButton.h"

@interface UICaptureSessionOverlayControlsView : UIBaseView

@property (nonatomic, strong) UISlider *binaryThresholdSlider;
@property (nonatomic, strong) UIBaseButton *binaryModeButton;

@end
