//
//  UIProcessProgressView.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 12/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "UIProcessProgressView.h"

@implementation UIProcessProgressView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        _progressView = [[UIProgressView alloc] init];
        _progressLabel = [[UIBaseLabel alloc] init];
    }
    
    return self;
}

- (void)prepareView
{
    [self setBackgroundColor:[UIColor colorWithRed:0.f green:0.f blue:0.f alpha:1.f]];
    
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = 1.f;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    
    CGFloat defaultMargin = 40.f;
    
    CGPoint progressLabelOrigin = CGPointMake(defaultMargin, defaultMargin);
    CGSize progressLabelSize = CGSizeMake(self.frame.size.width - (defaultMargin * 2), 20);
    
    [_progressLabel setFrame:CGRectMake(progressLabelOrigin.x, progressLabelOrigin.y, progressLabelSize.width, progressLabelSize.height)];
    
    NSMutableAttributedString *progressLabelText = [[NSMutableAttributedString alloc] initWithString:@"   "];
    [progressLabelText addAttribute:NSForegroundColorAttributeName
                             value:[UIColor whiteColor]
                             range:NSMakeRange(0, progressLabelText.length)];
    [progressLabelText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18.f] range:NSMakeRange(0, progressLabelText.length)];
    [_progressLabel setAttributedText:progressLabelText];
    
    CGPoint progressViewOrigin = CGPointMake(defaultMargin, progressLabelOrigin.y + progressLabelSize.height + defaultMargin);
    CGSize progressViewSize = CGSizeMake(self.frame.size.width - (defaultMargin * 2), 20);
    
    [_progressView setFrame:CGRectMake(progressViewOrigin.x, progressViewOrigin.y, progressViewSize.width, progressViewSize.height)];
    [_progressView setProgress:0.f];
    [_progressView setTrackTintColor:[UIColor lightGrayColor]];
    _progressView.observedProgress = nil;
}

- (void)layout
{
    [super layout];
    
    [self prepareForUse];
    
    [self addSubview:_progressView alignment:UIViewCenteredOnX];
    [self addSubview:_progressLabel alignment:UIViewCenteredOnX];
}

- (void)prepareForUse
{
    [self prepareView];
}

@end
