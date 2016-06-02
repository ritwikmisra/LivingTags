//
//  RegistrationViewController.m
//  LivingTags
//
//  Created by appsbeetech on 23/04/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "RegistrationViewController.h"
#import "RegistrationCellTableViewCell.h"
#import "RegistrationService.h"


@interface RegistrationViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    IBOutlet UIButton *btnSignUp;
    IBOutlet UITableView *tblSignUp;
    NSMutableArray *arrNames;
    NSMutableArray *arrImages;
    NSString *strEmail,*strName,*strPassword,*strConfirmPassword;
    BOOL isViewUp;
}

@end

@implementation RegistrationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    btnSignUp.layer.cornerRadius=5.0f;
    tblSignUp.separatorStyle=UITableViewCellSeparatorStyleNone;
    arrNames=[[NSMutableArray alloc]initWithObjects:@"Name",@"Email Address",@"Password",@"Confirm Password", nil];
    arrImages=[[NSMutableArray alloc]initWithObjects:@"name_icon",@"mail_icon.png",@"password_icon",@"password_icon", nil];
    tblSignUp.bounces=NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark
#pragma mark tableview datasource and delegate
#pragma mark

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrNames.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (___isIphone4_4s)
    {
        return 40.0f;
    }
    else if (___isIphone5_5s)
    {
        return 47.0f;
    }
    else if (___isIphone6)
    {
        return 55.0f;
    }
    return 60.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RegistrationCellTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"str"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.txtSignUp.autocapitalizationType=UITextAutocapitalizationTypeWords;
    cell.txtSignUp.placeholder=[arrNames objectAtIndex: indexPath.row];
    cell.txtSignUp.delegate=self;
    cell.imgSignUp.image=[UIImage imageNamed:[arrImages objectAtIndex:indexPath.row]];
    [cell.txtSignUp setValue:[UIColor colorWithRed:98.0/255.0 green:105.0/255.0 blue:108.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
    cell.txtSignUp.tag=indexPath.row;
    [cell.txtSignUp addTarget:self action:@selector(textFieldEditing:) forControlEvents:UIControlEventEditingChanged];
    cell.backgroundColor=[UIColor clearColor];
    if (cell.txtSignUp.tag==1)
    {
        cell.txtSignUp.keyboardType=UIKeyboardTypeEmailAddress;
    }
    if (cell.txtSignUp.tag==2 || cell.txtSignUp.tag==3)
    {
        cell.txtSignUp.secureTextEntry=YES;
    }
    return cell;
}

#pragma mark
#pragma mark textfield methods
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

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (isViewUp)
    {
        [textField resignFirstResponder];
        [self viewDown];
    }
    return YES;
}

-(void)textFieldEditing:(id)sender
{
    UITextField *text=(id)sender;
    if ([sender tag]==0)
    {
        strName=text.text;
    }
    else if ([sender tag]==1)
    {
        strEmail=text.text;
    }
    else if ([sender tag]==2)
    {
        strPassword=text.text;
    }
    else
    {
        strConfirmPassword=text.text;
    }
}

#pragma mark
#pragma mark alert checking
#pragma mark

-(BOOL)alertChecking
{
    if (strName.length==0)
    {
        [self displayErrorWithMessage:@"Please enter your name!"];
        return NO;
    }
    if (strEmail.length==0)
    {
        [self displayErrorWithMessage:@"Please enter email id!"];
        return NO;
    }
    if (![self isValidEmail:[strEmail stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]])
    {
        [self displayErrorWithMessage:@"Please enter a valid email id!"];
        return NO;
    }
    if (strPassword.length==0)
    {
        [self displayErrorWithMessage:@"Please enter password!"];
        return NO;
    }
    if (strConfirmPassword.length==0)
    {
        [self displayErrorWithMessage:@"Please enter confirm password!"];
        return NO;
    }
    if (![strPassword isEqualToString:strConfirmPassword])
    {
        [self displayErrorWithMessage:@"Password and Confirm Password doesnot match.Please check again.."];
        return NO;
    }
    return YES;
}

#pragma mark
#pragma mark IBACTIONS
#pragma mark

-(IBAction)btnSignUpPressed:(id)sender
{
    if (isViewUp)
    {
        [self viewDown];
    }
    [self.view endEditing:YES];
    if ([self  alertChecking])
    {
        NSString *strPass=[self generateMD5:strPassword];
        NSLog(@"%@",strPassword);
        [[RegistrationService service]callRegistrationServiceWithSource:device Name:strName emailAddress:strEmail password:strPass withCompletionHandler:^(id  _Nullable result, BOOL isError, NSString * _Nullable strMsg) {
            if (isError)
            {
                UIAlertController *alertController=[UIAlertController alertControllerWithTitle:nil message:strMsg preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *actionOK=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self  dismissViewControllerAnimated:YES completion:^{
                        
                    }];
                }];
                [alertController addAction:actionOK];
                [self presentViewController:alertController animated:YES completion:^{
                    
                }];
            }
            else
            {
                UIAlertController *alertController=[UIAlertController alertControllerWithTitle:nil message:strMsg preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *actionOK=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self  dismissViewControllerAnimated:YES completion:^{
                        
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
#pragma mark view up and view down
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
    } completion:^(BOOL finished) {
        isViewUp=NO;
    }];
}

@end
