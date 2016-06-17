//
//  UIPlayerViewController.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 15/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "UIPlayerViewController.h"

@implementation UIPlayerViewController

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        _playerView = [[UIPlayerView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        
        _curveDataPickerViewData = [[NSMutableArray alloc] initWithObjects:@"Forehands", @"Backhands", @"Services", @"Forehands (progress)", @"Backhands (progress)", @"Services (progress)", nil];
        
        _curvePeriodPickerViewData = [[NSMutableArray alloc] initWithObjects:@"Daily", @"Weekly", @"Monthly", @"Yearly", nil];
        
        _curveStylePickerViewData = [[NSMutableArray alloc] initWithObjects:@"Only plots", @"Curves", nil];
        
        [_playerView.dataPickerView setDelegate:self];
        [_playerView.dataPickerView setDataSource:self];
        
        [_playerView.periodPickerView setDelegate:self];
        [_playerView.periodPickerView setDataSource:self];
        
        [_playerView.stylePickerView setDelegate:self];
        [_playerView.stylePickerView setDataSource:self];
        
        self.view = _playerView;
    }
    
    return self;
}

- (void)prepareForUse
{
    [_playerView layout];
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
        NSLog(@"You selected this: %@", [_curveDataPickerViewData objectAtIndex:row]);
    
    else if (pickerView.tag == CURVE_PERIOD_PICKERVIEW_TAG)
        NSLog(@"You selected this: %@", [_curvePeriodPickerViewData objectAtIndex:row]);
    
    else if (pickerView.tag == CURVE_STYLE_PICKERVIEW_TAG)
        NSLog(@"You selected this: %@", [_curveStylePickerViewData objectAtIndex:row]);
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
    if (tableView.tag == TRAININGS_TABLEVIEW_TAG)
    {
        /** Example code to reload data according to a selection
         
         NSLog(@"Cell from TRAININGS TABLE CELL VIEW WAS SELECTED");
         
         _playersTableViewData = @[@"Training1Player1", @"Training1Player2", @"Training1Player3", @"Training1Player4"];
         _videosTableViewData = @[@"2016-05-25_11.00.47", @"2016-05-25_11.27.59", @"2016-06-05_10.10.07", @"2016-06-05_10.24.25"];
         
         [_trainingView.playersTableView reloadData];
         [_trainingView.videosTableView reloadData];
         
         **/
    }
    
    else if (tableView.tag == PLAYERS_TABLEVIEW_TAG)
    {
        NSLog(@"Cell from PLAYERS TABLE CELL VIEW WAS SELECTED");
    }
    
    else if (tableView.tag == VIDEOS_TABLEVIEW_TAG)
    {
        NSLog(@"Cell from VIDEOS TABLE CELL VIEW WAS SELECTED");
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
    
    else if (tableView.tag == VIDEOS_TABLEVIEW_TAG)
        numberOfRows = _videosTableViewData.count;
    
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
        [cell.detailTextLabel setText:@"Date: 00/00/9999\nLocation: Cergy-Pontoise\nPlayer count: 6"];
    }
    
    else if (tableView.tag == PLAYERS_TABLEVIEW_TAG)
    {
        [cell.textLabel setText:[_playersTableViewData objectAtIndex:indexPath.row]];
        [cell.detailTextLabel setText:@"Name: Toto\nPro"];
        
        UIImage *profileIcon = [UIImage imageNamed:@"playerIcon.png"];
        [cell.imageView setImage:profileIcon];
        //        UIImageView *profileIconImageView = [[UIImageView alloc] initWithImage:profileIcon];
        //        [profileIconImageView setFrame:CGRectMake(-profileIconImageView.frame.size.width, -profileIconImageView.frame.size.height, profileIconImageView.frame.size.width, profileIconImageView.frame.size.height)];
        //        [cell addSubview:profileIconImageView];
    }
    
    else if (tableView.tag == VIDEOS_TABLEVIEW_TAG)
    {
        [cell.textLabel setText:[_videosTableViewData objectAtIndex:indexPath.row]];
        [cell.detailTextLabel setText:@"Length: 1:13\n------------"];
        
        CGSize playButtonSize = CGSizeMake(40, 40);
        
        UIBaseButton *playButton = [UIBaseButton buttonWithType:UIButtonTypeCustom];
        [playButton setFrame:CGRectMake((cell.frame.size.width / 2) + 80, cell.frame.size.height / 2 + 5, playButtonSize.width, playButtonSize.height)];
        [playButton setImage:[UIImage imageNamed:@"playIcon.png"] forState:UIControlStateNormal];
        [playButton addTarget:self action:@selector(playVideoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:playButton];
        
        UIBaseButton *processButton = [UIBaseButton buttonWithType:UIButtonTypeCustom];
        [processButton setFrame:CGRectMake(playButton.frame.origin.x + playButton.frame.size.width + 10, playButton.frame.origin.y, playButtonSize.width, playButtonSize.height)];
        [processButton setImage:[UIImage imageNamed:@"deleteVideoIcon.png"] forState:UIControlStateNormal];
        [processButton addTarget:self action:@selector(removeVideoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:processButton];
        
        UIBaseButton *removeButton = [UIBaseButton buttonWithType:UIButtonTypeCustom];
        [removeButton setFrame:CGRectMake(processButton.frame.origin.x + processButton.frame.size.width + 10, processButton.frame.origin.y, playButtonSize.width, playButtonSize.height)];
        [removeButton setImage:[UIImage imageNamed:@"processIcon.png"] forState:UIControlStateNormal];
        [removeButton addTarget:self action:@selector(processVideoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:removeButton];
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 44.f;
    
    if (tableView.tag == TRAININGS_TABLEVIEW_TAG)
    {
        height += 50;
    }
    
    else if (tableView.tag == PLAYERS_TABLEVIEW_TAG)
    {
        height += 30;
    }
    
    else if (tableView.tag == VIDEOS_TABLEVIEW_TAG)
    {
        height += 30;
    }
    
    return height;
}

@end
