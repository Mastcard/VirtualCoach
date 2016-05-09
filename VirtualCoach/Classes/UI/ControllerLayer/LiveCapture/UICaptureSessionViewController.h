//
//  UICaptureSessionViewController.h
//  VirtualCoach
//
//  Created by Romain Dubreucq on 12/07/2015.
//  Copyright (c) 2015 Romain Dubreucq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UICaptureSessionView.h"
#import "CaptureSessionController.h"
#import "UIBaseViewController.h"
#import "HybridCaptureSessionController.h"
#import "UIApplicationNavigationViewController.h"

@interface UICaptureSessionViewController : UIBaseViewController <UIGestureRecognizerDelegate>

@property (nonatomic, strong) CaptureSessionController *captureSessionController;
@property (nonatomic, strong) UICaptureSessionView *captureSessionView;

//temp
@property (nonatomic, strong) NSURL *videoDirectory;

- (instancetype)initWithSessionController:(CaptureSessionController *)captureSessionController;

- (void)deviceButtonAction;
- (void)recordButtonAction;
- (void)adjustmentButtonAction;
- (void)trackerButtonAction;

@end
