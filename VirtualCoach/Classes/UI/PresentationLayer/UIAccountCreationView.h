//
//  UIAccountCreationView.h
//  VirtualCoach
//
//  Created by Romain Dubreucq on 18/05/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "UIBaseView.h"
#import "UIAccountCreationCredentialsView.h"
#import "UIAccountCreationPresentationView.h"

@interface UIAccountCreationView : UIBaseView

@property (nonatomic, strong) UIAccountCreationCredentialsView *credentialsView;
@property (nonatomic, strong) UIAccountCreationPresentationView *presentationView;

@end
