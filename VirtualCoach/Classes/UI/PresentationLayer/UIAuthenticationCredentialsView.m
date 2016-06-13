//
//  UIAuthenticationCredentialsView.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 18/05/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "UIAuthenticationCredentialsView.h"

@implementation UIAuthenticationCredentialsView

- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        _usernameTextField = [[UIBaseTextField alloc] init];
        _passwordTextField = [[UIBaseTextField alloc] init];
        _rememberMeCheckbox = [[UICheckbox alloc] init];
        _rememberMeLabel = [[UIBaseLabel alloc] init];
        _loginButton = [[UIBaseButton alloc] init];
        _createAccountButton = [UIBaseButton buttonWithType:UIButtonTypeCustom];
    }
    
    return self;
}

- (void)prepareView
{
    self.backgroundColor = [UIColor clearColor];
    
    CGFloat defaultMargin = 15.f;
    
    // setting username textfield
    
    CGPoint userNameTextFieldOrigin = CGPointMake(defaultMargin, defaultMargin);
    CGSize usernameTextFieldSize = CGSizeMake(200, 40);
    
    [_usernameTextField setFrame:CGRectMake(userNameTextFieldOrigin.x, userNameTextFieldOrigin.y, usernameTextFieldSize.width, usernameTextFieldSize.height)];
    _usernameTextField.backgroundColor = [UIColor colorWithRed:(133 / 255.f) green:(123 / 255.f) blue:(129 / 255.f) alpha:1.f];//[UIColor colorWithRed:(24 / 255.f) green:(25 / 255.f) blue:(30 / 255.f) alpha:1.f];
    [_usernameTextField setTextColor:[UIColor whiteColor]];
    _usernameTextField.layer.cornerRadius = 8.0f;
    _usernameTextField.layer.masksToBounds = YES;
    _usernameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Username" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    // setting password textfield
    
    CGPoint passwordTextFieldOrigin = CGPointMake(userNameTextFieldOrigin.x, userNameTextFieldOrigin.y + usernameTextFieldSize.height + defaultMargin);
    
    [_passwordTextField setFrame:CGRectMake(passwordTextFieldOrigin.x, passwordTextFieldOrigin.y, usernameTextFieldSize.width, usernameTextFieldSize.height)];
    _passwordTextField.backgroundColor = [UIColor colorWithRed:(133 / 255.f) green:(123 / 255.f) blue:(129 / 255.f) alpha:1.f];
    [_passwordTextField setTextColor:[UIColor whiteColor]];
    _passwordTextField.layer.cornerRadius = 8.0f;
    _passwordTextField.layer.masksToBounds = YES;
    _passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    // setting login button
    
    CGPoint loginButtonOrigin = CGPointMake(userNameTextFieldOrigin.x + usernameTextFieldSize.width + defaultMargin, defaultMargin);
    CGSize loginButtonSize = CGSizeMake(usernameTextFieldSize.width / 4, (usernameTextFieldSize.height * 2) + defaultMargin);
    
    [_loginButton setFrame:CGRectMake(loginButtonOrigin.x, loginButtonOrigin.y, loginButtonSize.width, loginButtonSize.height)];
    _loginButton.backgroundColor = [UIColor colorWithRed:(0 / 255.f) green:(122 / 255.f) blue:(255 / 255.f) alpha:1.f];//[UIColor redColor];
    _loginButton.layer.cornerRadius = 8.0f;
    _loginButton.layer.masksToBounds = YES;
    
    UIImage *padlockIcon = [UIImage imageNamed:@"unlockIcon.png"];
    [_loginButton setImage:padlockIcon forState:UIControlStateNormal];
    
//    UIImageView *padlockImageView = [[UIImageView alloc] initWithImage:padlockIcon];
//    [_loginButton addSubview:padlockImageView alignment:UIViewCentered];
    
    
    // setting remember me checkbox
    
    CGPoint rememberMeCheckboxOrigin = CGPointMake(defaultMargin, passwordTextFieldOrigin.y + usernameTextFieldSize.height + defaultMargin);
    CGSize rememberMeCheckboxSize = CGSizeMake(20, 20);
    
    [_rememberMeCheckbox setFrame:CGRectMake(rememberMeCheckboxOrigin.x, rememberMeCheckboxOrigin.y, rememberMeCheckboxSize.width, rememberMeCheckboxSize.height)];
    
    // setting remember me label
    
    CGPoint rememberMeLabelOrigin = CGPointMake(rememberMeCheckboxOrigin.x + rememberMeCheckboxSize.width + defaultMargin, rememberMeCheckboxOrigin.y);
    CGSize rememberMeLabelSize = CGSizeMake(self.frame.size.width - rememberMeLabelOrigin.x - defaultMargin, 20);
    
    [_rememberMeLabel setFrame:CGRectMake(rememberMeLabelOrigin.x, rememberMeLabelOrigin.y, rememberMeLabelSize.width, rememberMeLabelSize.height)];
    [_rememberMeLabel setText:@"Remember me"];
    [_rememberMeLabel setTextColor:[UIColor whiteColor]];
    
    // setting create account button
    
    CGPoint createAccountButtonOrigin = CGPointMake(rememberMeCheckboxOrigin.x, rememberMeCheckboxOrigin.y + rememberMeCheckboxSize.height + defaultMargin);
    
    [_createAccountButton setFrame:CGRectMake(createAccountButtonOrigin.x, createAccountButtonOrigin.y, self.frame.size.width - (defaultMargin * 2), 30)];
    
    NSMutableAttributedString *createAccountButtonTitle = [[NSMutableAttributedString alloc] initWithString:@"Need an account ?"];
    [createAccountButtonTitle addAttribute:NSFontAttributeName
                  value:[UIFont systemFontOfSize:12.0]
                  range:NSMakeRange(0, [createAccountButtonTitle length])];
    [createAccountButtonTitle addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [createAccountButtonTitle length])];
    [createAccountButtonTitle addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [createAccountButtonTitle length])];
    
    [_createAccountButton setAttributedTitle:createAccountButtonTitle forState:UIControlStateNormal];
}

- (void)layout
{
    [super layout];
    
    [self prepareForUse];
    
    [self addSubview:_usernameTextField];
    [self addSubview:_passwordTextField];
    [self addSubview:_loginButton];
    [self addSubview:_rememberMeCheckbox];
    [self addSubview:_createAccountButton alignment:UIViewCenteredOnX];
    [self addSubview:_rememberMeLabel];
}

- (void)prepareForUse
{
    [self prepareView];
}

@end
