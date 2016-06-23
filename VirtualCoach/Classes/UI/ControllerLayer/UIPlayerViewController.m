//
//  UIPlayerViewController.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 15/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "UIPlayerViewController.h"
#import "UITrainingViewController.h"

@interface UIPlayerViewController ()

@property (nonatomic) NSInteger currentDay;
@property (nonatomic) NSInteger currentMonth;
@property (nonatomic) NSInteger currentYear;
@property (nonatomic) NSInteger currentWeekStartDay;
@property (nonatomic) NSInteger currentWeekEndDay;

@property (nonatomic, strong) NSArray *currentOrdinateAxisTitles;

@property (nonatomic, strong) UICurve *drawnCurve;

@property (nonatomic, strong) NSMutableArray<StatisticalDO*> *statistics;

@property (nonatomic, assign) int currentPlayerId;

@end

@implementation UIPlayerViewController

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        _playerView = [[UIPlayerView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        
        _curveDataPickerViewData = [[NSMutableArray alloc] initWithObjects:@"Forehands", @"Backhands", @"Services", @"Forehands (progress)", @"Backhands (progress)", @"Services (progress)", nil];
        
        _curvePeriodPickerViewData = [[NSMutableArray alloc] initWithObjects:@"Weekly", @"Monthly", @"Yearly", nil];
        
        _curveStylePickerViewData = [[NSMutableArray alloc] initWithObjects:@"Plots", @"Curves", @"Both", nil];
        
        [_playerView.dataPickerView setDelegate:self];
        [_playerView.dataPickerView setDataSource:self];
        
        [_playerView.periodPickerView setDelegate:self];
        [_playerView.periodPickerView setDataSource:self];
        
        [_playerView.stylePickerView setDelegate:self];
        [_playerView.stylePickerView setDataSource:self];
        
        [_playerView.playersTableView setDelegate:self];
        [_playerView.playersTableView setDataSource:self];
        
        [_playerView.trainingsTableView setDelegate:self];
        [_playerView.trainingsTableView setDataSource:self];
        
        self.view = _playerView;
        
        self.navigationItem.title = @"Players";
    }
    
    return self;
}

- (void)prepareForUse
{
    Axis *weeklyAxis = [Axis weeklyAxis];
    
    Axis *motionCountAxis = [Axis motionCountAxis];
    
    CoordinateSystem2D *weeklyCoordinateSystem = [[CoordinateSystem2D alloc] init];
    
    [weeklyCoordinateSystem.axes setObject:weeklyAxis forKey:@"absciss"];
    [weeklyCoordinateSystem.axes setObject:motionCountAxis forKey:@"ordinate"];
    
    [weeklyCoordinateSystem prepare];
    
    [_playerView.coordinateSystemView setCoordinateSystem:weeklyCoordinateSystem];
    
    [_playerView layout];
    
    _playerView.coordinateSystemView.abscissAxis.titles = [DateUtilities dayTitles];
    _currentOrdinateAxisTitles = [NSArray arrayWithObjects:@"100", @"200", @"300", @"400", @"500", @"600", @"700", @"800", @"900", @"1000", nil];
    _playerView.coordinateSystemView.ordinateAxis.titles = _currentOrdinateAxisTitles;
    
    NSInteger day = [DateUtilities currentDay];
    NSInteger month = [DateUtilities currentMonth];
    NSInteger year = [DateUtilities currentYear];
    
    _currentDay = day;
    _currentMonth = month;
    _currentYear = year;
    
    NSDate *selectedDate = [DateUtilities dateWithYear:year month:month day:day];
    NSDictionary *weekStartAndEndDates = [DateUtilities startAndEndDateOfWeekForDate:selectedDate];
    
    NSDate *startDate = [weekStartAndEndDates objectForKey:@"startDate"];
    NSDate *endDate = [weekStartAndEndDates objectForKey:@"endDate"];
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:startDate];
    _currentWeekStartDay = [components day];
    NSInteger currentWeekStartMonth = [components month];
    NSInteger currentWeekStartYear = [components year];
    components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:endDate];
    _currentWeekEndDay = [components day];
    NSInteger currentWeekEndMonth = [components month];
    NSInteger currentWeekEndYear = [components year];
    
    NSLog(@"_currentWeekStartDay : %ld, _currentWeekEndDay : %ld", (long)_currentWeekStartDay, (long)_currentWeekEndDay);
    
    // get the player id here
    int playerId = 1;
    
    StatisticalDataEngine *statsDataEngine = [[StatisticalDataEngine alloc] init];
    
    _statistics = [statsDataEngine searchFromDay:(int)_currentWeekStartDay andMonth:(int)currentWeekStartMonth andYear:(int)currentWeekStartYear toDay:(int)_currentWeekEndDay andMonth:(int)currentWeekEndMonth andYear:(int)currentWeekEndYear forPlayerId:playerId];
    
    NSMutableArray *finalDatasource = [StatisticalDataEngineTools selectForehandCountsFromResult:_statistics];
    
    Curve *curve = [[Curve alloc] init];
    
    curve.values = [NSOrderedDictionary dictionaryWithObjects:finalDatasource forKeys:
                    _playerView.coordinateSystemView.abscissAxis.titles];
    
    
    UICurve *uicurve = [[UICurve alloc] initWithFrame:CGRectZero curve:curve];
    uicurve.lineColor = [UIColor whiteColor];
    uicurve.drawPoints = NO;
    uicurve.lineWidth = [NSNumber numberWithFloat:0.5];
    
    _drawnCurve = uicurve;
    
    
    
    [_playerView.coordinateSystemView setCoordinateSystemTitle:[NSString stringWithFormat:@"%@ - %@", [DateUtilities stringWithDate:startDate], [DateUtilities stringWithDate:endDate]]];
    
    [_playerView.coordinateSystemView draw];
    
    [_playerView.coordinateSystemView drawCurve:uicurve];
}

