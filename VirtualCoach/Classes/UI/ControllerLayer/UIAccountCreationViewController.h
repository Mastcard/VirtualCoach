//
//  UIAccountCreationViewController.h
//  VirtualCoach
//
//  Created by Romain Dubreucq on 22/05/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "UIBaseViewController.h"
#import "UIApplicationNavigationViewController.h"
#import "UIAccountCreationView.h"

@interface UIAccountCreationViewController : UIBaseViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UIAccountCreationView *accountCreationView;

@property (nonatomic, strong) NSMutableArray *leftOrRightHandedPickerViewData;

- (void)createAccountButtonAction;

@end
