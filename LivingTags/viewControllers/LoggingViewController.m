//
//  LoggingViewController.m
//  LivingTags
//
//  Created by appsbeetech on 21/04/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "LoggingViewController.h"
#import "LoginService.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "socialLoginFirstService.h"

static NSString *const kPlaceholderUserName = @"<Name>";
static NSString *const kPlaceholderEmailAddress = @"<Email>";
static NSString *const kPlaceholderAvatarImageName = @"PlaceholderAvatar.png";


@interface LoggingViewController ()<UITextFieldDelegate,GIDSignInUIDelegate,GIDSignInDelegate>
{
    IBOutlet UILabel *lblOR;
    IBOutlet UIButton *btnSignIn;
    IBOutlet UIButton *btnSignUp;
    IBOutlet UIButton *btnForgotPassword;
    IBOutlet UITextField *txtEmail;
    IBOutlet UITextField *txtPassword;
    IBOutlet UIImageView *img;
    BOOL isViewUp;
    IBOutlet NSLayoutConstraint *constVwHeight;
    NSString *strEmail,*strID,*strName,*strImageURL,*strSocialSite,*strEmailAvailable;
}

@end

@implementation LoggingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    lblOR.layer.cornerRadius=lblOR.frame.size.height/2;
    lblOR.layer.masksToBounds=YES;
    btnSignIn.layer.cornerRadius=5.0f;
    btnSignUp.layer.cornerRadius=5.0f;
    [txtEmail setValue:[UIColor colorWithRed:98.0/255.0 green:105.0/255.0 blue:108.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
    [txtPassword setValue:[UIColor colorWithRed:98.0/255.0 green:105.0/255.0 blue:108.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
    [GIDSignInButton class];
    GIDSignIn *signIn = [GIDSignIn sharedInstance];
    signIn.shouldFetchBasicProfile = YES;
    signIn.delegate = self;
    signIn.uiDelegate = self;
    txtEmail.text=@"sourav.hazra@appsbee.com";
    txtPassword.text=@"123456";
}

-(void)viewDidLayoutSubviews
{
    [self.signInButton setStyle:kGIDSignInButtonStyleIconOnly];
    [self.signInButton setColorScheme:kGIDSignInButtonColorSchemeDark];
    constVwHeight.constant=3.0f;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark
#pragma mark IBACTIONS
#pragma mark

-(IBAction)btnSignUpPressed:(id)sender
{
    [self performSegueWithIdentifier:@"segueRegistration" sender:self];
}

-(IBAction)btnSignInPressed:(id)sender
{
    if (isViewUp)
    {
        [self viewDown];
        [self.view endEditing:YES];
    }
    if ([self alertChecking])
    {
        NSString *str=[self generateMD5:txtPassword.text];
        [[LoginService service]callLoginServiceWithEmailID:txtEmail.text Password:str withCompletionHandler:^(id  _Nullable result, BOOL isError, NSString * _Nullable strMsg) {
            if (isError)
            {
                UIAlertController *alertController=[UIAlertController alertControllerWithTitle:nil message:strMsg preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *actionOK=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self dismissViewControllerAnimated:YES completion:^{
                        
                    }];
                }];
                [alertController addAction:actionOK];
                [self presentViewController:alertController animated:YES completion:^{
                    
                }];
            }
            else
            {
                //segueImportContacts
                [self performSegueWithIdentifier:@"segueLoginToDashboard" sender:self];
            }
        }];
    }
}

-(IBAction)btnFacebookPressed:(id)sender
{
    appDel.isFacebook=YES;
    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
    [parameters setValue:@"id,name,email" forKey:@"fields"];
    FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
    if (appDel.isRechable)
    {
        [loginManager logOut];
        if ([FBSDKAccessToken currentAccessToken])
        {
            [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:parameters]
             startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                          id result, NSError *error){
                 if (error)
                 {
                     NSLog(@"%@",error.description);
                 }
                 else
                 {
                     NSError *errorJson=nil;
                     NSLog(@"fetched user:%@",[[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:result options:NSJSONWritingPrettyPrinted error:&errorJson] encoding:NSUTF8StringEncoding]);
                     NSString *str=[[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:result options:NSJSONWritingPrettyPrinted error:&errorJson] encoding:NSUTF8StringEncoding] ;
                     NSData *data=[str dataUsingEncoding:NSUTF8StringEncoding] ;
                     NSMutableDictionary *dict=[NSJSONSerialization JSONObjectWithData:data
                                                                               options:NSJSONReadingMutableContainers
                                                                                 error:&errorJson];
                     NSLog(@"dict%@",dict);
                     strEmail=[dict objectForKey:@"email"];
                     strName=[dict objectForKey:@"name"];
                     strID=[dict objectForKey:@"id"];
                     strImageURL=[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&redirect=true&width=1000&height=1000 ",strID];
                     strSocialSite=@"FACEBOOK";
                     [self callSocialLoginWebservice];
                 }
             }];
        }
        else
        {
            [loginManager logInWithReadPermissions:@[@"email",@"public_profile"]
                                fromViewController:self
                                           handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                                             
                                               if (error)
                                               {
                                                   
                                               }
                                               else if(result.isCancelled)
                                               {
                                                   
                                               }
                                               else
                                               {
                                                   if ([[result grantedPermissions] containsObject:@"public_profile"])
                                                   {
                                                       [[[FBSDKGraphRequest alloc] initWithGraphPath:@"/me" parameters:parameters]
                                                        startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                                                            NSError *errorJson=nil;
                                                            NSLog(@"fetched user:%@", [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:result options:NSJSONWritingPrettyPrinted error:&errorJson] encoding:NSUTF8StringEncoding]);
                                                            NSString *str=[[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:result options:NSJSONWritingPrettyPrinted error:&errorJson] encoding:NSUTF8StringEncoding] ;
                                                            NSData *data=[str dataUsingEncoding:NSUTF8StringEncoding] ;
                                                            NSMutableDictionary *dict=[NSJSONSerialization JSONObjectWithData:data
                                                                                                                      options:NSJSONReadingMutableContainers
                                                                                                                        error:&errorJson];
                                                            NSLog(@"dict%@",dict);
                                                            strEmail=[dict objectForKey:@"email"];
                                                            strName=[dict objectForKey:@"name"];
                                                            strID=[dict objectForKey:@"id"];
                                                            strImageURL=[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&redirect=true&width=1000&height=1000 ",strID];
                                                            strSocialSite=@"FACEBOOK";
                                                            [self callSocialLoginWebservice];
                                                        }];
                                                   }
                                               }
                                           }];
        }
    }
    else
    {
        [self displayErrorWithMessage:@"Please check your internet connection!!"];
    }
}