- (void)viewWillAppear:(BOOL)animated
{
    // set table view controller datas
    
    _trainingsTableViewData = [NSMutableArray arrayWithObjects:@"Training1", @"Training2", @"Training3", @"Training4", @"Training5", @"Training6", @"Training7", @"Training8", @"Training9", @"Training10", @"Training11", @"Training12", nil];
    _playersTableViewData = [NSMutableArray arrayWithObjects:@"Joe", @"David", @"Luke", @"Steve P", @"Jeffrey", nil];
    
    _curvesViewPinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(twoFingerPinchOnCurveView:)];
    _curvesViewPinchGestureRecognizer.scale = 1;
    
    _curvesViewLeftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureRecognizerOnCurveView:)];
    _curvesViewLeftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    _curvesViewLeftSwipeGestureRecognizer.numberOfTouchesRequired = 1;
    
    _curvesViewRightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureRecognizerOnCurveView:)];
    _curvesViewRightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    _curvesViewRightSwipeGestureRecognizer.numberOfTouchesRequired = 1;
    
    
    [_playerView.coordinateSystemView addGestureRecognizer:_curvesViewPinchGestureRecognizer];
    [_playerView.coordinateSystemView addGestureRecognizer:_curvesViewLeftSwipeGestureRecognizer];
    [_playerView.coordinateSystemView addGestureRecognizer:_curvesViewRightSwipeGestureRecognizer];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger numberOfRows = -1;
    
    if (pickerView.tag == CURVE_DATA_PICKERVIEW_TAG)
        numberOfRows = [_curveDataPickerViewData count];
    
    else if (pickerView.tag == CURVE_PERIOD_PICKERVIEW_TAG)
        numberOfRows = [_curvePeriodPickerViewData count];
    
    else if (pickerView.tag == CURVE_STYLE_PICKERVIEW_TAG)
        numberOfRows = [_curveStylePickerViewData count];
    
    return numberOfRows;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView.tag == CURVE_DATA_PICKERVIEW_TAG)
    {
        NSLog(@"You selected this: %@", [_curveDataPickerViewData objectAtIndex:row]);
        
        NSString *selectedValue = [_curveDataPickerViewData objectAtIndex:row];
        
        Axis *ordinateAxis = nil;
        NSArray *data = nil;
        
        if ([selectedValue rangeOfString:@"progress"].location == NSNotFound)
        {
            ordinateAxis = [Axis motionCountAxis];
            
            _currentOrdinateAxisTitles = [NSArray arrayWithObjects:@"100", @"200", @"300", @"400", @"500", @"600", @"700", @"800", @"900", @"1000", nil];
            
            if ([selectedValue isEqualToString:@"Forehands"])
                data = [StatisticalDataEngineTools selectForehandCountsFromResult:_statistics];
            
            else if ([selectedValue isEqualToString:@"Backhands"])
                data = [StatisticalDataEngineTools selectBackhandCountsFromResult:_statistics];
            
            else if ([selectedValue isEqualToString:@"Services"])
                data = [StatisticalDataEngineTools selectServiceCountsFromResult:_statistics];
        }
        
        else
        {
            ordinateAxis = [Axis progressAxis];
            
            _currentOrdinateAxisTitles = [NSArray arrayWithObjects:@"10%", @"20%", @"30%", @"40%", @"50%", @"60%", @"70%", @"80%", @"90%", @"100%", nil];
            
            if ([selectedValue isEqualToString:@"Forehands (progress)"])
                data = [StatisticalDataEngineTools selectForehandProgressFromResult:_statistics];
            
            else if ([selectedValue isEqualToString:@"Backhands (progress)"])
                data = [StatisticalDataEngineTools selectBackhandProgressFromResult:_statistics];
            
            else if ([selectedValue isEqualToString:@"Services (progress)"])
                data = [StatisticalDataEngineTools selectServiceProgressFromResult:_statistics];
        }
        
        Curve *curve = [[Curve alloc] init];
        
        curve.values = [NSOrderedDictionary dictionaryWithObjects:data forKeys:
                        _playerView.coordinateSystemView.abscissAxis.titles];
        
        [_playerView.coordinateSystemView.coordinateSystem.axes setObject:ordinateAxis forKey:@"ordinate"];
        
        _playerView.coordinateSystemView.ordinateAxis.titles = _currentOrdinateAxisTitles;
        
        [_playerView.coordinateSystemView refreshCoordinateSystem];
        
        [_playerView.coordinateSystemView undraw];
        [_drawnCurve undraw];
        [_drawnCurve setCurve:curve];
        [_playerView.coordinateSystemView drawCurve:_drawnCurve];
        [_playerView.coordinateSystemView draw];
    }
    
    else if (pickerView.tag == CURVE_PERIOD_PICKERVIEW_TAG)
    {
        Axis *axis = [_playerView.coordinateSystemView.coordinateSystem.axes objectForKey:@"absciss"];
        NSArray *titles = _playerView.coordinateSystemView.abscissAxis.titles;
        NSString *coordinateSystemTitle = nil;
        
        StatisticalDataEngine *statsDataEngine = [[StatisticalDataEngine alloc] init];
        
        if ([[_curvePeriodPickerViewData objectAtIndex:row] isEqualToString:@"Weekly"])
        {
            NSDate *selectedDate = [DateUtilities dateWithYear:_currentYear month:_currentMonth day:_currentDay];
            NSDictionary *weekStartAndEndDates = [DateUtilities startAndEndDateOfWeekForDate:selectedDate];
            
            NSDate *startDate = [weekStartAndEndDates objectForKey:@"startDate"];
            NSDate *endDate = [weekStartAndEndDates objectForKey:@"endDate"];
            
            NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:startDate];
            _currentWeekStartDay = [components day];
            NSInteger currentWeekStartMonth = [components month];
            NSInteger currentWeekStartYear = [components year];
            components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:endDate];
            _currentWeekEndDay = [components day];
            NSInteger currentWeekEndMonth = [components month];
            NSInteger currentWeekEndYear = [components year];
            
            axis = [Axis weeklyAxis];
            titles = [DateUtilities dayTitles];
            coordinateSystemTitle = [NSString stringWithFormat:@"%@ - %@", [DateUtilities stringWithDate:startDate], [DateUtilities stringWithDate:endDate]];
            
            _statistics = [statsDataEngine searchFromDay:(int)_currentWeekStartDay andMonth:(int)currentWeekStartMonth andYear:(int)currentWeekStartYear toDay:(int)_currentWeekEndDay andMonth:(int)currentWeekEndMonth andYear:(int)currentWeekEndYear forPlayerId:1];
        }
        
        else if ([[_curvePeriodPickerViewData objectAtIndex:row] isEqualToString:@"Monthly"])
        {
            axis = [Axis monthlyAxisForMonth:_currentMonth];
            titles = [DateUtilities dayTitlesForMonth:_currentMonth];
            coordinateSystemTitle = [DateUtilities monthFullTitle:_currentMonth forYear:_currentYear];
            
            _statistics = [statsDataEngine searchByMonth:(int)_currentMonth andYear:(int)_currentYear andPlayerId:1];
        }
        
        else if ([[_curvePeriodPickerViewData objectAtIndex:row] isEqualToString:@"Yearly"])
        {
            axis = [Axis yearlyAxis];
            titles = [DateUtilities monthTitles];
            coordinateSystemTitle = [DateUtilities yearFullTitle:_currentYear];
            
            _statistics = [statsDataEngine searchByYear:(int)_currentYear andPlayerId:1];
        }
        
        NSArray *data = nil;
        
        NSInteger row = [_playerView.dataPickerView selectedRowInComponent:0];
        NSString *selectedDataSource = [_curveDataPickerViewData objectAtIndex:row];
        
        if ([selectedDataSource rangeOfString:@"progress"].location == NSNotFound)
        {
            if ([selectedDataSource isEqualToString:@"Forehands"])
                data = [StatisticalDataEngineTools selectForehandCountsFromResult:_statistics];
            
            else if ([selectedDataSource isEqualToString:@"Backhands"])
                data = [StatisticalDataEngineTools selectBackhandCountsFromResult:_statistics];
            
            else if ([selectedDataSource isEqualToString:@"Services"])
                data = [StatisticalDataEngineTools selectServiceCountsFromResult:_statistics];
        }
        
        else
        {
            if ([selectedDataSource isEqualToString:@"Forehands (progress)"])
                data = [StatisticalDataEngineTools selectForehandProgressFromResult:_statistics];
            
            else if ([selectedDataSource isEqualToString:@"Backhands (progress)"])
                data = [StatisticalDataEngineTools selectBackhandProgressFromResult:_statistics];
            
            else if ([selectedDataSource isEqualToString:@"Services (progress)"])
                data = [StatisticalDataEngineTools selectServiceProgressFromResult:_statistics];
        }
        
        Curve *curve = [[Curve alloc] init];
        curve.values = [NSOrderedDictionary dictionaryWithObjects:data forKeys:titles];
        
        
        [_playerView.coordinateSystemView.coordinateSystem.axes setObject:axis forKey:@"absciss"];
        
        [_playerView.coordinateSystemView refreshCoordinateSystem];
        
        _playerView.coordinateSystemView.abscissAxis.titles = titles;
        
        [_playerView.coordinateSystemView undraw];
        
        [_playerView.coordinateSystemView setCoordinateSystemTitle:coordinateSystemTitle];
        
        [_drawnCurve undraw];
        [_drawnCurve setCurve:curve];
        [_playerView.coordinateSystemView drawCurve:_drawnCurve];
        
        [_playerView.coordinateSystemView draw];
    }
    
    
    else if (pickerView.tag == CURVE_STYLE_PICKERVIEW_TAG)
    {
        NSMutableArray *drawnCurvesArray = [NSMutableArray array];
        
        BOOL drawPoints = NO;
        BOOL drawLine = NO;
        
        for (UIView *subview in _playerView.coordinateSystemView.subviews)
        {
            if ([subview isMemberOfClass:[UICurve class]])
                [drawnCurvesArray addObject:subview];
        }
        
        if ([[_curveStylePickerViewData objectAtIndex:row] isEqualToString:@"Plots"])
        {
            drawPoints = YES;
            drawLine = NO;
        }
        
        
        else if ([[_curveStylePickerViewData objectAtIndex:row] isEqualToString:@"Curves"])
        {
            drawPoints = NO;
            drawLine = YES;
        }
        
        else if ([[_curveStylePickerViewData objectAtIndex:row] isEqualToString:@"Both"])
        {
            drawPoints = YES;
            drawLine = YES;
        }
        
        for (UICurve *curve in drawnCurvesArray)
        {
            [_playerView.coordinateSystemView removeCurve:curve];
            [curve undraw];
            curve.drawLine = drawLine;
            curve.drawPoints = drawPoints;
            [_playerView.coordinateSystemView drawCurve:curve];
        }
    }
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    NSString *rowItem = @"";
    
    if (pickerView.tag == CURVE_DATA_PICKERVIEW_TAG)
        rowItem = [_curveDataPickerViewData objectAtIndex:row];
    
    else if (pickerView.tag == CURVE_PERIOD_PICKERVIEW_TAG)
        rowItem = [_curvePeriodPickerViewData objectAtIndex:row];
    
    else if (pickerView.tag == CURVE_STYLE_PICKERVIEW_TAG)
        rowItem = [_curveStylePickerViewData objectAtIndex:row];
    
    UILabel *lblRow = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [pickerView bounds].size.width, 44.0f)];
    [lblRow setTextAlignment:NSTextAlignmentCenter];
    [lblRow setTextColor: [UIColor whiteColor]];
    [lblRow setText:rowItem];
    [lblRow setBackgroundColor:[UIColor clearColor]];
    
    return lblRow;
}


