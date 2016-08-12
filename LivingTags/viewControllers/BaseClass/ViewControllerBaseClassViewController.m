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
#import "LoggingViewController.h"
#import "ImageHoverController.h"
#import "LivingTagsTemplateListController.h"
#import "NetworkActivityViewController.h"
#import "ReadAllTagsViewController.h"
#import "ImportContactsViewController.h"
#import "DashboardViewController.h"


#define SLIDER_WIDTH [[UIScreen mainScreen] bounds].size.width/1.5f
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width


@interface ViewControllerBaseClassViewController ()<sideBarDelegate,ImageTapDelegate>
{
    IBOutlet  UIImageView *imgHeader;
    SlideMenuController *slideMenu;
    CGFloat leftPanelWidth;
    UIImageView *img;
    
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
    ///slide menu initialisation
    if (!slideMenu)
    {
        if ([[self.navigationController topViewController]isKindOfClass:[DashboardViewController class]])
        {
            slideMenu=[SlideMenuController getSlideMenuInstance];
            slideMenu.view.frame=CGRectMake(0,0, SLIDER_WIDTH, [[UIScreen mainScreen] bounds].size.height);
            slideMenu.delegate=self;
            slideMenu.isSlideMenuVisible=NO;
            // [slideMenu.tblSidePanel reloadData];
            if (appDel.isLogoutBtnTapped == YES)
            {
                appDel.isLogoutBtnTapped = NO;
                [slideMenu.tblSidePanel reloadData];
            }
        }
    }
    CALayer *layer = self.navigationController.view.layer;
    layer.shadowOffset = CGSizeMake(-6, 0);
    layer.shadowColor = [[UIColor darkTextColor] CGColor];
    layer.shadowRadius = 2.0f;
    layer.shadowOpacity = 0.4f;
    layer.shadowPath = [[UIBezierPath bezierPathWithRect:layer.bounds] CGPath];
    
