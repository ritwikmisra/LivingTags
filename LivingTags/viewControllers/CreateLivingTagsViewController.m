//
//  CreateLivingTagsViewController.m
//  LivingTags
//
//  Created by appsbeetech on 09/06/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "CreateLivingTagsViewController.h"

@interface CreateLivingTagsViewController ()<UIWebViewDelegate,UINavigationControllerDelegate>
{
    IBOutlet UIWebView *wbCreateTags;
}

@end

@implementation CreateLivingTagsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [wbCreateTags setBackgroundColor:[UIColor clearColor]];
    [wbCreateTags setOpaque:NO];
    
    NSLog(@"USER ID =%@\nTOKEN=%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"],[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"]);
    ////set cookie
    //http://192.168.0.1/LivingTags/invoke.php
    //NSString *str=@"http://192.168.0.1/LivingTags/www/livingtags/template_fillup/1";
    NSString *str=@"http://192.168.0.1/LivingTags/invoke.php";
    NSURL* url = [NSURL URLWithString:str];
    NSString *strDomain = [url host];
    NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
    [cookieProperties setObject:@"token" forKey:NSHTTPCookieName];
    [cookieProperties setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"] forKey:NSHTTPCookieValue];
    [cookieProperties setObject:strDomain forKey:NSHTTPCookieDomain];
    [cookieProperties setObject:@"/" forKey:NSHTTPCookiePath];
    
    // set expiration to one month from now or any NSDate of your choosing
    // this makes the cookie sessionless and it will persist across web sessions and app launches
    /// if you want the cookie to be destroyed when your app exits, don't set this
    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:cookieProperties];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    /////
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    //[request setURL:[NSURL URLWithString:@"http://192.168.0.1/LivingTags/www/livingtags/template_fillup/1"]];
    [request setURL:[NSURL URLWithString:@"http://192.168.0.1/LivingTags/invoke.php"]];
    [wbCreateTags loadRequest:request];
    wbCreateTags.delegate=self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    ///////
}

-(void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion
{
    if ( self.presentedViewController)
    {
        [super dismissViewControllerAnimated:flag completion:completion];
    }
}

/*
 String cookieString = "token=" + App.getInstance().getAppPreference().getApiToken();
 String domainName = Util.getDomainName(Constant.URL.BASEURL);
 cookieManager.setCookie(domainName, cookieString);
 http://192.168.0.1/LivingTags/www/livingtags/template_fillup/1
 */

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