//

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *cellText = cell.textLabel.text;
    
    
    if (tableView.tag == TRAININGS_TABLEVIEW_TAG)
    {
        
    }
    
    else if (tableView.tag == PLAYERS_TABLEVIEW_TAG)
    {
        NSDictionary *attributes = [(NSAttributedString *)_playerView.playerNameLabel.attributedText attributesAtIndex:0 effectiveRange:NULL];
        _playerView.playerNameLabel.attributedText = [[NSAttributedString alloc] initWithString:cellText attributes:attributes];
        
        NSDate *selectedDate = [DateUtilities dateWithYear:_currentYear month:_currentMonth day:_currentDay];
        
        NSDictionary *weekStartAndEndDates = [DateUtilities startAndEndDateOfWeekForDate:selectedDate];
        
        NSDate *startDate = [weekStartAndEndDates objectForKey:@"startDate"];
        NSDate *endDate = [weekStartAndEndDates objectForKey:@"endDate"];
        
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:startDate];
        _currentWeekStartDay = [components day];
        NSInteger currentWeekStartMonth = [components month];
        NSInteger currentWeekStartYear = [components year];
        components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:endDate];
        _currentWeekEndDay = [components day];
        NSInteger currentWeekEndMonth = [components month];
        NSInteger currentWeekEndYear = [components year];
        
        int playerId = 1;
        
        StatisticalDataEngine *statsDataEngine = [[StatisticalDataEngine alloc] init];
        
        _statistics = [statsDataEngine searchFromDay:(int)_currentWeekStartDay andMonth:(int)currentWeekStartMonth andYear:(int)currentWeekStartYear toDay:(int)_currentWeekEndDay andMonth:(int)currentWeekEndMonth andYear:(int)currentWeekEndYear forPlayerId:playerId];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRows = -1;
    
    if (tableView.tag == TRAININGS_TABLEVIEW_TAG)
        numberOfRows = _trainingsTableViewData.count;
    
    else if (tableView.tag == PLAYERS_TABLEVIEW_TAG)
        numberOfRows = _playersTableViewData.count;
    
    return numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell)
        cell = nil;
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        [cell.textLabel setTextColor:[UIColor whiteColor]];
        [cell.detailTextLabel setTextColor:[UIColor whiteColor]];
        [cell.detailTextLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [cell.detailTextLabel setNumberOfLines:0];
        [cell setBackgroundColor:[UIColor clearColor]];
    }
    
    if (tableView.tag == TRAININGS_TABLEVIEW_TAG)
    {
        [cell.textLabel setText:[_trainingsTableViewData objectAtIndex:indexPath.row]];
        [cell.detailTextLabel setText:@"Date: 00/00/9999\nLocation: Cergy-Pontoise"];
    }
    
    else if (tableView.tag == PLAYERS_TABLEVIEW_TAG)
    {
        [cell.textLabel setText:[_playersTableViewData objectAtIndex:indexPath.row]];
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 44.f;
    
    if (tableView.tag == TRAININGS_TABLEVIEW_TAG)
    {
        height += 40;
    }
    
    else if (tableView.tag == PLAYERS_TABLEVIEW_TAG)
    {
        height += 30;
    }
    
    return height;
}

