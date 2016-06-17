//
//  UIAuthenticationViewController.h
//  VirtualCoach
//
//  Created by Romain Dubreucq on 06/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "UIBaseViewController.h"

#import "UIAuthenticationView.h"
#import "UIApplicationNavigationViewController.h"

@interface UIAuthenticationViewController : UIBaseViewController

@property (nonatomic) UIAuthenticationView *authenticationView;

- (void)loginButtonAction;

@end