    [[[UIApplication sharedApplication] keyWindow] addSubview:slideMenu.view];
    [[[UIApplication sharedApplication] keyWindow] sendSubviewToBack:slideMenu.view];
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

#pragma mark
#pragma mark side panel button
#pragma mark

-(IBAction)btnSidePanel:(id)sender
{
    [self.view endEditing:YES];
    NSLog(@"sidePanel Pressed");
    if (slideMenu.isSlideMenuVisible)
    {
        [self closeSlider];
    }
    else
    {
        [self openSlider];
    }
}

-(void)openSlider
{
    UINavigationController *navController=(UINavigationController*)[[[UIApplication sharedApplication] keyWindow] rootViewController];
    slideMenu.view.frame=CGRectMake(0.0f, 0.0f, SLIDER_WIDTH, [[UIScreen mainScreen] bounds].size.height);
    [UIView animateWithDuration:0.2 animations:^{
        navController.view.frame=CGRectMake(SLIDER_WIDTH,0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    } completion:^(BOOL finished) {
        if (appDel.isProfileValueUpdated) {
            slideMenu=[SlideMenuController getSlideMenuInstance];
            appDel.isProfileValueUpdated = NO;
            NSIndexPath *zeroethIndexpath = [NSIndexPath indexPathForRow:0 inSection:0];
            [slideMenu.tblSidePanel beginUpdates];
            [slideMenu.tblSidePanel reloadRowsAtIndexPaths:@[zeroethIndexpath] withRowAnimation:UITableViewRowAnimationNone];
            [slideMenu.tblSidePanel endUpdates];
        }
        if (appDel.isCreateTagTappedFromDashboard) {
            slideMenu=[SlideMenuController getSlideMenuInstance];
            //appDel.isCreateTagTappedFromDashboard = NO;
            NSIndexPath *thirdIndexpath = [NSIndexPath indexPathForRow:3 inSection:0];
            [slideMenu.tblSidePanel beginUpdates];
            [slideMenu.tblSidePanel reloadRowsAtIndexPaths:@[thirdIndexpath] withRowAnimation:UITableViewRowAnimationNone];
            //[slideMenu.tblSidePanel selectRowAtIndexPath:thirdIndexpath animated:NO scrollPosition:UITableViewScrollPositionNone];
            [slideMenu.tblSidePanel endUpdates];
        }
        if (appDel.isMyTagTappedFromDashboard) {
            slideMenu=[SlideMenuController getSlideMenuInstance];
            // appDel.isMyTagTappedFromDashboard = NO;
            NSIndexPath *fifthIndexpath = [NSIndexPath indexPathForRow:5 inSection:0];
            [slideMenu.tblSidePanel beginUpdates];
            [slideMenu.tblSidePanel reloadRowsAtIndexPaths:@[fifthIndexpath] withRowAnimation:UITableViewRowAnimationNone];
            [slideMenu.tblSidePanel endUpdates];
        }
        if (appDel.isReadTagTappedFromDashboard) {
            slideMenu=[SlideMenuController getSlideMenuInstance];
            //appDel.isReadTagTappedFromDashboard = NO;
            NSIndexPath *fourthIndexpath = [NSIndexPath indexPathForRow:4 inSection:0];
            [slideMenu.tblSidePanel beginUpdates];
            [slideMenu.tblSidePanel reloadRowsAtIndexPaths:@[fourthIndexpath] withRowAnimation:UITableViewRowAnimationNone];
            [slideMenu.tblSidePanel endUpdates];
        }
        slideMenu.isSlideMenuVisible=YES;
        [self addImageViewOnController:navController];
    }];
}

-(void)closeSlider
{
    UINavigationController *navController=(UINavigationController*)[[[UIApplication sharedApplication] keyWindow] rootViewController];
    [self closeImageView];
    [UIView animateWithDuration:0.2 animations:^{
        navController.view.frame=CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width,  [[UIScreen mainScreen] bounds].size.height);
    } completion:^(BOOL finished) {
        slideMenu.isSlideMenuVisible=NO;
    }];
}


#pragma mark
#pragma mark sidebar Delegate
#pragma mark

-(void)selectedRowAtIndexPath:(NSIndexPath *)indexPath
{
    // [self closeImageView];
    UINavigationController *navController=(UINavigationController*)[[[UIApplication sharedApplication] keyWindow] rootViewController];
    [UIView animateWithDuration:0.2 animations:^{
        //navController.view.frame=CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width,  [[UIScreen mainScreen] bounds].size.height);
    } completion:^(BOOL finished) {
        
        //[slideMenu setIsSlideMenuVisible:NO];
        UIViewController *controller;
        UIStoryboard *mainStoryboard=[UIStoryboard storyboardWithName:@"Main"bundle: nil];
        switch (indexPath.row)
        {
            case 1:
                controller=( DashboardViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"DashboardViewController"];
                break;
                
            case 2:
                controller=(ProfileViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
                break;
                
            case 3:
                controller=(LivingTagsTemplateListController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"LivingTagsTemplateListController"];
                break;
                
            case 4:
                controller=(ReadAllTagsViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"ReadAllTagsViewController"];
                break;
                
            case 5:
                controller=(MyLivingTagesViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"MyLivingTagesViewController"];
                break;
                
            case 6:
                //controller=(ImportContactsViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"ImportContactsViewController"];
                break;
                
            case 7:
                //controller=(ImportContactsViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"ImportContactsViewController"];
                break;
                
            case 8:
                //controller=(ImportContactsViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"ImportContactsViewController"];
                break;
                
            case 9:
                //controller=(ImportContactsViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"ImportContactsViewController"];
                break;
                
            default:
                break;
        }
        
        NSLog(@"%@",self.navigationController.topViewController);
        if ((![[self.navigationController topViewController] isKindOfClass:[controller class]] && indexPath.row!=7) && (![[self.navigationController topViewController] isKindOfClass:[controller class]] && indexPath.row!=8) && (![[self.navigationController topViewController] isKindOfClass:[controller class]] && indexPath.row!=6))
        {
            navController.view.frame=CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width,  [[UIScreen mainScreen] bounds].size.height);
            [self closeImageView];
            [slideMenu setIsSlideMenuVisible:NO];
            
            [self.navigationController pushViewController:controller animated:YES];
        }
    }];
}


#pragma mark
#pragma mark Display AlertController for logout
#pragma mark

-(void)displayAlertControllerForLogout
{
    //[self closeSlider];
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"Do you want to logout from the application?" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionOK=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self logout];
    }];
    UIAlertAction *actionCancel=[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alertController dismissViewControllerAnimated:YES completion:^{
            
        }];
    }];
    [alertController addAction:actionOK];
    [alertController addAction:actionCancel];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:alertController animated:YES completion:^{
            
        }];
    });
    
}

#pragma mark
#pragma mark logout function
#pragma mark

-(void)logout
{
    appDel.isFirstTime = YES;
    appDel.isLogoutBtnTapped = YES;
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"user_id"];
    //Token
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"Token"];
    [self closeSlider];
    LoggingViewController *master=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"LoggingViewController"];
    [self.navigationController pushViewController:master animated:YES];
}

#pragma mark
#pragma mark ADD IMAGE VIEW ON NAVIGATION CONTROLLER
#pragma mark

-(void)addImageViewOnController:(UINavigationController *)controller
{
    ImageHoverController *master=[ImageHoverController getSlideMenuInstance];
    master.view.frame=CGRectMake(0, 0, controller.view.frame.size.width, controller.view.frame.size.height);
    [controller.view addSubview:master.view];
    [controller addChildViewController:master];
    [master didMoveToParentViewController:controller];
    master.delegate=self;
}

-(void)closeImageView
{
    ImageHoverController *master=[ImageHoverController getSlideMenuInstance];
    [master.view removeFromSuperview];
    [master removeFromParentViewController];
    master=nil;
}

#pragma mark
#pragma mark image tap delegate
#pragma mark

-(void)tapGesturePressed
{
    NSLog(@"Tap pressed");
    [self closeSlider];
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

@end
