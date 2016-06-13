//
//  UIAccountCreationCredentialsView.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 05/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "UIAccountCreationCredentialsView.h"

@implementation UIAccountCreationCredentialsView

- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        _titleLabel = [[UIBaseLabel alloc] init];
        _nameTextField = [[UIBaseTextField alloc] init];
        _firstNameTextField = [[UIBaseTextField alloc] init];
        _loginTextField = [[UIBaseTextField alloc] init];
        _passwordTextField = [[UIBaseTextField alloc] init];
        _passwordAgainTextField = [[UIBaseTextField alloc] init];
        _leftOrRighHandedPickerView = [[UIPickerView alloc] init];
        _createAccountButton = [[UIBaseButton alloc] init];
    }
    
    return self;
}

- (void)prepareView
{
    //self.backgroundColor = [UIColor redColor];
    
    [_titleLabel setFrame:CGRectMake(0, 100, 200, 100)];
    [_titleLabel setFont:[UIFont systemFontOfSize:30.f]];
    [_titleLabel setTextColor:[UIColor whiteColor]];
    [_titleLabel setText:@"Enter your informations"];
    [_titleLabel resizeToFitText];
    
    CGFloat defaultMargin = 35.f;
    
    // setting name textfield
    
    CGPoint nameTextFieldOrigin = CGPointMake(defaultMargin, _titleLabel.frame.origin.y + _titleLabel.frame.size.height + 50);
    CGSize nameTextFieldSize = CGSizeMake(200, 40);
    
    [_nameTextField setFrame:CGRectMake(nameTextFieldOrigin.x, nameTextFieldOrigin.y, nameTextFieldSize.width, nameTextFieldSize.height)];
    _nameTextField.backgroundColor = [UIColor colorWithRed:(133 / 255.f) green:(123 / 255.f) blue:(129 / 255.f) alpha:1.f];
    [_nameTextField setTextColor:[UIColor whiteColor]];
    _nameTextField.layer.cornerRadius = 8.0f;
    _nameTextField.layer.masksToBounds = YES;
    _nameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter your name" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    CGPoint firstNameTextFieldOrigin = CGPointMake(defaultMargin, nameTextFieldOrigin.y + nameTextFieldSize.height + defaultMargin);
    CGSize firstNameTextFieldSize = CGSizeMake(200, 40);
    
    [_firstNameTextField setFrame:CGRectMake(firstNameTextFieldOrigin.x, firstNameTextFieldOrigin.y, firstNameTextFieldSize.width, firstNameTextFieldSize.height)];
    _firstNameTextField.backgroundColor = [UIColor colorWithRed:(133 / 255.f) green:(123 / 255.f) blue:(129 / 255.f) alpha:1.f];
    [_firstNameTextField setTextColor:[UIColor whiteColor]];
    _firstNameTextField.layer.cornerRadius = 8.0f;
    _firstNameTextField.layer.masksToBounds = YES;
    _firstNameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter your first name" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    CGPoint loginTextFieldOrigin = CGPointMake(defaultMargin, firstNameTextFieldOrigin.y + firstNameTextFieldSize.height + defaultMargin);
    CGSize loginTextFieldSize = CGSizeMake(200, 40);
    
    [_loginTextField setFrame:CGRectMake(loginTextFieldOrigin.x, loginTextFieldOrigin.y, loginTextFieldSize.width, loginTextFieldSize.height)];
    _loginTextField.backgroundColor = [UIColor colorWithRed:(133 / 255.f) green:(123 / 255.f) blue:(129 / 255.f) alpha:1.f];
    [_loginTextField setTextColor:[UIColor whiteColor]];
    _loginTextField.layer.cornerRadius = 8.0f;
    _loginTextField.layer.masksToBounds = YES;
    _loginTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter your login" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    CGPoint passwordTextFieldOrigin = CGPointMake(defaultMargin, loginTextFieldOrigin.y + loginTextFieldSize.height + defaultMargin);
    CGSize passwordTextFieldSize = CGSizeMake(200, 40);
    
    [_passwordTextField setFrame:CGRectMake(passwordTextFieldOrigin.x, passwordTextFieldOrigin.y, passwordTextFieldSize.width, passwordTextFieldSize.height)];
    _passwordTextField.backgroundColor = [UIColor colorWithRed:(133 / 255.f) green:(123 / 255.f) blue:(129 / 255.f) alpha:1.f];
    [_passwordTextField setTextColor:[UIColor whiteColor]];
    _passwordTextField.layer.cornerRadius = 8.0f;
    _passwordTextField.layer.masksToBounds = YES;
    _passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter your password" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    _passwordTextField.secureTextEntry = YES;
    
    CGPoint passwordAgainTextFieldOrigin = CGPointMake(defaultMargin, passwordTextFieldOrigin.y + passwordTextFieldSize.height + defaultMargin);
    CGSize passwordAgainTextFieldSize = CGSizeMake(200, 40);
    
    [_passwordAgainTextField setFrame:CGRectMake(passwordAgainTextFieldOrigin.x, passwordAgainTextFieldOrigin.y, passwordAgainTextFieldSize.width, passwordAgainTextFieldSize.height)];
    _passwordAgainTextField.backgroundColor = [UIColor colorWithRed:(133 / 255.f) green:(123 / 255.f) blue:(129 / 255.f) alpha:1.f];
    [_passwordAgainTextField setTextColor:[UIColor whiteColor]];
    _passwordAgainTextField.layer.cornerRadius = 8.0f;
    _passwordAgainTextField.layer.masksToBounds = YES;
    _passwordAgainTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter your password again" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    _passwordAgainTextField.secureTextEntry = YES;
    
    CGPoint leftOrRighHandedPickerViewOrigin = CGPointMake(defaultMargin, passwordAgainTextFieldOrigin.y + passwordAgainTextFieldSize.height + defaultMargin);
    CGSize leftOrRighHandedPickerViewSize = CGSizeMake(200, 50);
    
    [_leftOrRighHandedPickerView setFrame:CGRectMake(leftOrRighHandedPickerViewOrigin.x, leftOrRighHandedPickerViewOrigin.y, leftOrRighHandedPickerViewSize.width, leftOrRighHandedPickerViewSize.height)];
    _leftOrRighHandedPickerView.showsSelectionIndicator = YES;
    _leftOrRighHandedPickerView.layer.borderColor = [UIColor whiteColor].CGColor;
    _leftOrRighHandedPickerView.layer.borderWidth = 1;
    [_leftOrRighHandedPickerView selectRow:0 inComponent:0 animated:YES];
    
    CGPoint createAccountButtonOrigin = CGPointMake(leftOrRighHandedPickerViewOrigin.x + leftOrRighHandedPickerViewSize.width, leftOrRighHandedPickerViewOrigin.y + leftOrRighHandedPickerViewSize.height + defaultMargin);
    CGSize createAccountButtonSize = CGSizeMake(150, 50);
    
    [_createAccountButton setFrame:CGRectMake(createAccountButtonOrigin.x, createAccountButtonOrigin.y, createAccountButtonSize.width, createAccountButtonSize.height)];
    _createAccountButton.backgroundColor = [UIColor colorWithRed:(0 / 255.f) green:(122 / 255.f) blue:(255 / 255.f) alpha:1.f];
    _createAccountButton.layer.cornerRadius = 8.0f;
    _createAccountButton.layer.masksToBounds = YES;
    [_createAccountButton.titleLabel setTextColor:[UIColor whiteColor]];
    
    NSMutableAttributedString *attributedTitle = [[NSMutableAttributedString alloc] initWithString:@"Create account"];
    [attributedTitle addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [attributedTitle length])];
    [attributedTitle addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.f] range:NSMakeRange(0, attributedTitle.length)];
    
    [_createAccountButton setAttributedTitle:attributedTitle forState:UIControlStateNormal];
    
//    NSAttributedString *attributedTitle = [_createAccountButton attributedTitleForState:UIControlStateNormal];
//    NSMutableAttributedString *mas = [[NSMutableAttributedString alloc] initWithAttributedString:attributedTitle];
//    [mas addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [mas length])];
//    [mas.mutableString setString:@"Create account"];
}

- (void)layout
{
    [super layout];
    
    [self prepareForUse];
    
    [self addSubview:_titleLabel alignment:UIViewCenteredOnX];
    
    [self addSubview:_nameTextField alignment:UIViewCenteredOnX];
    [self addSubview:_firstNameTextField alignment:UIViewCenteredOnX];
    [self addSubview:_loginTextField alignment:UIViewCenteredOnX];
    [self addSubview:_passwordTextField alignment:UIViewCenteredOnX];
    [self addSubview:_passwordAgainTextField alignment:UIViewCenteredOnX];
    [self addSubview:_leftOrRighHandedPickerView alignment:UIViewCenteredOnX];
    [self addSubview:_createAccountButton alignment:UIViewCenteredOnX];
}

- (void)prepareForUse
{
    [self prepareView];
}

@end
