//
//  UIAccountCreationCredentialsView.h
//  VirtualCoach
//
//  Created by Romain Dubreucq on 05/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "UIBaseView.h"
#import "UIBaseTextField.h"
#import "UIBaseButton.h"
#import "UIBaseLabel.h"

@interface UIAccountCreationCredentialsView : UIBaseView

@property (nonatomic, strong) UIBaseLabel *titleLabel;
@property (nonatomic, strong) UIBaseTextField *nameTextField;
@property (nonatomic, strong) UIBaseTextField *firstNameTextField;
@property (nonatomic, strong) UIBaseTextField *loginTextField;
@property (nonatomic, strong) UIBaseTextField *passwordTextField;
@property (nonatomic, strong) UIBaseTextField *passwordAgainTextField;
@property (nonatomic, strong) UIPickerView *leftOrRighHandedPickerView;
@property (nonatomic, strong) UIBaseButton *createAccountButton;

@end
