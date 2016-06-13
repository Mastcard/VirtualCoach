//
//  UIAuthenticationCredentialsView.h
//  VirtualCoach
//
//  Created by Romain Dubreucq on 18/05/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <Quartzcore/QuartzCore.h>
#import "UIBaseView.h"
#import "UIBaseTextField.h"
#import "UIBaseButton.h"
#import "UIBaseLabel.h"
#import "UICheckbox.h"

@interface UIAuthenticationCredentialsView : UIBaseView

@property (nonatomic, strong) UIBaseTextField *usernameTextField;
@property (nonatomic, strong) UIBaseTextField *passwordTextField;
@property (nonatomic, strong) UICheckbox *rememberMeCheckbox;
@property (nonatomic, strong) UIBaseLabel *rememberMeLabel;
@property (nonatomic, strong) UIBaseButton *loginButton;
@property (nonatomic, strong) UIBaseButton *createAccountButton;

@end
