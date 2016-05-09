//
//  UIApplicationNavigationViewController.h
//  VirtualCoach
//
//  Created by Romain Dubreucq on 06/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIAuthenticationViewController.h"
#import "CaptureProcessManager.h"

@class UIHomeViewController, UICaptureSessionViewController;

@interface UIApplicationNavigationViewController : UINavigationController

@property (nonatomic, strong) UIAuthenticationViewController *authenticationViewController;
@property (nonatomic, strong) UICaptureSessionViewController *captureSessionViewController;
@property (nonatomic, strong) UIHomeViewController *homeViewController;

@end
