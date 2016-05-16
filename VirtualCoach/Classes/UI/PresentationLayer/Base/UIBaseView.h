//
//  UIBaseView.h
//  VirtualCoach
//
//  Created by Romain Dubreucq on 17/07/2015.
//  Copyright © 2015 Romain Dubreucq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Layout.h"

typedef NS_ENUM(NSUInteger, UIViewAlignment) {
    UIViewNoCentered = 0,
    UIViewCentered = 1,
    UIViewCenteredOnX = 2,
    UIViewCenteredOnY = 3,
};

@interface UIBaseView : UIView <Layout>

- (void)prepareForUse;

- (void)prepareForReuse;

- (void)addSubview:(nonnull UIView *)view alignment:(UIViewAlignment)alignment;

@end
