//
//  UIApplicationNavigationViewController.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 06/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "UIApplicationNavigationViewController.h"

#import "UIHomeViewController.h"
#import "UICaptureSessionViewController.h"

@implementation UIApplicationNavigationViewController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    
    if (self)
    {
        _authenticationViewController = (UIAuthenticationViewController *)rootViewController;
        //_homeViewController = (UIHomeViewController *)rootViewController;
        //_accounCreationViewController = (UIAccountCreationViewController *)rootViewController;
        _homeViewController = [[UIHomeViewController alloc] init];
        _accountCreationViewController = [[UIAccountCreationViewController alloc] init];
        _trainingViewController = [[UITrainingViewController alloc] init];
        
        [_authenticationViewController prepareForUse];
        [_accountCreationViewController prepareForUse];
        [_homeViewController prepareForUse];
        [_trainingViewController prepareForUse];
        
        CaptureProcessManager *captureProcessManager = [CaptureProcessManager sharedInstance];
        _captureSessionViewController = [[UICaptureSessionViewController alloc] initWithSessionController:[captureProcessManager captureSessionController]];
        
        [_captureSessionViewController prepareForUse];
        
        [self popToRootViewControllerAnimated:NO];
    }
    
    return self;
}

@end
