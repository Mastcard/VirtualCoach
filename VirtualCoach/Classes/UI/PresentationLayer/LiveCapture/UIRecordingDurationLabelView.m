//
//  UIRecordingDurationLabelView.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 21/07/2015.
//  Copyright © 2015 Romain Dubreucq. All rights reserved.
//

#import "UIRecordingDurationLabelView.h"

@interface UIRecordingDurationLabelView ()

@property (nonatomic, strong) NSDate *startDate;

@end

@implementation UIRecordingDurationLabelView

- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        _label = [[UILabel alloc] init];
        _resetAtStopAction = YES;
    }
    
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [_label setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
}

- (void)layout
{
    [_label setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:17.f]];
    [_label setText:@"00:00:00"];
    [_label setTextColor:[UIColor whiteColor]];
    
    [self addSubview:_label];
}

- (void)startDuration
{
    _startDate = [NSDate date];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0
                                                       target:self
                                                     selector:@selector(repeatableAction)
                                                     userInfo:nil
                                                      repeats:YES];
}

- (void)stopDuration
{
    [_timer invalidate];
    _timer = nil;
    
    if(_resetAtStopAction)
        [_label setText:@"00:00:00"];
}

- (void)repeatableAction
{
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:_startDate];
    NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    
    NSString *timeString = [dateFormatter stringFromDate:timerDate];
    _label.text = timeString;
}

@end
