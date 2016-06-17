//
//  UIPlayerViewController.h
//  VirtualCoach
//
//  Created by Romain Dubreucq on 15/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "UIBaseViewController.h"
#import "UIPlayerView.h"

#define CURVE_DATA_PICKERVIEW_TAG 1
#define CURVE_PERIOD_PICKERVIEW_TAG 2
#define CURVE_STYLE_PICKERVIEW_TAG 3

@interface UIPlayerViewController : UIBaseViewController <UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIPlayerView *playerView;

@property (nonatomic, strong) NSMutableArray *curveDataPickerViewData;
@property (nonatomic, strong) NSMutableArray *curvePeriodPickerViewData;
@property (nonatomic, strong) NSMutableArray *curveStylePickerViewData;

@end
