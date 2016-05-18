//
//  UIHomeViewController.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 06/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "UIHomeViewController.h"

#import "VideoProcess.h"

@interface UIHomeViewController ()

- (void)captureButtonAction;
- (void)processButtonAction;

//temp
@property (nonatomic, strong) NSString *lastInformationPath;
- (void)lastInformationsFilePath:(NSNotification *)notification;

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
        
        //temp
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(lastInformationsFilePath:)
                                                     name:@"lastInformationPath"
                                                   object:nil];
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
    NSDictionary *videoInfo = [[NSDictionary alloc] initWithContentsOfFile:_lastInformationPath];
    VideoProcess *vidProc = [[VideoProcess alloc] initWithDictionary:videoInfo];
    
    [vidProc setup];
    [vidProc start];
}

//temp

- (void)lastInformationsFilePath:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    
    _lastInformationPath = [userInfo objectForKey:@"lastInformationPathKey"];
}

@end
