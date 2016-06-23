//
//  UINewElementWizardView.h
//  VirtualCoach
//
//  Created by Romain Dubreucq on 23/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "UIBaseView.h"
#import "UIBaseLabel.h"
#import "UIBaseTextField.h"
#import "UIBaseButton.h"

@interface UINewElementWizardView : UIBaseView

@property (nonatomic, strong) UIBaseLabel *wizardTitleLabel;
@property (nonatomic, strong) UIBaseLabel *elementNameLabel;
@property (nonatomic, strong) UIBaseTextField *elementNameTextField;
@property (nonatomic, strong) UIBaseButton *okButton;

@end
