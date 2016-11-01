//
//  ForgetPasswordViewController.m
//  LivingTags
//
//  Created by appsbeetech on 03/05/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "ForgetPasswordService.h"

@interface ForgetPasswordViewController ()<UITextFieldDelegate>
{
    IBOutlet UITextField *txtEmail;
    IBOutlet UIButton *btnReset;
    IBOutlet UIButton *btnCancel;
    IBOutlet UILabel *lblPassword;
    NSString *strEmail;
    BOOL isViewUp;
}

@end

@implementation ForgetPasswordViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    btnReset.layer.cornerRadius=5.0f;
    btnCancel.layer.cornerRadius=5.0f;
    [txtEmail setValue:[UIColor colorWithRed:98.0/255.0 green:105.0/255.0 blue:108.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
    lblPassword.text=@"We will send you an email with instruction to reset  your Password.";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark
#pragma mark Keyboard helping Methods
#pragma mark

-(void)viewUp
{
    [UIView animateWithDuration:0.5 animations:^{
        self.view.frame=CGRectMake(self.view.frame.origin.x,-150, self.view.frame.size.width, self.view.frame.size.height);
    } completion:^(BOOL finished) {
        isViewUp=YES;
    }];
}

-(void)viewDown
{
    [UIView animateWithDuration:0.5 animations:^{
        self.view.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    } completion:^(BOOL finished){
        isViewUp=NO;
    }];
}

#pragma mark
#pragma mark TEXTFIELD DELEGATES
#pragma mark

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (isViewUp)
    {
        
    }
    else
    {
        [self viewUp];
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

-(IBAction)txtfieldEditingChanged:(id)sender
{
    UITextField *text=(id)sender;
    strEmail=text.text;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (isViewUp)
    {
        [self viewDown];
    }
    [textField resignFirstResponder];
    return YES;
}

#pragma mark
#pragma mark IBACTION
#pragma mark

-(IBAction)btnSubmitPressed:(id)sender
{
    [self.view endEditing:YES];
    if (isViewUp)
    {
        [self viewDown];
    }
    if ([self alertChecking])
    {
        [[ForgetPasswordService service]callForgetPasswordServiceWithEmailID:strEmail withCompletionHandler:^(id  _Nullable result, BOOL isError, NSString * _Nullable strMsg) {
            if (isError)
            {
                [self displayErrorWithMessage:strMsg];
            }
            else
            {
                UIAlertController *alertController=[UIAlertController alertControllerWithTitle:strMsg message:nil preferredStyle:UIAlertControllerStyleAlert]
                ;
                UIAlertAction *actionOK=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [alertController dismissViewControllerAnimated:YES completion:^{
                        
                    }];
                    [self.navigationController popViewControllerAnimated:YES];
                }];
                [alertController addAction:actionOK];
                [self presentViewController:alertController animated:YES completion:^{
                    
                }];
            }
        }];
    }
}

#pragma mark
#pragma mark alertChecking
#pragma mark

-(BOOL)alertChecking
{
    if (strEmail.length==0)
    {
        [self displayErrorWithMessage:@"Please enter your email id!!"];
        return NO;
    }
    if (![self isValidEmail:strEmail])
    {
        [self displayErrorWithMessage:@"Please enter a valid email ID"];
        return NO;
    }
    return YES;
}
@end
