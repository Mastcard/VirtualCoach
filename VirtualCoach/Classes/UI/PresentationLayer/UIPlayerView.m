//
//  UIPlayerView.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 14/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "UIPlayerView.h"
#import "UIPlayerViewController.h"
#import "UITrainingViewController.h"

@implementation UIPlayerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        _playersPaneLabel = [[UIBaseLabel alloc] init];
        _playersTableView = [[UITableView alloc] init];
        
        _dataSelectionLabel = [[UIBaseLabel alloc] init];
        _dataPickerView = [[UIPickerView alloc] init];
        
        _periodSelectionLabel = [[UIBaseLabel alloc] init];
        _periodPickerView = [[UIPickerView alloc] init];
        
        _styleSelectionLabel = [[UIBaseLabel alloc] init];
        _stylePickerView = [[UIPickerView alloc] init];
        
        _coordinateSystemView = [[UICoordinateSystem2D alloc] init];
        
        _trainingsPaneLabel = [[UIBaseLabel alloc] init];
        _trainingsTableView = [[UITableView alloc] init];
        
        _profilePhotoImageView = [[UIImageView alloc] init];
        _playerNameLabel = [[UIBaseLabel alloc] init];
        _playerFirstNameLabel = [[UIBaseLabel alloc] init];
        _playerLevelLabel = [[UIBaseLabel alloc] init];
        
        _addPlayerButton = [[UIBaseButton alloc] init];
        _removePlayerButton = [[UIBaseButton alloc] init];
    }
    
    return self;
}

