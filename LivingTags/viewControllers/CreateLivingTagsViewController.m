//
//  CreateLivingTagsViewController.m
//  LivingTags
//
//  Created by appsbeetech on 09/06/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "CreateLivingTagsViewController.h"
#import "RecordViewController.h"

#define BASE_URL @"http://192.168.0.1/LivingTags/www/"
//#define BASE_URL @"http://livingtags.digiopia.in/"

@interface CreateLivingTagsViewController ()<UIWebViewDelegate,UINavigationControllerDelegate,RecordVoiceDelegate>
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
    NSString *str=[NSString stringWithFormat:@"%@livingtags/use_template/%@",BASE_URL,self.strTemplateID];
    NSURL* url = [NSURL URLWithString:str];
    NSString *strDomain = [url host];
    NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
    [cookieProperties setObject:@"token" forKey:NSHTTPCookieName];
    [cookieProperties setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"] forKey:NSHTTPCookieValue];
    [cookieProperties setObject:strDomain forKey:NSHTTPCookieDomain];
    [cookieProperties setObject:@"/" forKey:NSHTTPCookiePath];
    
    // set expiration to one month from now or any NSDate of your choosing
    // this makes the cookie sessionless and it will persist across web sessions and app launches
    // if you want the cookie to be destroyed when your app exits, don't set this
    
    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:cookieProperties];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    /////
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    [request setURL:[NSURL URLWithString:str]];
    [wbCreateTags loadRequest:request];
    wbCreateTags.allowsInlineMediaPlayback=YES;
    wbCreateTags.delegate=self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark
#pragma mark WEBVIEW DELEGATES
#pragma mark


- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self displayNetworkActivity];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self hideNetworkActivity];
}


-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Error!"
                                  message:@"Failed to load the form. Please refresh."
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"Refresh"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             [self viewDidLoad];
                             
                         }];
    
    [alert addAction:ok];
    
    [self presentViewController:alert animated:YES completion:nil];
}


- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType
{
    //rel=@"yahoo"
    NSLog(@"%@",[[request URL] absoluteString]);
    if ([[[request URL] absoluteString] containsString:@"#"])
    {
        [self callNativeEndFunction];
        return NO;
    }
    return YES;
}

-(void)callNativeEndFunction
{
    NSLog(@"Native End Function Called");
    [self performSegueWithIdentifier:@"segueRecord" sender:self];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

#pragma mark
#pragma mark record voice delegate
#pragma mark

-(void)getVoice:(NSString *)strBase64
{
    NSLog(@"%@",strBase64);
    if (strBase64.length>0)
    {
        [wbCreateTags stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"javascript:setAudioBase64('%@');",strBase64]];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    RecordViewController *master=[segue destinationViewController];
    master.delegate=self;
}
@end