-(IBAction)btnForgetPasswordPressed:(id)sender
{
    [self performSegueWithIdentifier:@"segueForgetPassword" sender:self];
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
        [self viewDown];
        [textField resignFirstResponder];
    }
    return YES;
}

#pragma mark 
#pragma mark alert checking
#pragma mark

-(BOOL)alertChecking
{
    if (txtEmail.text.length==0)
    {
        [self displayErrorWithMessage:@"Please enter a valid email id"];
        return NO;
    }
    if (txtPassword.text.length==0)
    {
        [self displayErrorWithMessage:@"Please enter the password."];
        return NO;
    }
    if (![self isValidEmail:[txtEmail.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]])
    {
        [self displayErrorWithMessage:@"Please enter a valid email id!"];
        return NO;
    }
    return YES;
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
    } completion:^(BOOL finished) {
        isViewUp=NO;
    }];
}

#pragma mark
#pragma mark google login delegates
#pragma mark


- (void)signIn:(GIDSignIn *)signIn
didSignInForUser:(GIDGoogleUser *)user
     withError:(NSError *)error
{
    appDel.isFacebook=NO;
    if (error)
    {
        NSLog(@"Status:  Authentication error: %@", error);
        return;
    }
    [self reportAuthStatus];
}

- (void)signIn:(GIDSignIn *)signIn
didDisconnectWithUser:(GIDGoogleUser *)user
     withError:(NSError *)error
{
    if (error)
    {
        NSLog(@"Status: Failed to disconnect: %@", error);
    }
    else
    {
        NSLog(@"Status: Disconnected");
    }
}

