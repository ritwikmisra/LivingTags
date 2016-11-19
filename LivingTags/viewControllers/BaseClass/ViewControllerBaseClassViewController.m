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
#import "MyLivingTagesViewController.h"
#import "LoggingViewController.h"
#import "LivingTagsTemplateListController.h"
#import "NetworkActivityViewController.h"
#import "SidePanelController.h"
#import "SettingsViewController.h"
#import "DashboardSpaceViewController.h"
#import "ProductListingViewController.h"
#import "AboutUsController.h"

@interface ViewControllerBaseClassViewController ()<SidePanelSwipeDelegate>
{
    SidePanelController *slideMenu;
}
@end

@implementation ViewControllerBaseClassViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    appDel=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    strDateFormat=@"MM-dd-yyyy";
    dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:strDateFormat];
   // [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"%@",self.navigationController.topViewController);
    ///slide menu initialisation
    slideMenu=[SidePanelController getInstance];
    slideMenu.view.frame=CGRectMake(-slideMenu.view.frame.size.width,0,slideMenu.view.frame.size.width,slideMenu.view.frame.size.height);
    UIWindow *myWindow=[[UIApplication sharedApplication] keyWindow];
    slideMenu.delegate=self;
    [myWindow addSubview:slideMenu.view];
    ////////
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

-(IBAction)btnSlidePanelPressed:(id)sender
{
    [self.view endEditing:YES];
    if (!slideMenu.isSlideMenuVisible)
    {
        [self openSlider];
    }
    else
    {
        [self closeSlider];
    }
}

#pragma mark
#pragma mark open slider and close slider
#pragma mark

-(void)openSlider
{
   [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        slideMenu.view.frame=CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height);
    } completion:^(BOOL finished) {
        slideMenu.isSlideMenuVisible=YES;
    }];

}

-(void)closeSlider
{
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        slideMenu.view.frame=CGRectMake(-slideMenu.view.frame.size.width,0,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height);
    } completion:^(BOOL finished) {
        slideMenu.isSlideMenuVisible=NO;
    }];
}

#pragma mark
#pragma mark activity indicator methods
#pragma mark

-(void)displayNetworkActivity
{
    NetworkActivityViewController *netwokActivity=[NetworkActivityViewController sharedInstance];
    UIWindow *window=[[UIApplication sharedApplication] keyWindow];
    netwokActivity.view.frame=CGRectMake(0, 0, window.frame.size.width, window.frame.size.height);
    [window addSubview:netwokActivity.view];
    [netwokActivity changeAnimatingStatusTo:YES];
}

-(void)hideNetworkActivity
{
    NetworkActivityViewController *netwokActivity=[NetworkActivityViewController sharedInstance];
    [netwokActivity.view removeFromSuperview];
    [netwokActivity changeAnimatingStatusTo:NO];
}


#pragma mark
#pragma mark button dashboard pressed
#pragma mark

-(IBAction)btnDashboardPressed:(id)sender
{
    [self performSegueWithIdentifier:@"segueDashboardFromOtherPages" sender:self];
}

#pragma mark
#pragma mark side panel delegate
#pragma mark

-(void)swipeToCloseSidePanel
{
    [self closeSlider];
}

-(void)selectedRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self closeSlider];
    UINavigationController *navController=(UINavigationController*)[[[UIApplication sharedApplication] keyWindow] rootViewController];
    [UIView animateWithDuration:0.2 animations:^{
        navController.view.frame=CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width,  [[UIScreen mainScreen] bounds].size.height);
    } completion:^(BOOL finished) {
        [slideMenu setIsSlideMenuVisible:NO];
        UIViewController *controller;
        UIStoryboard *mainStoryboard=[UIStoryboard storyboardWithName:@"Main"bundle: nil];
        switch (indexPath.row)
        {
               //DashboardSpaceViewController
            case 0:
                controller=(DashboardSpaceViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"DashboardSpaceViewController"];
                break;

            case 1:
                controller=(MyLivingTagesViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"MyLivingTagesViewController"];
                break;
                //ProductListingViewController
                
            case 3:
                controller=(ProductListingViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"ProductListingViewController"];
                break;

            case 5:
                controller=(ProfileViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
                break;

            case 6:
                controller=(SettingsViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"SettingsViewController"];
                break;
                
                //AboutUsController
            case 8:
                controller=(AboutUsController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"AboutUsController"];
                break;

            case 9:
                controller=(AboutUsController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"AboutUsController"];
                break;

            default:
                break;
        }
        NSLog(@"%@",self.navigationController.topViewController);
        if (![[self.navigationController topViewController] isKindOfClass:[controller class]] )
        {
            [self.navigationController pushViewController:controller animated:YES];
        }
    }];
}


#pragma mark
#pragma mark Keyboard helping Methods
#pragma mark

-(void)viewUp
{
    [UIView animateWithDuration:0.5 animations:^{
        self.view.frame=CGRectMake(self.view.frame.origin.x,-170, self.view.frame.size.width, self.view.frame.size.height);
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

#pragma mark
#pragma mark Size calculation
#pragma mark

- (id)transformedValue:(id)value
{
    
    double convertedValue = [value doubleValue];
    int multiplyFactor = 0;
    
    NSArray *tokens = [NSArray arrayWithObjects:@"bytes",@"KB",@"MB",@"GB",@"TB",nil];
    
    while (convertedValue > 1024)
    {
        convertedValue /= 1024;
        multiplyFactor++;
    }
    
    return [NSString stringWithFormat:@"%4.2f %@",convertedValue, [tokens objectAtIndex:multiplyFactor]];
}


@end
