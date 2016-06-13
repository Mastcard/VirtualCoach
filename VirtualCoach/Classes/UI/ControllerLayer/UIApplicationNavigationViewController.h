//
//  UIApplicationNavigationViewController.h
//  VirtualCoach
//
//  Created by Romain Dubreucq on 06/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIAuthenticationViewController.h"
#import "UIAccountCreationViewController.h"
#import "UITrainingViewController.h"
#import "CaptureProcessManager.h"

@class UIHomeViewController, UICaptureSessionViewController, UIAuthenticationViewController, UIAccountCreationViewController, UITrainingViewController;

@interface UIApplicationNavigationViewController : UINavigationController

@property (nonatomic, strong) UIAuthenticationViewController *authenticationViewController;
@property (nonatomic, strong) UIAccountCreationViewController *accountCreationViewController;
@property (nonatomic, strong) UICaptureSessionViewController *captureSessionViewController;
@property (nonatomic, strong) UIHomeViewController *homeViewController;
@property (nonatomic, strong) UITrainingViewController *trainingViewController;

@end
