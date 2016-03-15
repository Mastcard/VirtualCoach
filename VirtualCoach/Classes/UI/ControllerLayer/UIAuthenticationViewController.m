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
        
        self.navigationController.navigationItem.hidesBackButton = YES;
    }
    
    return self;
}

@end
