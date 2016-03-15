//
//  UIActivityIndicatorTitledView.h
//  VirtualCoach
//
//  Created by Romain Dubreucq on 09/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "UIBaseView.h"
#import "UIBaseLabel.h"

@interface UIActivityIndicatorTitledView : UIBaseView

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;

@property (nonatomic, strong) UIBaseLabel *activityIndicatorLabel;

@end
