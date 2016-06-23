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

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    if (self.attributedText.length > 0)
    {
        NSDictionary *attributes = [self.attributedText attributesAtIndex:0 effectiveRange:NULL];
        self.attributedText = [[NSAttributedString alloc] initWithString:text attributes:attributes];
    }
}

@end
