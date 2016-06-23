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
    [self setBackgroundColor:[UIColor colorWithRed:0.f green:0.f blue:0.f alpha:1.f]];
    
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = 1.f;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    
    CGFloat defaultMargin = 15.f;
    
    CGSize wizardTitleLabelSize = CGSizeMake(self.frame.size.width - (defaultMargin * 2), 30);
    CGPoint wizardTitleLabelPosition = CGPointMake((self.frame.size.width - wizardTitleLabelSize.width) / 2, defaultMargin);
    
    [_wizardTitleLabel setFrame:CGRectMake(wizardTitleLabelPosition.x, wizardTitleLabelPosition.y, wizardTitleLabelSize.width, wizardTitleLabelSize.height)];
    
    NSMutableAttributedString *wizardTitleLabelText = [[NSMutableAttributedString alloc] initWithString:@"   "];
    [wizardTitleLabelText addAttribute:NSForegroundColorAttributeName
                              value:[UIColor whiteColor]
                              range:NSMakeRange(0, wizardTitleLabelText.length)];
    [wizardTitleLabelText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18.f] range:NSMakeRange(0, wizardTitleLabelText.length)];
    [_wizardTitleLabel setAttributedText:wizardTitleLabelText];
    
    CGSize elementLabelSize = CGSizeMake((self.frame.size.width / 2) - (defaultMargin * 3), 30);
    CGPoint elementLabelPosition = CGPointMake(defaultMargin, wizardTitleLabelPosition.y + wizardTitleLabelSize.height + defaultMargin);
    
    [_elementNameLabel setFrame:CGRectMake(elementLabelPosition.x, elementLabelPosition.y, elementLabelSize.width, elementLabelSize.height)];
    
    NSMutableAttributedString *elementLabelText = [[NSMutableAttributedString alloc] initWithString:@"   "];
    [elementLabelText addAttribute:NSForegroundColorAttributeName
                                 value:[UIColor whiteColor]
                                 range:NSMakeRange(0, elementLabelText.length)];
    [elementLabelText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18.f] range:NSMakeRange(0, elementLabelText.length)];
    [_elementNameLabel setAttributedText:elementLabelText];
    
    CGPoint okAccountButtonOrigin = CGPointMake(0, elementLabelPosition.y + elementLabelSize.height + defaultMargin);
    CGSize okAccountButtonSize = CGSizeMake(120, 40);
    
    CGSize elementTextFieldSize = CGSizeMake((self.frame.size.width / 2) - (defaultMargin * 3), 40);
    CGPoint elementTextFieldPosition = CGPointMake(elementLabelPosition.x + elementLabelSize.height + defaultMargin, elementLabelPosition.y);
    
    [_elementNameTextField setFrame:CGRectMake(elementLabelPosition.x + elementLabelSize.width + defaultMargin, elementTextFieldPosition.y, elementTextFieldSize.width, elementTextFieldSize.height)];
    _elementNameTextField.backgroundColor = [UIColor colorWithRed:(133 / 255.f) green:(123 / 255.f) blue:(129 / 255.f) alpha:1.f];
    [_elementNameTextField setTextColor:[UIColor whiteColor]];
    _elementNameTextField.layer.cornerRadius = 8.0f;
    _elementNameTextField.layer.masksToBounds = YES;
    
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