- (void)twoFingerPinchOnCurveView:(UIPinchGestureRecognizer *)pinchGestureRecognizer
{
    CGPoint point = [pinchGestureRecognizer locationInView:_playerView.coordinateSystemView];
    
    BOOL isYearlyCoordinateSystem = _playerView.coordinateSystemView.abscissAxis.titles.count == 12 ? YES : NO;
    BOOL isWeeklyCoordinateSystem = _playerView.coordinateSystemView.abscissAxis.titles.count == 7 ? YES : NO;
    BOOL isMonthlyCoordinateSystem = _playerView.coordinateSystemView.abscissAxis.titles.count != 12 && _playerView.coordinateSystemView.abscissAxis.titles.count != 7 ? YES : NO;
    
    if (pinchGestureRecognizer.state == UIGestureRecognizerStateEnded)
    {
        Axis *axis = [_playerView.coordinateSystemView.coordinateSystem.axes objectForKey:@"absciss"];
        NSArray *titles = _playerView.coordinateSystemView.abscissAxis.titles;
        NSString *coordinateSystemTitle = nil;
        NSInteger futureSelectedRow = -1;
        
        NSArray *data = nil;
        
        StatisticalDataEngine *statsDataEngine = [[StatisticalDataEngine alloc] init];
        
        if (pinchGestureRecognizer.scale > 1)   // pinch out
        {
            NSString *winningTitle = [UICoordinateSystem2DUtilities titleForTouchLocation:point inCoordinateSystem:_playerView.coordinateSystemView];
            
            if (isYearlyCoordinateSystem) // if yearly coordinate system is displayed (yearly => monthly)
            {
                // do some stuff with curves, the following just changes the coordinate system
                
                _currentMonth = [DateUtilities monthForTitle:winningTitle];
                
                axis = [Axis monthlyAxisForMonth:_currentMonth];
                titles = [DateUtilities dayTitlesForMonth:_currentMonth];
                coordinateSystemTitle = [DateUtilities monthFullTitle:_currentMonth forYear:_currentYear];
                
                futureSelectedRow = 1;
                
                _statistics = [statsDataEngine searchByMonth:(int)_currentMonth andYear:(int)_currentYear andPlayerId:1];
            }
            
            else if (isMonthlyCoordinateSystem) // if monthly coordinate system is displayed (monthly => weekly)
            {
                // do some stuff with curves, the following just changes the coordinate system
                
                // find week start and end date
                
                _currentDay = [winningTitle intValue];
                
                NSDate *selectedDate = [DateUtilities dateWithYear:_currentYear month:_currentMonth day:_currentDay];
                NSDictionary *weekStartAndEndDates = [DateUtilities startAndEndDateOfWeekForDate:selectedDate];
                
                NSDate *startDate = [weekStartAndEndDates objectForKey:@"startDate"];
                NSDate *endDate = [weekStartAndEndDates objectForKey:@"endDate"];
                
                NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:startDate];
                _currentWeekStartDay = [components day];
                NSInteger currentWeekStartMonth = [components month];
                NSInteger currentWeekStartYear = [components year];
                components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:endDate];
                _currentWeekEndDay = [components day];
                NSInteger currentWeekEndMonth = [components month];
                NSInteger currentWeekEndYear = [components year];
                
                axis = [Axis weeklyAxis];
                titles = [DateUtilities dayTitles];
                coordinateSystemTitle = [NSString stringWithFormat:@"%@ - %@", [DateUtilities stringWithDate:startDate], [DateUtilities stringWithDate:endDate]];
                
                futureSelectedRow = 0;
                
                _statistics = [statsDataEngine searchFromDay:(int)_currentWeekStartDay andMonth:(int)currentWeekStartMonth andYear:(int)currentWeekStartYear toDay:(int)_currentWeekEndDay andMonth:(int)currentWeekEndMonth andYear:(int)currentWeekEndYear forPlayerId:1];
            }
        }
        
        else    // pinch in
        {
            if (isWeeklyCoordinateSystem) // if weekly coordinate system is displayed (weekly => monthly)
            {
                // do some stuff with curves, the following just changes the coordinate system
                
                axis = [Axis monthlyAxisForMonth:_currentMonth];
                titles = [DateUtilities dayTitlesForMonth:_currentMonth];
                coordinateSystemTitle = [DateUtilities monthFullTitle:_currentMonth forYear:_currentYear];
                
                futureSelectedRow = 1;
                
                _statistics = [statsDataEngine searchByMonth:(int)_currentMonth andYear:(int)_currentYear andPlayerId:1];
            }
            
            else if (isMonthlyCoordinateSystem) // if monthly coordinate system is displayed (monthly => yearly)
            {
                // do some stuff with curves, the following just changes the coordinate system
                
                axis = [Axis yearlyAxis];
                titles = [DateUtilities monthTitles];
                coordinateSystemTitle = [DateUtilities yearFullTitle:_currentYear];
                
                futureSelectedRow = 2;
                
                _statistics = [statsDataEngine searchByYear:(int)_currentYear andPlayerId:1];
            }
        }
        
        NSInteger row = [_playerView.dataPickerView selectedRowInComponent:0];
        NSString *selectedDataSource = [_curveDataPickerViewData objectAtIndex:row];
        
        if ([selectedDataSource rangeOfString:@"progress"].location == NSNotFound)
        {
            if ([selectedDataSource isEqualToString:@"Forehands"])
                data = [StatisticalDataEngineTools selectForehandCountsFromResult:_statistics];
            
            else if ([selectedDataSource isEqualToString:@"Backhands"])
                data = [StatisticalDataEngineTools selectBackhandCountsFromResult:_statistics];
            
            else if ([selectedDataSource isEqualToString:@"Services"])
                data = [StatisticalDataEngineTools selectServiceCountsFromResult:_statistics];
        }
        
        else
        {
            if ([selectedDataSource isEqualToString:@"Forehands (progress)"])
                data = [StatisticalDataEngineTools selectForehandProgressFromResult:_statistics];
            
            else if ([selectedDataSource isEqualToString:@"Backhands (progress)"])
                data = [StatisticalDataEngineTools selectBackhandProgressFromResult:_statistics];
            
            else if ([selectedDataSource isEqualToString:@"Services (progress)"])
                data = [StatisticalDataEngineTools selectServiceProgressFromResult:_statistics];
        }
        
        Curve *curve = [[Curve alloc] init];
        curve.values = [NSOrderedDictionary dictionaryWithObjects:data forKeys:titles];
        
        
        [_playerView.coordinateSystemView.coordinateSystem.axes setObject:axis forKey:@"absciss"];
        
        [_playerView.coordinateSystemView refreshCoordinateSystem];
        
        _playerView.coordinateSystemView.abscissAxis.titles = titles;
        
        [_playerView.coordinateSystemView undraw];
        
        [_playerView.coordinateSystemView setCoordinateSystemTitle:coordinateSystemTitle];
        
        [_drawnCurve undraw];
        [_drawnCurve setCurve:curve];
        [_playerView.coordinateSystemView drawCurve:_drawnCurve];
        
        [_playerView.coordinateSystemView draw];
    }
}

