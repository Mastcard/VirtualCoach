//
//  UIPlayerView.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 14/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "UIPlayerView.h"
#import "UIPlayerViewController.h"

@implementation UIPlayerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        //temp
        _curvesView = [[UIBaseView alloc] init];
        
        _playersPaneLabel = [[UIBaseLabel alloc] init];
        _playersTableView = [[UITableView alloc] init];
        
        _dataSelectionLabel = [[UIBaseLabel alloc] init];
        _dataPickerView = [[UIPickerView alloc] init];
        
        _periodSelectionLabel = [[UIBaseLabel alloc] init];
        _periodPickerView = [[UIPickerView alloc] init];
        
        _styleSelectionLabel = [[UIBaseLabel alloc] init];
        _stylePickerView = [[UIPickerView alloc] init];
    }
    
    return self;
}

- (void)prepareView
{
    CGFloat defaultMargin = 40.f;
    
    CGSize curvesViewSize = CGSizeMake(700, 470);
    CGPoint curvesViewOrigin = CGPointMake(self.frame.size.width - (defaultMargin + curvesViewSize.width), self.frame.size.height - (defaultMargin + curvesViewSize.height));
    [_curvesView setFrame:CGRectMake(curvesViewOrigin.x, curvesViewOrigin.y, curvesViewSize.width, curvesViewSize.height)];
    [_curvesView setBackgroundColor:[UIColor darkGrayColor]];
    
    CGPoint playersTableViewOrigin = CGPointMake(defaultMargin, defaultMargin + 75);
    CGSize playersTableViewSize = CGSizeMake(200, 200);
    
    [_playersTableView setFrame:CGRectMake(playersTableViewOrigin.x, playersTableViewOrigin.y, playersTableViewSize.width, playersTableViewSize.height)];
    [_playersTableView setScrollEnabled:YES];
    [_playersTableView setBackgroundColor:[UIColor clearColor]];
    _playersTableView.layer.borderColor = [UIColor whiteColor].CGColor;
    _playersTableView.layer.borderWidth = 1.0f;
    
    
    CGSize playerPaneLabelSize = CGSizeMake(150, 30);
    CGPoint playerPaneLabelOrigin = CGPointMake(playersTableViewOrigin.x, playersTableViewOrigin.y - defaultMargin);
    [_playersPaneLabel setFrame:CGRectMake(playerPaneLabelOrigin.x, playerPaneLabelOrigin.y, playerPaneLabelSize.width, playerPaneLabelSize.height)];
    
    NSMutableAttributedString *playerPaneLabelText = [[NSMutableAttributedString alloc] initWithString:@"Players"];
    [playerPaneLabelText addAttribute:NSFontAttributeName
                               value:[UIFont systemFontOfSize:20.0]
                               range:NSMakeRange(0, [playerPaneLabelText length])];
    [playerPaneLabelText addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [playerPaneLabelText length])];
    
    [_playersPaneLabel setAttributedText:playerPaneLabelText];
    
    CGPoint dataPickerViewOrigin = CGPointMake(_curvesView.frame.origin.x, defaultMargin + 75);
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
    CGPoint periodPickerViewOrigin = CGPointMake(_curvesView.frame.origin.x + (_curvesView.frame.size.width / 2) - (periodPickerViewSize.width / 2) , defaultMargin + 75);
    
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
    CGPoint stylePickerViewOrigin = CGPointMake(_curvesView.frame.origin.x + _curvesView.frame.size.width - periodPickerViewSize.width , defaultMargin + 75);
    
    [_stylePickerView setFrame:CGRectMake(stylePickerViewOrigin.x, stylePickerViewOrigin.y, stylePickerViewSize.width, stylePickerViewSize.height)];
    [_stylePickerView setTag:CURVE_STYLE_PICKERVIEW_TAG];
    _stylePickerView.showsSelectionIndicator = YES;
    _stylePickerView.layer.borderColor = [UIColor whiteColor].CGColor;
    _stylePickerView.layer.borderWidth = 1;
    [_stylePickerView selectRow:0 inComponent:0 animated:YES];
    
    CGSize styleSelectionLabelSize = CGSizeMake(170, 30);
    CGPoint styleSelectionLabelOrigin = CGPointMake(stylePickerViewOrigin.x, stylePickerViewOrigin.y - defaultMargin);
    [_styleSelectionLabel setFrame:CGRectMake(styleSelectionLabelOrigin.x, styleSelectionLabelOrigin.y, styleSelectionLabelSize.width, styleSelectionLabelSize.height)];
    
    NSMutableAttributedString *stylePaneLabelText = [[NSMutableAttributedString alloc] initWithString:@"Curve style"];
    [stylePaneLabelText addAttribute:NSFontAttributeName
                                value:[UIFont systemFontOfSize:20.0]
                                range:NSMakeRange(0, [stylePaneLabelText length])];
    [stylePaneLabelText addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [stylePaneLabelText length])];
    
    [_styleSelectionLabel setAttributedText:stylePaneLabelText];
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
    
    [self addSubview:_curvesView];
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
