//
//  UIMenuView.h
//  VirtualCoach
//
//  Created by Romain Dubreucq on 14/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "UIBaseView.h"
#import "UIBaseButton.h"

@interface UIMenuView : UIBaseView

@property (nonatomic, strong) UIBaseButton *captureViewButton;
@property (nonatomic, strong) UIBaseButton *trainingViewButton;
@property (nonatomic, strong) UIBaseButton *playerViewButton;

@property (nonatomic, strong) UIImageView *tennisCourtImage;

@end
