//
//  UIApplicationNavigationViewController.h
//  VirtualCoach
//
//  Created by Romain Dubreucq on 06/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIAuthenticationViewController.h"
#import "UIHomeViewController.h"

@interface UIApplicationNavigationViewController : UINavigationController

@property (nonatomic) UIAuthenticationViewController *authenticationViewController;
@property (nonatomic) UIHomeViewController *homeViewController;

@end
