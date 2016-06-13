//
//  UIBaseView.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 17/07/2015.
//  Copyright © 2015 Romain Dubreucq. All rights reserved.
//

#import "UIBaseView.h"

@implementation UIBaseView

- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (void)layout
{
    //self.backgroundColor = [UIColor colorWithRed:(18 / 255.f) green:(19 / 255.f) blue:(23 / 255.f) alpha:1.0];
}

- (void)prepareForUse
{
    
}

- (void)prepareForReuse
{
    
}

- (void)addSubview:(nonnull UIView *)view alignment:(UIViewAlignment)alignment
{
    CGSize size = view.frame.size;
    
    switch (alignment)
    {
        case UIViewNoCentered:
        break;
            
        case UIViewCentered:
            if (size.width >= self.frame.size.width || size.height >= self.frame.size.height)
                return;
            
            [view setFrame:CGRectMake((self.frame.size.width - size.width) / 2, (self.frame.size.height - size.height) / 2, size.width, size.height)];
        break;
            
        case UIViewCenteredOnX:
            if (size.width >= self.frame.size.width)
                return;
            
            [view setFrame:CGRectMake((self.frame.size.width - size.width) / 2, view.frame.origin.y, size.width, size.height)];
        break;
            
        case UIViewCenteredOnY:
            if (size.height >= self.frame.size.height)
                return;
            
            [view setFrame:CGRectMake(view.frame.origin.x, (self.frame.size.height - size.height) / 2, size.width, size.height)];
        break;
            
        default:
        break;
    }
    
    [self addSubview:view];
}

@end
