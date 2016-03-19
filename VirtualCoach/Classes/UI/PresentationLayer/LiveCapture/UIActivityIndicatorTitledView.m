//
//  UIActivityIndicatorTitledView.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 09/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "UIActivityIndicatorTitledView.h"

@implementation UIActivityIndicatorTitledView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        _activityIndicatorView = [[UIActivityIndicatorView alloc] init];
        _activityIndicatorLabel = [[UIBaseLabel alloc] init];
    }
    
    return self;
}

- (void)layout
{
    [self setBackgroundColor:[UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.5]];
    
    _activityIndicatorView.color = [UIColor whiteColor];
    
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    
    CGSize activityIndicatorSize = CGSizeMake(self.frame.size.width, (self.frame.size.height / 3) * 2);
    [_activityIndicatorView setFrame:CGRectMake(0, 0, activityIndicatorSize.width, activityIndicatorSize.height)];
    
    [self addSubview:_activityIndicatorView];
    
    CGSize activityIndicatorLabelSize = CGSizeMake(self.frame.size.width, self.frame.size.height / 3);
    [_activityIndicatorLabel setFrame:CGRectMake(0, activityIndicatorSize.height, activityIndicatorLabelSize.width, activityIndicatorLabelSize.height)];
    
    [_activityIndicatorLabel setText:@"Calibrating..."];
    [_activityIndicatorLabel setTextColor:[UIColor whiteColor]];
    [_activityIndicatorLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:20.f]];
    [_activityIndicatorLabel resizeToFitText];
    
    [self addSubview:_activityIndicatorLabel alignment:UIViewCenteredOnX];
    
    
    
    //[_activityIndicatorView startAnimating];
}

@end
