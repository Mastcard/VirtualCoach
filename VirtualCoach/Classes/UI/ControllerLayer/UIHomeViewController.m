//
//  UIHomeViewController.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 06/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "UIHomeViewController.h"

@interface UIHomeViewController ()

- (void)captureButtonAction;
- (void)processButtonAction;

@end

@implementation UIHomeViewController

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        _homeView = [[UIHomeView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        
        [_homeView.captureButton addTarget:self action:@selector(captureButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_homeView.processButton addTarget:self action:@selector(processButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
        self.navigationItem.title = @"Home";
        
        self.navigationItem.backBarButtonItem =
        [[UIBarButtonItem alloc] initWithTitle:@"Home"
                                         style:UIBarButtonItemStylePlain
                                        target:nil
                                        action:nil];
    }
    
    return self;
}

- (void)loadView
{
    [super loadView];
    
    [self.view addSubview:_homeView];
}

- (void)captureButtonAction
{
    UIApplicationNavigationViewController *nav = (UIApplicationNavigationViewController *)self.navigationController;
    
    [nav pushViewController:nav.captureSessionViewController animated:YES];
}

- (void)processButtonAction
{
    
}

@end
