//
//  UIBaseLabel.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 06/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "UIBaseLabel.h"

@implementation UIBaseLabel

- (void)layout
{
    
}

- (void)resizeToFitText
{
    const CGSize textSize = [self.text sizeWithAttributes:@{NSFontAttributeName:self.font}];
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, textSize.width, textSize.height)];
}

@end
