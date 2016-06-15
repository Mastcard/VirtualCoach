//
//  UIPlayerView.h
//  VirtualCoach
//
//  Created by Romain Dubreucq on 14/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "UIBaseView.h"
#import "UIBaseLabel.h"
#import "UIBaseButton.h"

@interface UIPlayerView : UIBaseView

@property (nonatomic, strong) UIBaseLabel *playersPaneLabel;
@property (nonatomic, strong) UITableView *playersTableView;
@property (nonatomic, strong) UIBaseButton *addPlayerButton;
@property (nonatomic, strong) UIBaseButton *removePlayerButton;

@property (nonatomic, strong) UIBaseLabel *informationsPaneLabel;
@property (nonatomic, strong) UIImageView *profilePhotoImageView;
@property (nonatomic, strong) UIBaseLabel *playerNameLabel;
@property (nonatomic, strong) UIBaseLabel *playerFirstNameLabel;
@property (nonatomic, strong) UIBaseLabel *playerLevelLabel;

@property (nonatomic, strong) UIBaseLabel *trainingsPaneLabel;
@property (nonatomic, strong) UITableView *trainingsTableView;

//temp
@property (nonatomic, strong) UIBaseView *curvesView;

@property (nonatomic, strong) UIBaseLabel *dataSelectionLabel;
@property (nonatomic, strong) UIPickerView *dataPickerView;

@property (nonatomic, strong) UIBaseLabel *periodSelectionLabel;
@property (nonatomic, strong) UIPickerView *periodPickerView;

@property (nonatomic, strong) UIBaseLabel *styleSelectionLabel;
@property (nonatomic, strong) UIPickerView *stylePickerView;

@end
