//
//  UITrainingViewController.h
//  VirtualCoach
//
//  Created by Romain Dubreucq on 22/05/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "UIBaseViewController.h"
#import "UITrainingView.h"
#import "UIApplicationNavigationViewController.h"
#import "VideoProcess.h"
#import "SimpleProcessStatusDelegate.h"
#import <AVKit/AVKit.h>

#define TRAININGS_TABLEVIEW_TAG 1
#define PLAYERS_TABLEVIEW_TAG 2
#define VIDEOS_TABLEVIEW_TAG 3

@class UITrainingView;

@interface UITrainingViewController : UIBaseViewController <UITableViewDelegate, UITableViewDataSource, SimpleProcessStatusDelegate>

@property (nonatomic, strong) UITrainingView *trainingView;

@property (nonatomic, strong) NSArray *trainingsTableViewData;
@property (nonatomic, strong) NSMutableArray *playersTableViewData;
@property (nonatomic, strong) NSMutableArray *videosTableViewData;
@property (nonatomic, strong) NSMutableArray *videosDurationTableViewData;

@property (nonatomic, strong) AVPlayerViewController *playerViewController;

- (void)processVideoButtonAction:(UIBaseButton *)sender;
- (void)removeVideoButtonAction:(UIBaseButton *)sender;
- (void)processAllVideosButtonAction;
- (void)recordingViewButtonAction;
- (void)playVideoButtonAction:(UIBaseButton *)sender;
- (void)addPlayerToTrainingButtonAction;
- (void)addPlayerToTrainingOkButtonAction;

@end
