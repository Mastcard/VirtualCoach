//
//  UIAccountCreationPresentationView.h
//  VirtualCoach
//
//  Created by Romain Dubreucq on 05/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "UIBaseView.h"
#import "UIBaseLabel.h"

@interface UIAccountCreationPresentationView : UIBaseView

@property (nonatomic, strong) UIBaseLabel *titleLabel;

@property (nonatomic, strong) UITextView *presentationTextView;

@end
