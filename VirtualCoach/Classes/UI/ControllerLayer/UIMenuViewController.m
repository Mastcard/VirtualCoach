//
//  UIMenuViewController.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 14/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "UIMenuViewController.h"

@implementation UIMenuViewController

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        _menuView = [[UIMenuView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        
        self.view = _menuView;
        
        [_menuView.captureViewButton addTarget:self action:@selector(captureViewButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_menuView.trainingViewButton addTarget:self action:@selector(trainingViewButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_menuView.playerViewButton addTarget:self action:@selector(playerViewButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
        self.navigationItem.title = @"Menu";
    }
    
    return self;
}

- (void)prepareForUse
{
    [_menuView layout];
    
    [_menuView.profileButton setTarget:self];
    [_menuView.profileButton setAction:@selector(profileButtonAction)];
    
    self.navigationItem.rightBarButtonItem = _menuView.profileButton;
}

- (void)viewWillAppear:(BOOL)animated
{
//    CoachDataEngine *coachDataEngine = [[CoachDataEngine alloc] init];
//    NSNumber *coachId = [[Variables dictionary] objectForKey:kConnectedUserId];
//    NSString *coachFirstName = [coachDataEngine coachFirstNameWithId:coachId.intValue];
//    
//    NSDictionary *attributes = [(NSAttributedString *)_menuView.welcomeLabel.attributedText attributesAtIndex:0 effectiveRange:NULL];
//    _menuView.welcomeLabel.attributedText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"Welcome %@ !", coachFirstName] attributes:attributes];
}

- (void)captureViewButtonAction
{
    UIApplicationNavigationViewController *nav = (UIApplicationNavigationViewController *)self.navigationController;
    
    [nav pushViewController:nav.captureSessionViewController animated:YES];
}

- (void)trainingViewButtonAction
{
    UIApplicationNavigationViewController *nav = (UIApplicationNavigationViewController *)self.navigationController;
    
    [nav pushViewController:nav.trainingViewController animated:YES];
}

- (void)playerViewButtonAction
{
    UIApplicationNavigationViewController *nav = (UIApplicationNavigationViewController *)self.navigationController;
    
    [nav pushViewController:nav.playerViewController animated:YES];
}

- (void)profileButtonAction
{
    UIApplicationNavigationViewController *nav = (UIApplicationNavigationViewController *)self.navigationController;
    
    [nav pushViewController:nav.profileViewController animated:YES];
}

@end
