//
//  UIAuthenticationViewController.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 06/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "UIAuthenticationViewController.h"

@implementation UIAuthenticationViewController

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        _authenticationView = [[UIAuthenticationView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        
        [[self navigationController] setNavigationBarHidden:YES animated:NO];
        self.navigationController.hidesBarsOnTap = YES;
        self.view = _authenticationView;
        
        [_authenticationView.credentialsView.loginButton addTarget:self action:@selector(loginButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_authenticationView.credentialsView.createAccountButton addTarget:self action:@selector(createAccountButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

- (void)prepareForUse
{
    [_authenticationView layout];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
}

- (void)loginButtonAction
{
    // set loginSuccess depending on authtication result
    
    BOOL loginSuccess = YES;
    
    if (loginSuccess)
    {
        UIApplicationNavigationViewController *nav = (UIApplicationNavigationViewController *)self.navigationController;
        
        [nav pushViewController:nav.trainingViewController animated:YES];
    }
    
    else
    {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Authentication failed."
                                      message:@"Please try again."
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* okButton = [UIAlertAction
                                    actionWithTitle:@"Close"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action)
                                    {
                                        // handle option action
                                    }];
        
        [alert addAction:okButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)createAccountButtonAction
{
    UIApplicationNavigationViewController *nav = (UIApplicationNavigationViewController *)self.navigationController;
    
    [nav pushViewController:nav.accountCreationViewController animated:YES];
}

@end
