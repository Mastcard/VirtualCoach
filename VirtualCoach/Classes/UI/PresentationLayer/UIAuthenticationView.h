//
//  UIAuthenticationView.h
//  VirtualCoach
//
//  Created by Romain Dubreucq on 06/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "UIBaseView.h"
#import "UIBaseLabel.h"
#import "UIAuthenticationCredentialsView.h"

@interface UIAuthenticationView : UIBaseView

@property (nonatomic) UIAuthenticationCredentialsView *credentialsView;
@property (nonatomic, strong) UIBaseLabel *mainTitle;

@end
