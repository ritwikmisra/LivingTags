//
//  ContactsPopupController.m
//  LivingTags
//
//  Created by appsbeetech on 02/11/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "ContactsPopupController.h"
#import "LivingTagsSecondStepService.h"


@interface ContactsPopupController ()<UITextFieldDelegate>
{
    IBOutlet UITextField *txtName;
    IBOutlet UITextField *txtPhone;
    IBOutlet UITextField *txtFax;
    IBOutlet UITextField *txtEmail;
    IBOutlet UIButton *btnSave;
    IBOutlet UIButton *btnCancel;
    IBOutlet UIView *vwPopUP;
    NSString *strName,*strphone,*strFax,*strEmail;
    NSMutableDictionary *dict;
}

@end

@implementation ContactsPopupController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIColor *color = [UIColor colorWithRed:76/255.0f green:87/255.0f blue:95/255.0f alpha:1.0];
    txtName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Name" attributes:@{NSForegroundColorAttributeName: color}];
    txtPhone.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Phone No" attributes:@{NSForegroundColorAttributeName: color}];
    txtFax.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Fax" attributes:@{NSForegroundColorAttributeName: color}];
    txtEmail.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email ID" attributes:@{NSForegroundColorAttributeName: color}];
    dict=[[NSMutableDictionary alloc]init];
    NSLog(@"%@",self.objPopUPTemplates.strTcname);
    txtName.text=strName=self.objPopUPTemplates.strTcname;
    txtPhone.text=strphone=self.objPopUPTemplates.strTphone;
    txtFax.text=strFax=self.objPopUPTemplates.strTfax;
    txtFax.text=strEmail=self.objPopUPTemplates.strEmail;
    if (strName.length>0)
    {
        [dict setObject:strName forKey:@"tcname"];
        [dict setObject:strphone forKey:@"tphone"];
        [dict setObject:strFax forKey:@"tfax"];
        [dict setObject:strEmail forKey:@"temail"];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    vwPopUP.layer.cornerRadius=10.0f;
    
    ////round corner for preview button/////
    
    UIBezierPath *maskPath = [UIBezierPath
                              bezierPathWithRoundedRect:btnSave.bounds
                              byRoundingCorners:(UIRectCornerBottomLeft )
                              cornerRadii:CGSizeMake(8.0f, 0.0f)
                              ];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = btnSave.bounds;
    maskLayer.path = maskPath.CGPath;
    btnSave.layer.mask = maskLayer;
    
    /////round corner for public button //////
    
    UIBezierPath *maskPath1= [UIBezierPath
                              bezierPathWithRoundedRect:btnCancel.bounds
                              byRoundingCorners:( UIRectCornerBottomRight)
                              cornerRadii:CGSizeMake(8.0f, 0.0f)
                              ];
    
    CAShapeLayer *maskLayer1 = [CAShapeLayer layer];
    maskLayer1.frame = btnCancel.bounds;
    maskLayer1.path = maskPath1.CGPath;
    btnCancel.layer.mask = maskLayer1;
}
#pragma mark
#pragma mark IBACTIONS
#pragma mark

-(IBAction)btnCancelPressed:(id)sender
{
    [self.view endEditing:YES];
    [self.view removeFromSuperview];
}

-(IBAction)btnSavePressed:(id)sender
{
    [self.view endEditing:YES];
    if (isViewUp)
    {
        [self viewDown];
    }
    if ([self alertChecking])
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(callWebServiceWithDict:)])
        {
            [self.delegate callWebServiceWithDict:dict];
        }
    }
}

#pragma mark
#pragma mark textfield delegate
#pragma mark

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (!isViewUp)
    {
        [self viewUp];
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if (isViewUp)
    {
        [self viewDown];
    }
    return YES;
}

-(IBAction)textFieldEdited:(id)sender
{
    UITextField *textField=(id)sender;
    if (textField.tag==1)
    {
        strName=textField.text;
        [dict setObject:strName forKey:@"tcname"];
    }
    else if (textField.tag==2)
    {
        strphone=textField.text;
        [dict setObject:strphone forKey:@"tphone"];

    }
    else if (textField.tag==3)
    {
        strFax=textField.text;
        [dict setObject:strFax forKey:@"tfax"];

    }
    else
    {
        strEmail=textField.text;
        [dict setObject:strEmail forKey:@"temail"];

    }
}

#pragma mark
#pragma mark alert checking
#pragma mark

-(BOOL)alertChecking
{
    if (strName.length==0)
    {
        [self displayErrorWithMessage:@"All fields are mandatory."];
        return NO;
    }
    if (strphone.length==0)
    {
        [self displayErrorWithMessage:@"All fields are mandatory."];
        return NO;

    }
    if (strFax.length==0)
    {
        [self displayErrorWithMessage:@"All fields are mandatory."];
        return NO;

    }
    if (strEmail.length==0)
    {
        [self displayErrorWithMessage:@"All fields are mandatory."];
        return NO;
    }
    if ([strName isEqualToString:self.objPopUPTemplates.strTcname] && [strphone isEqualToString:self.objPopUPTemplates.strTphone] && [strFax isEqualToString:self.objPopUPTemplates.strTfax] && [strEmail isEqualToString:self.objPopUPTemplates.strEmail])
    {
        [self displayErrorWithMessage:@"Please update atleast one value"];
        return NO;
    }
    return YES;
}


@end