- (void)swipeGestureRecognizerOnCurveView:(UISwipeGestureRecognizer *)swipeGestureRecognizer;
{
    BOOL isYearlyCoordinateSystem = _playerView.coordinateSystemView.abscissAxis.titles.count == 12 ? YES : NO;
    BOOL isWeeklyCoordinateSystem = _playerView.coordinateSystemView.abscissAxis.titles.count == 7 ? YES : NO;
    BOOL isMonthlyCoordinateSystem = _playerView.coordinateSystemView.abscissAxis.titles.count != 12 && _playerView.coordinateSystemView.abscissAxis.titles.count != 7 ? YES : NO;
    
    if (swipeGestureRecognizer.state == UIGestureRecognizerStateEnded)
    {
        Axis *axis = [_playerView.coordinateSystemView.coordinateSystem.axes objectForKey:@"absciss"];
        NSArray *titles = _playerView.coordinateSystemView.abscissAxis.titles;
        NSString *coordinateSystemTitle = nil;
        
        StatisticalDataEngine *statsDataEngine = [[StatisticalDataEngine alloc] init];
        
        NSArray *data = nil;
        
        if (swipeGestureRecognizer == _curvesViewLeftSwipeGestureRecognizer) // left swipe (we go in the future)
        {
            NSLog(@"Left swipe");
            
            if (isWeeklyCoordinateSystem) // some bugs when we change the year
            {
                NSDate *startDate = [DateUtilities dateWithYear:_currentYear month:_currentMonth day:_currentWeekStartDay];
                
                NSCalendar *cal = [NSCalendar currentCalendar];
                NSDate *tomorrow = [cal dateByAddingUnit:NSCalendarUnitDay
                                                   value:7
                                                  toDate:startDate
                                                 options:0];
                
                NSDictionary *startAndEndOfWeekDates = [DateUtilities startAndEndDateOfWeekForDate:tomorrow];
                
                NSDate *nextStartDate = [startAndEndOfWeekDates objectForKey:@"startDate"];
                NSDate *nextEndDate = [startAndEndOfWeekDates objectForKey:@"endDate"];
                
                NSLog(@"nextStartDate : %@, nextEndDate : %@", nextStartDate, nextEndDate);
                
                NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:nextStartDate];
                _currentYear = [components year];
                _currentMonth = [components month];
                _currentWeekStartDay = [components day];
                NSInteger currentWeekStartMonth = [components month];
                NSInteger currentWeekStartYear = [components year];
                components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:nextEndDate];
                _currentWeekEndDay = [components day];
                NSInteger currentWeekEndMonth = [components month];
                NSInteger currentWeekEndYear = [components year];
                
                coordinateSystemTitle = [NSString stringWithFormat:@"%@ - %@", [DateUtilities stringWithDate:nextStartDate], [DateUtilities stringWithDate:nextEndDate]];
                
                NSLog(@"nextStartDate : %@, nextEndDate : %@", nextStartDate, nextEndDate);
                
                _statistics = [statsDataEngine searchFromDay:(int)_currentWeekStartDay andMonth:(int)currentWeekStartMonth andYear:(int)currentWeekStartYear toDay:(int)_currentWeekEndDay andMonth:(int)currentWeekEndMonth andYear:(int)currentWeekEndYear forPlayerId:1];
            }
            
            else if (isMonthlyCoordinateSystem)
            {
                if (_currentMonth < 12)
                {
                    _currentMonth++;
                }
                
                else
                {
                    _currentMonth = 1;
                    _currentYear++;
                }
                
                axis = [Axis monthlyAxisForMonth:_currentMonth];
                titles = [DateUtilities dayTitlesForMonth:_currentMonth];
                coordinateSystemTitle = [DateUtilities monthFullTitle:_currentMonth forYear:_currentYear];
                
                _statistics = [statsDataEngine searchByMonth:(int)_currentMonth andYear:(int)_currentYear andPlayerId:1];
            }
            
            else if (isYearlyCoordinateSystem)
            {
                _currentYear++;
                
                coordinateSystemTitle = [DateUtilities yearFullTitle:_currentYear];
                
                _statistics = [statsDataEngine searchByYear:(int)_currentYear andPlayerId:1];
            }
        }
        
        else if (swipeGestureRecognizer == _curvesViewRightSwipeGestureRecognizer) // right swipe (we go in the past)
        {
            NSLog(@"Right swipe");
            
            if (isWeeklyCoordinateSystem) // big bug when we try to move on previous year
            {
                NSDate *endDate = [DateUtilities dateWithYear:_currentYear month:_currentMonth day:_currentWeekEndDay];
                
                NSCalendar *cal = [NSCalendar currentCalendar];
                NSDate *yesterday = [cal dateByAddingUnit:NSCalendarUnitDay
                                                   value:-7
                                                  toDate:endDate
                                                 options:0];
                
                NSDictionary *startAndEndOfWeekDates = [DateUtilities startAndEndDateOfWeekForDate:yesterday];
                
                NSDate *beforeStartDate = [startAndEndOfWeekDates objectForKey:@"startDate"];
                NSDate *beforeEndDate = [startAndEndOfWeekDates objectForKey:@"endDate"];
                
                NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:beforeEndDate];
                _currentYear = [components year];
                _currentMonth = [components month];
                _currentWeekEndDay = [components day];
                NSInteger currentWeekStartMonth = [components month];
                NSInteger currentWeekStartYear = [components year];
                components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:beforeStartDate];
                _currentWeekStartDay = [components day];
                NSInteger currentWeekEndMonth = [components month];
                NSInteger currentWeekEndYear = [components year];
                
                coordinateSystemTitle = [NSString stringWithFormat:@"%@ - %@", [DateUtilities stringWithDate:beforeStartDate], [DateUtilities stringWithDate:beforeEndDate]];
                
                _statistics = [statsDataEngine searchFromDay:(int)_currentWeekStartDay andMonth:(int)currentWeekStartMonth andYear:(int)currentWeekStartYear toDay:(int)_currentWeekEndDay andMonth:(int)currentWeekEndMonth andYear:(int)currentWeekEndYear forPlayerId:1];
            }
            
            else if (isMonthlyCoordinateSystem)
            {
                if (_currentMonth > 1)
                {
                    _currentMonth--;
                }
                
                else
                {
                    _currentMonth = 12;
                    _currentYear--;
                }
                
                axis = [Axis monthlyAxisForMonth:_currentMonth];
                titles = [DateUtilities dayTitlesForMonth:_currentMonth];
                coordinateSystemTitle = [DateUtilities monthFullTitle:_currentMonth forYear:_currentYear];
                
                _statistics = [statsDataEngine searchByMonth:(int)_currentMonth andYear:(int)_currentYear andPlayerId:1];
            }
            
            else if (isYearlyCoordinateSystem)
            {
                _currentYear--;
                
                coordinateSystemTitle = [DateUtilities yearFullTitle:_currentYear];
                
                _statistics = [statsDataEngine searchByYear:(int)_currentYear andPlayerId:1];
            }
        }
        
        NSInteger row = [_playerView.dataPickerView selectedRowInComponent:0];
        NSString *selectedDataSource = [_curveDataPickerViewData objectAtIndex:row];
        
        if ([selectedDataSource rangeOfString:@"progress"].location == NSNotFound)
        {
            if ([selectedDataSource isEqualToString:@"Forehands"])
                data = [StatisticalDataEngineTools selectForehandCountsFromResult:_statistics];
            
            else if ([selectedDataSource isEqualToString:@"Backhands"])
                data = [StatisticalDataEngineTools selectBackhandCountsFromResult:_statistics];
            
            else if ([selectedDataSource isEqualToString:@"Services"])
                data = [StatisticalDataEngineTools selectServiceCountsFromResult:_statistics];
        }
        
        else
        {
            if ([selectedDataSource isEqualToString:@"Forehands (progress)"])
                data = [StatisticalDataEngineTools selectForehandProgressFromResult:_statistics];
            
            else if ([selectedDataSource isEqualToString:@"Backhands (progress)"])
                data = [StatisticalDataEngineTools selectBackhandProgressFromResult:_statistics];
            
            else if ([selectedDataSource isEqualToString:@"Services (progress)"])
                data = [StatisticalDataEngineTools selectServiceProgressFromResult:_statistics];
        }
        
        Curve *curve = [[Curve alloc] init];
        curve.values = [NSOrderedDictionary dictionaryWithObjects:data forKeys:titles];
        
        
        [_playerView.coordinateSystemView.coordinateSystem.axes setObject:axis forKey:@"absciss"];
        
        [_playerView.coordinateSystemView refreshCoordinateSystem];
        
        _playerView.coordinateSystemView.abscissAxis.titles = titles;
        
        [_playerView.coordinateSystemView undraw];
        
        
        
        [_drawnCurve undraw];
        [_playerView.coordinateSystemView setCoordinateSystemTitle:coordinateSystemTitle];
        [_drawnCurve setCurve:curve];
        [_playerView.coordinateSystemView drawCurve:_drawnCurve];
        
        [_playerView.coordinateSystemView draw];
    }
}

@end
