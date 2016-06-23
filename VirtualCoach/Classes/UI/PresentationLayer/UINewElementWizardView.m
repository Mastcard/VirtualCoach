//
//  UINewElementWizardView.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 23/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "UINewElementWizardView.h"

@implementation UINewElementWizardView

- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        _wizardTitleLabel = [[UIBaseLabel alloc] init];
        _elementNameLabel = [[UIBaseLabel alloc] init];
        _elementNameTextField = [[UIBaseTextField alloc] init];
        _okButton = [[UIBaseButton alloc] init];
    }
    
    return self;
}

- (void)prepareView
{
    CGFloat defaultMargin = 30.f;
    
    CGSize wizardTitleLabelSize = CGSizeMake(self.frame.size.width - (defaultMargin * 2), 40);
    CGPoint wizardTitleLabelPosition = CGPointMake(0, defaultMargin);
    
    [_wizardTitleLabel setFrame:CGRectMake(wizardTitleLabelPosition.x, wizardTitleLabelPosition.y, wizardTitleLabelSize.width, wizardTitleLabelSize.height)];
    
    CGSize elementLabelSize = CGSizeMake((self.frame.size.width / 2) - (defaultMargin * 3), 40);
    CGPoint elementLabelPosition = CGPointMake(defaultMargin, wizardTitleLabelPosition.y + wizardTitleLabelSize.height + defaultMargin);
    
    [_elementNameLabel setFrame:CGRectMake(elementLabelPosition.x, elementLabelPosition.y, elementLabelSize.width, elementLabelSize.height)];
    
    CGPoint okAccountButtonOrigin = CGPointMake(0, elementLabelPosition.y + elementLabelSize.height + defaultMargin);
    CGSize okAccountButtonSize = CGSizeMake(150, 50);
    
    [_okButton setFrame:CGRectMake(okAccountButtonOrigin.x, okAccountButtonOrigin.y, okAccountButtonSize.width, okAccountButtonSize.height)];
    _okButton.backgroundColor = [UIColor colorWithRed:(0 / 255.f) green:(122 / 255.f) blue:(255 / 255.f) alpha:1.f];
    _okButton.layer.cornerRadius = 8.0f;
    _okButton.layer.masksToBounds = YES;
    [_okButton.titleLabel setTextColor:[UIColor whiteColor]];
    
    NSMutableAttributedString *attributedTitle = [[NSMutableAttributedString alloc] initWithString:@"OK"];
    [attributedTitle addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [attributedTitle length])];
    [attributedTitle addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.f] range:NSMakeRange(0, attributedTitle.length)];
    
    [_okButton setAttributedTitle:attributedTitle forState:UIControlStateNormal];
}

- (void)layout
{
    [super layout];
    
    [self prepareForUse];
    
    [self addSubview:_wizardTitleLabel alignment:UIViewCenteredOnX];
    [self addSubview:_elementNameLabel];
    [self addSubview:_elementNameTextField];
    [self addSubview:_okButton alignment:UIViewCenteredOnX];
}

- (void)prepareForUse
{
    [self prepareView];
}

@end
