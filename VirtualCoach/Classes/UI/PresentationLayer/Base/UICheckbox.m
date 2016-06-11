//
//  UICheckbox.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 21/05/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "UICheckbox.h"

@interface UICheckbox ()

@property (nonatomic, assign) BOOL loaded;
@property(nonatomic, strong) UILabel *textLabel;

@end

@implementation UICheckbox

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"uicheckbox_%@checked.png", (self.checked) ? @"" : @"un"]];
    [image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    
    if (self.disabled)
    {
        self.userInteractionEnabled = NO;
        self.alpha = 0.7f;
    }
    
    else
    {
        self.userInteractionEnabled = YES;
        self.alpha = 1.0f;
    }
    
    if (self.text)
    {
        if(!_loaded)
        {
            _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width + 5, 0, 1024, 30)];
            _textLabel.backgroundColor = [UIColor clearColor];
            //[self addSubview:_textLabel];
            
            _loaded = YES;
        }
        
        _textLabel.text = self.text;
    }
}

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    [self setChecked:!self.checked];
    return YES;
}

- (void)setChecked:(BOOL)boolValue
{
    _checked = boolValue;
    [self setNeedsDisplay];
}

- (void)setDisabled:(BOOL)boolValue
{
    _disabled = boolValue;
    [self setNeedsDisplay];
}

- (void)setText:(NSString *)stringValue
{
    _text = stringValue;
    [self setNeedsDisplay];
}

@end
