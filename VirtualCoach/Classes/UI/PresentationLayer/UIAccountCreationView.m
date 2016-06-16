//
//  UIAccountCreationView.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 18/05/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "UIAccountCreationView.h"

@implementation UIAccountCreationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        _credentialsView = [[UIAccountCreationCredentialsView alloc] init];
        _presentationView = [[UIAccountCreationPresentationView alloc] init];
    }
    
    return self;
}

- (void)prepareView
{
    CGRect screenRect = [UIScreen mainScreen].bounds;
    
    [_credentialsView setFrame:CGRectMake(0, 0, screenRect.size.width / 2, screenRect.size.height)];
    [_presentationView setFrame:CGRectMake(screenRect.size.width / 2, 0, screenRect.size.width / 2, screenRect.size.height)];
}

- (void)layout
{
    [super layout];
    
    [self prepareForUse];
    
    [_credentialsView layout];
    [_presentationView layout];
    
    [self addSubview:_credentialsView];
    [self addSubview:_presentationView];
}

- (void)prepareForUse
{
    [self prepareView];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetLineWidth(context, 2.0f);
    CGContextMoveToPoint(context, rect.size.width / 2, 75);
    CGContextAddLineToPoint(context, rect.size.width / 2, rect.size.height - 75);
    CGContextStrokePath(context);
}

@end
