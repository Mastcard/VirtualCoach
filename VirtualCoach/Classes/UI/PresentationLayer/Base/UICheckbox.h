//
//  UICheckbox.h
//  VirtualCoach
//
//  Created by Romain Dubreucq on 21/05/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICheckbox : UIControl

@property (nonatomic, assign) BOOL checked;
@property (nonatomic, assign) BOOL disabled;
@property (nonatomic, strong) NSString *text;

- (void)setChecked:(BOOL)boolValue;
- (void)setDisabled:(BOOL)boolValue;
- (void)setText:(NSString *)stringValue;

@end