- (void)prepareView
{
    CGFloat defaultMargin = 40.f;
    
    CGSize curvesViewSize = CGSizeMake(700, 470);
    CGPoint curvesViewOrigin = CGPointMake(self.frame.size.width - (defaultMargin + curvesViewSize.width), self.frame.size.height - (defaultMargin + curvesViewSize.height));
    [_coordinateSystemView setFrame:CGRectMake(curvesViewOrigin.x, curvesViewOrigin.y, curvesViewSize.width, curvesViewSize.height)];
    
    CGPoint playersTableViewOrigin = CGPointMake(defaultMargin, defaultMargin + 75);
    CGSize playersTableViewSize = CGSizeMake(200, 200);
    
    [_playersTableView setFrame:CGRectMake(playersTableViewOrigin.x, playersTableViewOrigin.y, playersTableViewSize.width, playersTableViewSize.height)];
    [_playersTableView setScrollEnabled:YES];
    [_playersTableView setBackgroundColor:[UIColor clearColor]];
    _playersTableView.layer.borderColor = [UIColor whiteColor].CGColor;
    _playersTableView.layer.borderWidth = 1.0f;
    [_playersTableView setTag:PLAYERS_TABLEVIEW_TAG];
    
    CGSize profileImageViewSize = CGSizeMake(90, 90);
    CGPoint profileImageViewOrigin = CGPointMake(defaultMargin, playersTableViewOrigin.y + playersTableViewSize.height + defaultMargin);
    
    UIImage *profileImage = [UIImage imageNamed:@"playerIcon.png"];
    [_profilePhotoImageView setImage:profileImage];
    [_profilePhotoImageView setFrame:CGRectMake(profileImageViewOrigin.x, profileImageViewOrigin.y, profileImageViewSize.width, profileImageViewSize.height)];
    
    CGSize playerNameLabelSize = CGSizeMake(150, 25);
    CGPoint playerNameLabelOrigin = CGPointMake(profileImageViewOrigin.x + profileImageViewSize.width, profileImageViewOrigin.y);
    [_playerNameLabel setFrame:CGRectMake(playerNameLabelOrigin.x, playerNameLabelOrigin.y, playerNameLabelSize.width, playerNameLabelSize.height)];
    
    NSMutableAttributedString *playerNameLabelText = [[NSMutableAttributedString alloc] initWithString:@"Name:"];
    [playerNameLabelText addAttribute:NSFontAttributeName
                                value:[UIFont systemFontOfSize:17.0]
                                range:NSMakeRange(0, [playerNameLabelText length])];
    [playerNameLabelText addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [playerNameLabelText length])];
    
    [_playerNameLabel setAttributedText:playerNameLabelText];
    
    
    
    CGSize playerFirstNameLabelSize = CGSizeMake(150, 25);
    CGPoint playerFirstNameLabelOrigin = CGPointMake(playerNameLabelOrigin.x, playerNameLabelOrigin.y + playerNameLabelSize.height);
    [_playerFirstNameLabel setFrame:CGRectMake(playerFirstNameLabelOrigin.x, playerFirstNameLabelOrigin.y, playerFirstNameLabelSize.width, playerFirstNameLabelSize.height)];
    
    NSMutableAttributedString *playerFirstNameLabelText = [[NSMutableAttributedString alloc] initWithString:@"First name:"];
    [playerFirstNameLabelText addAttribute:NSFontAttributeName
                                value:[UIFont systemFontOfSize:17.0]
                                range:NSMakeRange(0, [playerFirstNameLabelText length])];
    [playerFirstNameLabelText addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [playerFirstNameLabelText length])];
    
    [_playerFirstNameLabel setAttributedText:playerFirstNameLabelText];
    
    
    CGSize playerLevelLabelSize = CGSizeMake(150, 25);
    CGPoint playerLevelLabelOrigin = CGPointMake(playerNameLabelOrigin.x, playerFirstNameLabelOrigin.y + playerFirstNameLabelSize.height);
    [_playerLevelLabel setFrame:CGRectMake(playerLevelLabelOrigin.x, playerLevelLabelOrigin.y, playerLevelLabelSize.width, playerLevelLabelSize.height)];
    
    NSMutableAttributedString *playerLevelLabelText = [[NSMutableAttributedString alloc] initWithString:@"Level:"];
    [playerLevelLabelText addAttribute:NSFontAttributeName
                                     value:[UIFont systemFontOfSize:17.0]
                                     range:NSMakeRange(0, [playerLevelLabelText length])];
    [playerLevelLabelText addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [playerLevelLabelText length])];
    
    [_playerLevelLabel setAttributedText:playerLevelLabelText];
    
    
    CGSize trainingsTableViewSize = CGSizeMake(200, 220);
    CGPoint trainingsTableViewOrigin = CGPointMake(defaultMargin, self.frame.size.height - (defaultMargin + trainingsTableViewSize.height));
    
    [_trainingsTableView setFrame:CGRectMake(trainingsTableViewOrigin.x, trainingsTableViewOrigin.y, trainingsTableViewSize.width, trainingsTableViewSize.height)];
    [_trainingsTableView setScrollEnabled:YES];
    [_trainingsTableView setBackgroundColor:[UIColor clearColor]];
    _trainingsTableView.layer.borderColor = [UIColor whiteColor].CGColor;
    _trainingsTableView.layer.borderWidth = 1.0f;
    [_trainingsTableView setTag:TRAININGS_TABLEVIEW_TAG];
    
    CGSize trainingsPaneLabelSize = CGSizeMake(150, 30);
    CGPoint trainingsPaneLabelOrigin = CGPointMake(trainingsTableViewOrigin.x, trainingsTableViewOrigin.y - defaultMargin);
    
    [_trainingsPaneLabel setFrame:CGRectMake(trainingsPaneLabelOrigin.x, trainingsPaneLabelOrigin.y, trainingsPaneLabelSize.width, trainingsPaneLabelSize.height)];
    
    NSMutableAttributedString *trainingsPaneLabelText = [[NSMutableAttributedString alloc] initWithString:@"Related trainings"];
    [trainingsPaneLabelText addAttribute:NSFontAttributeName
                                   value:[UIFont systemFontOfSize:20.0]
                                   range:NSMakeRange(0, [trainingsPaneLabelText length])];
    [trainingsPaneLabelText addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [trainingsPaneLabelText length])];
    
    [_trainingsPaneLabel setAttributedText:trainingsPaneLabelText];
    
    
    CGSize playerPaneLabelSize = CGSizeMake(80, 30);
    CGPoint playerPaneLabelOrigin = CGPointMake(playersTableViewOrigin.x, playersTableViewOrigin.y - defaultMargin);
    
    [_playersPaneLabel setFrame:CGRectMake(playerPaneLabelOrigin.x, playerPaneLabelOrigin.y, playerPaneLabelSize.width, playerPaneLabelSize.height)];
    
    NSMutableAttributedString *playerPaneLabelText = [[NSMutableAttributedString alloc] initWithString:@"Players"];
    [playerPaneLabelText addAttribute:NSFontAttributeName
                                value:[UIFont systemFontOfSize:20.0]
                                range:NSMakeRange(0, [playerPaneLabelText length])];
    [playerPaneLabelText addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [playerPaneLabelText length])];
    
    [_playersPaneLabel setAttributedText:playerPaneLabelText];
    
    
    
    
    CGPoint dataPickerViewOrigin = CGPointMake(_coordinateSystemView.frame.origin.x, defaultMargin + 75);
    CGSize dataPickerViewSize = CGSizeMake(200, 100);
    
    [_dataPickerView setFrame:CGRectMake(dataPickerViewOrigin.x, dataPickerViewOrigin.y, dataPickerViewSize.width, dataPickerViewSize.height)];
    [_dataPickerView setTag:CURVE_DATA_PICKERVIEW_TAG];
    _dataPickerView.showsSelectionIndicator = YES;
    _dataPickerView.layer.borderColor = [UIColor whiteColor].CGColor;
    _dataPickerView.layer.borderWidth = 1;
    [_dataPickerView selectRow:0 inComponent:0 animated:YES];
    
    
    CGSize dataSelectionLabelSize = CGSizeMake(170, 30);
    CGPoint dataSelectionLabelOrigin = CGPointMake(dataPickerViewOrigin.x, dataPickerViewOrigin.y - defaultMargin);
    [_dataSelectionLabel setFrame:CGRectMake(dataSelectionLabelOrigin.x, dataSelectionLabelOrigin.y, dataSelectionLabelSize.width, dataSelectionLabelSize.height)];
    
    NSMutableAttributedString *dataPaneLabelText = [[NSMutableAttributedString alloc] initWithString:@"Curve data source"];
    [dataPaneLabelText addAttribute:NSFontAttributeName
                                value:[UIFont systemFontOfSize:20.0]
                                range:NSMakeRange(0, [dataPaneLabelText length])];
    [dataPaneLabelText addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [dataPaneLabelText length])];
    
    [_dataSelectionLabel setAttributedText:dataPaneLabelText];
    
    
    CGSize periodPickerViewSize = CGSizeMake(200, 100);
    CGPoint periodPickerViewOrigin = CGPointMake(_coordinateSystemView.frame.origin.x + (_coordinateSystemView.frame.size.width / 2) - (periodPickerViewSize.width / 2) , defaultMargin + 75);
    
    [_periodPickerView setFrame:CGRectMake(periodPickerViewOrigin.x, periodPickerViewOrigin.y, periodPickerViewSize.width, periodPickerViewSize.height)];
    [_periodPickerView setTag:CURVE_PERIOD_PICKERVIEW_TAG];
    _periodPickerView.showsSelectionIndicator = YES;
    _periodPickerView.layer.borderColor = [UIColor whiteColor].CGColor;
    _periodPickerView.layer.borderWidth = 1;
    [_periodPickerView selectRow:0 inComponent:0 animated:YES];
    
    
    
    CGSize periodSelectionLabelSize = CGSizeMake(170, 30);
    CGPoint periodSelectionLabelOrigin = CGPointMake(periodPickerViewOrigin.x, periodPickerViewOrigin.y - defaultMargin);
    [_periodSelectionLabel setFrame:CGRectMake(periodSelectionLabelOrigin.x, periodSelectionLabelOrigin.y, periodSelectionLabelSize.width, periodSelectionLabelSize.height)];
    
    NSMutableAttributedString *periodPaneLabelText = [[NSMutableAttributedString alloc] initWithString:@"Curve period"];
    [periodPaneLabelText addAttribute:NSFontAttributeName
                              value:[UIFont systemFontOfSize:20.0]
                              range:NSMakeRange(0, [periodPaneLabelText length])];
    [periodPaneLabelText addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [periodPaneLabelText length])];
    
    [_periodSelectionLabel setAttributedText:periodPaneLabelText];
    
    
    CGSize stylePickerViewSize = CGSizeMake(200, 100);
    CGPoint stylePickerViewOrigin = CGPointMake(_coordinateSystemView.frame.origin.x + _coordinateSystemView.frame.size.width - periodPickerViewSize.width , defaultMargin + 75);
    
    [_stylePickerView setFrame:CGRectMake(stylePickerViewOrigin.x, stylePickerViewOrigin.y, stylePickerViewSize.width, stylePickerViewSize.height)];
    [_stylePickerView setTag:CURVE_STYLE_PICKERVIEW_TAG];
    _stylePickerView.showsSelectionIndicator = YES;
    _stylePickerView.layer.borderColor = [UIColor whiteColor].CGColor;
    _stylePickerView.layer.borderWidth = 1;
    [_stylePickerView selectRow:1 inComponent:0 animated:YES];
    
    CGSize styleSelectionLabelSize = CGSizeMake(170, 30);
    CGPoint styleSelectionLabelOrigin = CGPointMake(stylePickerViewOrigin.x, stylePickerViewOrigin.y - defaultMargin);
    [_styleSelectionLabel setFrame:CGRectMake(styleSelectionLabelOrigin.x, styleSelectionLabelOrigin.y, styleSelectionLabelSize.width, styleSelectionLabelSize.height)];
    
    NSMutableAttributedString *stylePaneLabelText = [[NSMutableAttributedString alloc] initWithString:@"Curve style"];
    [stylePaneLabelText addAttribute:NSFontAttributeName
                                value:[UIFont systemFontOfSize:20.0]
                                range:NSMakeRange(0, [stylePaneLabelText length])];
    [stylePaneLabelText addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [stylePaneLabelText length])];
    
    [_styleSelectionLabel setAttributedText:stylePaneLabelText];
    
    
    
    CGSize addPlayerToTrainingSize = CGSizeMake(50, 30);
    CGPoint addPlayerToTrainingOrigin = CGPointMake(playerPaneLabelOrigin.x + playerPaneLabelSize.width, playerPaneLabelOrigin.y);
    [_addPlayerButton setFrame:CGRectMake(addPlayerToTrainingOrigin.x, addPlayerToTrainingOrigin.y, addPlayerToTrainingSize.width, addPlayerToTrainingSize.height)];
    
    NSMutableAttributedString *addPlayerToTrainingButtonTitle = [[NSMutableAttributedString alloc] initWithString:@"New"];
    [addPlayerToTrainingButtonTitle addAttribute:NSFontAttributeName
                                           value:[UIFont systemFontOfSize:15.0]
                                           range:NSMakeRange(0, [addPlayerToTrainingButtonTitle length])];
    [addPlayerToTrainingButtonTitle addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:(0 / 255.f) green:(122 / 255.f) blue:(255 / 255.f) alpha:1.f] range:NSMakeRange(0, [addPlayerToTrainingButtonTitle length])];
    
    [_addPlayerButton setAttributedTitle:addPlayerToTrainingButtonTitle forState:UIControlStateNormal];
    
    CGSize removeSelectedPlayerButtonSize = CGSizeMake(80, 30);
    CGPoint removeSelectedPlayerButtonOrigin = CGPointMake(addPlayerToTrainingOrigin.x + addPlayerToTrainingSize.width, addPlayerToTrainingOrigin.y);
    [_removePlayerButton setFrame:CGRectMake(removeSelectedPlayerButtonOrigin.x, removeSelectedPlayerButtonOrigin.y, removeSelectedPlayerButtonSize.width, removeSelectedPlayerButtonSize.height)];
    
    NSMutableAttributedString *removeSelectedPlayerButtonTitle = [[NSMutableAttributedString alloc] initWithString:@"Remove"];
    [removeSelectedPlayerButtonTitle addAttribute:NSFontAttributeName
                                            value:[UIFont systemFontOfSize:15.0]
                                            range:NSMakeRange(0, [removeSelectedPlayerButtonTitle length])];
    [removeSelectedPlayerButtonTitle addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:(252 / 255.f) green:(61 / 255.f) blue:(57 / 255.f) alpha:1.f] range:NSMakeRange(0, [removeSelectedPlayerButtonTitle length])];
    
    [_removePlayerButton setAttributedTitle:removeSelectedPlayerButtonTitle forState:UIControlStateNormal];
}

- (void)layout
{
    [super layout];
    
    [self prepareForUse];
    
    [self addSubview:_playersPaneLabel];
    [self addSubview:_playersTableView];
    
    [self addSubview:_dataSelectionLabel];
    [self addSubview:_dataPickerView];
    
    [self addSubview:_periodSelectionLabel];
    [self addSubview:_periodPickerView];

    [self addSubview:_styleSelectionLabel];
    [self addSubview:_stylePickerView];
    
    [self addSubview:_coordinateSystemView];
    
    [self addSubview:_profilePhotoImageView];
    [self addSubview:_playerNameLabel];
    [self addSubview:_playerFirstNameLabel];
    [self addSubview:_playerLevelLabel];
    
    [self addSubview:_trainingsTableView];
    [self addSubview:_trainingsPaneLabel];
    
    [self addSubview:_addPlayerButton];
    [self addSubview:_removePlayerButton];
}

- (void)prepareForUse
{
    [self prepareView];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    
}

@end
