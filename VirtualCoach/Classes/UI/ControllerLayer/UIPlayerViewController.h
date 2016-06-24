//
//  UIPlayerViewController.h
//  VirtualCoach
//
//  Created by Romain Dubreucq on 15/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "UIBaseViewController.h"
#import "UIPlayerView.h"
#import "CoordinateSystem2D.h"
#import "Axis.h"
#import "UICoordinateSystemFactory.h"
#import "UICoordinateSystem2DUtilities.h"
#import "DateUtilities.h"
#import "StatisticalDataEngine.h"
#import "NSOrderedDictionary.h"
#import "StatisticalDataEngineTools.h"
#import "Variables.h"

#define CURVE_DATA_PICKERVIEW_TAG 1
#define CURVE_PERIOD_PICKERVIEW_TAG 2
#define CURVE_STYLE_PICKERVIEW_TAG 3

@interface UIPlayerViewController : UIBaseViewController <UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIPlayerView *playerView;

@property (nonatomic, strong) NSMutableArray *curveDataPickerViewData;
@property (nonatomic, strong) NSMutableArray *curvePeriodPickerViewData;
@property (nonatomic, strong) NSMutableArray *curveStylePickerViewData;

@property (nonatomic, strong) NSMutableArray *trainingsTableViewData;
@property (nonatomic, strong) NSMutableArray *playersTableViewData;

@property (nonatomic, strong) UIPinchGestureRecognizer *curvesViewPinchGestureRecognizer;
@property (nonatomic, strong) UISwipeGestureRecognizer *curvesViewLeftSwipeGestureRecognizer;
@property (nonatomic, strong) UISwipeGestureRecognizer *curvesViewRightSwipeGestureRecognizer;

- (void)twoFingerPinchOnCurveView:(UIPinchGestureRecognizer *)pinchGestureRecognizer;
- (void)swipeGestureRecognizerOnCurveView:(UISwipeGestureRecognizer *)swipeGestureRecognizer;

- (void)addPlayerButtonAction;
- (void)addPlayerWizardButtonAction;

- (void)removePlayerButtonAction;

@end
