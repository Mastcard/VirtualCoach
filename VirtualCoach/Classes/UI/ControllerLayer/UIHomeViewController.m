//
//  UIHomeViewController.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 06/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "UIHomeViewController.h"

@implementation UIHomeViewController

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        _homeView = [[UIHomeView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    
    return self;
}

@end
