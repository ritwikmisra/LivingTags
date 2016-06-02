//
//  ViewControllerBaseClassViewController.m
//  LivingTags
//
//  Created by appsbeetech on 21/04/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "ViewControllerBaseClassViewController.h"
#import <CommonCrypto/CommonDigest.h>
#import "ProfileViewController.h"
#import "SlideMenuController.h"
#import "MyLivingTagesViewController.h"


@interface ViewControllerBaseClassViewController ()<sideBarDelegate>
{
    IBOutlet  UIImageView *imgHeader;
    SlideMenuController *slideMenu;
}
@end

@implementation ViewControllerBaseClassViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    appDel=(AppDelegate*)[[UIApplication sharedApplication] delegate];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"%@",self.navigationController.topViewController);
    slideMenu=[SlideMenuController getSlideMenuInstance];
    if ([self.navigationController.topViewController isKindOfClass:[ProfileViewController class]])
    {
        if (!slideMenu.isSlideMenuPlaced)
        {
            NSLog(@"Left Panel not placed");
            slideMenu.view.frame=CGRectMake(-slideMenu.view.frame.size.width,0,slideMenu.view.frame.size.width,slideMenu.view.frame.size.height);
            UIWindow *myWindow=[[UIApplication sharedApplication] keyWindow];
            [myWindow addSubview:slideMenu.view];
            slideMenu.isSlideMenuPlaced=YES;
            [myWindow addSubview:slideMenu.view];
            slideMenu.delegate=self;
            //[myWindow bringSubviewToFront:slideMenu.view];
        }
        else
        {
            NSLog(@"Slide Panel placed");
        }
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark
#pragma mark get superview from subview
#pragma mark

-(id)getSuperviewOfType:(Class)myClass fromView:(id)myView
{
    if ([myView isKindOfClass:myClass])
    {
        return myView;
    }
    else
    {
        id temp=[myView superview];
        while (temp) {
            if ([temp isKindOfClass:myClass])
            {
                return temp;
            }
            temp=[temp superview];
        }
    }
    return nil;
}

#pragma mark
#pragma mark is valid email
#pragma mark

-(BOOL)isValidEmail:(NSString*)strEmailID
{
    BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:strEmailID];
}

#pragma mark
#pragma mark is Valid Checking
#pragma mark

-(void)displayErrorWithMessage:(NSString*)strMsg
{
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:strMsg message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionOK=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alertController dismissViewControllerAnimated:YES completion:^{
            
        }];
    }];
    [alertController addAction:actionOK];
    [self presentViewController:alertController animated:YES completion:^{
        
    }];
}

#pragma mark
#pragma mark MD5
#pragma mark

-(NSString *)generateMD5:(NSString *)string
{
    const char *cStr = [string UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, (unsigned int)strlen(cStr), digest ); // This is the md5 call
    NSMutableString *output =[NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH *2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return  output;
}

#pragma mark
#pragma mark back button 
#pragma mark

-(IBAction)btnBackPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark
#pragma mark side panel button
#pragma mark

-(IBAction)btnSidePanel:(id)sender
{
    NSLog(@"sidePanel Pressed");
    [self.view endEditing:YES];
    NSLog(@"%f:%f:%f:%f",slideMenu.view.frame.origin.x,slideMenu.view.frame.origin.y,slideMenu.view.frame.size.width,slideMenu.view.frame.size.height);
    if (!slideMenu.isSlideMenuVisible)
    {
        [UIView animateWithDuration:0.5 delay:0.2 options:UIViewAnimationOptionCurveLinear animations:^{
            slideMenu.view.frame=CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height);
        } completion:^(BOOL finished) {
            slideMenu.isSlideMenuVisible=YES;
            //self.imgBackground.alpha=0.6f;
        }];
    }
    else
    {
        [UIView animateWithDuration:0.5 delay:0.2 options:UIViewAnimationOptionCurveLinear animations:^{
            slideMenu.view.frame=CGRectMake(-slideMenu.view.frame.size.width,0,slideMenu.view.frame.size.width,slideMenu.view.frame.size.height);
        } completion:^(BOOL finished) {
            slideMenu.isSlideMenuVisible=NO;
        }];
    }
}

#pragma mark
#pragma mark sidebar Delegate
#pragma mark

-(void)tapGesturePressed
{
    if (slideMenu.isSlideMenuVisible)
    {
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
            slideMenu.view.frame=CGRectMake(-slideMenu.view.frame.size.width,0,slideMenu.view.frame.size.width,slideMenu.view.frame.size.height);
        } completion:^(BOOL finished) {
            slideMenu.isSlideMenuVisible=NO;
        }];
    }
}

-(void)selectedRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (slideMenu.isSlideMenuVisible)
    {
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
            slideMenu.view.frame=CGRectMake(-slideMenu.view.frame.size.width,0,slideMenu.view.frame.size.width,slideMenu.view.frame.size.height);
        } completion:^(BOOL finished) {
            slideMenu.isSlideMenuVisible=NO;
            UIViewController *controller;
            UIStoryboard *mainStoryboard=[UIStoryboard storyboardWithName:@"Main"bundle: nil];
            switch (indexPath.row)
            {
                case 0:
                    controller=(ProfileViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
                    break;
                case 3:
                    controller=(MyLivingTagesViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"MyLivingTagesViewController"];
                    break;
                case 7:
                    [self displayAlertControllerForLogout];
                    break;

                default:
                    break;
            }
            NSLog(@"%@",self.navigationController.topViewController);
            if (![[self.navigationController topViewController] isKindOfClass:[controller class]] && indexPath.row!=7)
            {
                [self.navigationController pushViewController:controller animated:YES];
            }
        }];
    }
}

#pragma mark
#pragma mark Display AlertController
#pragma mark

-(void)displayAlertControllerForLogout
{
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"Do you want to logout from the application?" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionOK=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alertController dismissViewControllerAnimated:YES completion:^{
            
        }];
    }];
    UIAlertAction *actionCancel=[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alertController dismissViewControllerAnimated:YES completion:^{
            
        }];
    }];

    [alertController addAction:actionOK];
    [alertController addAction:actionCancel];
    [self presentViewController:alertController animated:YES completion:^{
        
    }];

}
@end
