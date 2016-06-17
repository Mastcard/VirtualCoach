//
//  UIAccountCreationViewController.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 22/05/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "UIAccountCreationViewController.h"

@implementation UIAccountCreationViewController

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        _accountCreationView = [[UIAccountCreationView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        
        self.view = _accountCreationView;
        
        _leftOrRightHandedPickerViewData = [[NSMutableArray alloc] initWithObjects:@"Right-handed", @"Left-handed", nil];
        
        [_accountCreationView.credentialsView.leftOrRighHandedPickerView setDataSource:self];
        [_accountCreationView.credentialsView.leftOrRighHandedPickerView setDelegate:self];
        
        [_accountCreationView.credentialsView.createAccountButton addTarget:self action:@selector(createAccountButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
        self.navigationItem.title = @"Account creation";
    }
    
    return self;
}

- (void)prepareForUse
{
    [_accountCreationView layout];
}

- (void)createAccountButtonAction
{
    // set loginSuccess depending on authtication result
    
    BOOL createAccountSuccess = YES;
    
    if (createAccountSuccess)
    {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Account created!"
                                      message:@"You can now login."
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* okButton = [UIAlertAction
                                   actionWithTitle:@"Let's go"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action)
                                   {
                                       UIApplicationNavigationViewController *nav = (UIApplicationNavigationViewController *)self.navigationController;
                                       [nav popViewControllerAnimated:YES];
                                   }];
        
        [alert addAction:okButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    else
    {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Account creation failed."
                                      message:@"Please try again."
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* okButton = [UIAlertAction
                                   actionWithTitle:@"OK"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action)
                                   {
                                       // handle option action
                                   }];
        
        [alert addAction:okButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [_leftOrRightHandedPickerViewData count];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSLog(@"You selected this: %@", [_leftOrRightHandedPickerViewData objectAtIndex:row]);
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    NSString *rowItem = [_leftOrRightHandedPickerViewData objectAtIndex:row];
    
    UILabel *lblRow = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [pickerView bounds].size.width, 44.0f)];
    [lblRow setTextAlignment:NSTextAlignmentCenter];
    [lblRow setTextColor: [UIColor whiteColor]];
    [lblRow setText:rowItem];
    [lblRow setBackgroundColor:[UIColor clearColor]];
    
    return lblRow;
}


@end
