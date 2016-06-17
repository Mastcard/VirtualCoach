//
//  UIBaseButton.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 17/07/2015.
//  Copyright © 2015 Romain Dubreucq. All rights reserved.
//

#import "UIBaseButton.h"

@implementation UIBaseButton

+ (instancetype)buttonWithType:(UIButtonType)buttonType
{
    return [super buttonWithType:buttonType];
}

- (void)layout
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