- (void)presentSignInViewController:(UIViewController *)viewController
{
    [[self navigationController] pushViewController:viewController animated:YES];
}

- (void)reportAuthStatus
{
    GIDGoogleUser *googleUser = [[GIDSignIn sharedInstance] currentUser];
    if (googleUser.authentication)
    {
        NSLog(@"Status: Authenticated");
    }
    else
    {
        // To authenticate, use Google+ sign-in button.
        NSLog(@"Status: Not authenticated");
    }
    [self refreshUserInfo];
}

- (void)refreshUserInfo
{
    if ([GIDSignIn sharedInstance].currentUser.authentication == nil)
    {
        return;
    }
    NSLog(@"%@", [GIDSignIn sharedInstance].currentUser.profile.email);
    NSLog(@"%@",[GIDSignIn sharedInstance].currentUser.profile.name);
    NSLog(@"%@",[GIDSignIn sharedInstance].currentUser.userID);
    if (![GIDSignIn sharedInstance].currentUser.profile.hasImage)
    {
        // There is no Profile Image to be loaded.
        return;
    }
    NSUInteger dimension=1024;
    NSURL *imageURL =[[GIDSignIn sharedInstance].currentUser.profile imageURLWithDimension:dimension];
    strImageURL=[NSString stringWithFormat:@"%@",imageURL];
    NSLog(@"%@",strImageURL);
    strEmail= [GIDSignIn sharedInstance].currentUser.profile.email;
    strID=[GIDSignIn sharedInstance].currentUser.userID;
    strName=[GIDSignIn sharedInstance].currentUser.profile.name;
    [[GIDSignIn sharedInstance] signOut];
    strSocialSite=@"GMAIL";
    [self callSocialLoginWebservice];
    // Load avatar image asynchronously, in background
   /* dispatch_queue_t backgroundQueue =
    dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    __weak SignInViewController *weakSelf = self;
    
    dispatch_async(backgroundQueue, ^{
        NSUInteger dimension = round(self.userAvatar.frame.size.width * [[UIScreen mainScreen] scale]);
        NSURL *imageURL =
        [[GIDSignIn sharedInstance].currentUser.profile imageURLWithDimension:dimension];
        NSData *avatarData = [NSData dataWithContentsOfURL:imageURL];
        
        if (avatarData)
        {
            // Update UI from the main thread when available
            dispatch_async(dispatch_get_main_queue(), ^{
                SignInViewController *strongSelf = weakSelf;
                if (strongSelf) {
                    strongSelf.userAvatar.image = [UIImage imageWithData:avatarData];
                }
            });
        }
    });*/
}

#pragma mark
#pragma mark webservice social login 
#pragma mark

-(void)callSocialLoginWebservice
{
    if (strEmail.length==0)
    {
        strEmail=@"";
        strEmailAvailable=@"N";
    }
    else
    {
        strEmailAvailable=@"Y";
    }
    [[socialLoginFirstService service]callSocialServiceFirstTymWithSocialAccountID:strID email:strEmail picture:strImageURL name:strName socialSite:strSocialSite socialEmailAvailable:strEmailAvailable withCompletionHandler:^(id  _Nullable result, BOOL isError, NSString * _Nullable strMsg) {
        if (isError)
        {
            [self displayErrorWithMessage:strMsg];
        }
        else
        {
            [self performSegueWithIdentifier:@"segueLoginToDashboard" sender:self];
        }
    }];
}

@end
