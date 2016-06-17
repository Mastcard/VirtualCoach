//
//  UIMenuView.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 14/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "UIMenuView.h"

@implementation UIMenuView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        _captureViewButton = [[UIBaseButton alloc] init];
        _trainingViewButton = [[UIBaseButton alloc] init];
        _playerViewButton = [[UIBaseButton alloc] init];
    }
    
    return self;
}

- (void)prepareView
{
    CGFloat defaultMargin = 40.f;
    
    CGSize captureViewButtonSize = CGSizeMake(80, 80);
    CGPoint captureViewButtonOrigin = CGPointMake(((3 * self.frame.size.width) / 4) - (captureViewButtonSize.width / 2), (self.frame.size.height / 4) - (captureViewButtonSize.height / 2));
    
    [_captureViewButton setFrame:CGRectMake(captureViewButtonOrigin.x, captureViewButtonOrigin.y, captureViewButtonSize.width, captureViewButtonSize.height)];
    [_captureViewButton setImage:[UIImage imageNamed:@"camera.png"] forState:UIControlStateNormal];
    
    CGSize trainingViewButtonSize = CGSizeMake(200, 200);
    CGPoint trainingViewButtonOrigin = CGPointMake(((3 * self.frame.size.width) / 4) - (trainingViewButtonSize.width / 2), ((2 * self.frame.size.height) / 4) - (trainingViewButtonSize.height / 2));
    
    [_trainingViewButton setFrame:CGRectMake(trainingViewButtonOrigin.x, trainingViewButtonOrigin.y, trainingViewButtonSize.width, trainingViewButtonSize.height)];
    [_trainingViewButton setImage:[UIImage imageNamed:@"training.png"] forState:UIControlStateNormal];
    
//    NSMutableAttributedString *captureViewButtonTitle = [[NSMutableAttributedString alloc] initWithString:@"Capture"];
//    [captureViewButtonTitle addAttribute:NSFontAttributeName
//                                        value:[UIFont systemFontOfSize:18.0]
//                                        range:NSMakeRange(0, [captureViewButtonTitle length])];
//    [captureViewButtonTitle addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [captureViewButtonTitle length])];
//    
//    [_captureViewButton setAttributedTitle:captureViewButtonTitle forState:UIControlStateNormal];
    
    CGSize playerViewButtonSize = CGSizeMake(captureViewButtonSize.width, captureViewButtonSize.height);
    CGPoint playerViewButtonOrigin = CGPointMake(((3 * self.frame.size.width) / 4) - (captureViewButtonSize.width / 2), ((3 * self.frame.size.height) / 4) - (captureViewButtonSize.height / 2));
    
    [_playerViewButton setFrame:CGRectMake(playerViewButtonOrigin.x, playerViewButtonOrigin.y, playerViewButtonSize.width, playerViewButtonSize.height)];
    [_playerViewButton setImage:[UIImage imageNamed:@"tennisPlayer.png"] forState:UIControlStateNormal];
}

- (void)layout
{
    [super layout];
    
    [self prepareForUse];
    
    [self addSubview:_captureViewButton];
    [self addSubview:_trainingViewButton];
    [self addSubview:_playerViewButton];
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
    CGContextMoveToPoint(context,  rect.size.width / 2, 75);
    CGContextAddLineToPoint(context, rect.size.width / 2, rect.size.height - 40);
    CGContextStrokePath(context);
}

@end
