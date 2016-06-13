//
//  UIBaseButton.h
//  VirtualCoach
//
//  Created by Romain Dubreucq on 17/07/2015.
//  Copyright © 2015 Romain Dubreucq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIBaseView.h"
#import "Layout.h"

@interface UIBaseButton : UIButton <Layout>

- (void)addSubview:(nonnull UIView *)view alignment:(UIViewAlignment)alignment;

@end
