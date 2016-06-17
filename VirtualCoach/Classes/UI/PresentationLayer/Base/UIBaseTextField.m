//
//  UIBaseTextField.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 21/05/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "UIBaseTextField.h"

@implementation UIBaseTextField

- (CGRect)textRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, 10, 10);
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, 10, 10);
}

//- (void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    textField.placeholder = nil;
//}
//
//- (void)textFieldDidEndEditing:(UITextField *)textField
//{
//    textField.placeholder = _placeHolderText;
//}

@end
