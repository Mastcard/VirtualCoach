//
//  UIApplicationNavigationViewController.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 06/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "UIApplicationNavigationViewController.h"

@implementation UIApplicationNavigationViewController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    
    if (self)
    {
        _authenticationViewController = [[UIAuthenticationViewController alloc] init];
        _homeViewController = [[UIHomeViewController alloc] init];
        
        self.viewControllers = @[rootViewController];//, _authenticationViewController, _homeViewController];
    }
    
    return self;
}

@end
