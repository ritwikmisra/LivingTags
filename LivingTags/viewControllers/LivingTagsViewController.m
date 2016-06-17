//  LivingTagsViewController.m
//  LivingTags
//
//  Created by appsbeetech on 01/06/16.
//  Copyright © 2016 appsbeetech. All rights reserved.

#import "LivingTagsViewController.h"

@interface LivingTagsViewController ()<UIWebViewDelegate>
{
    IBOutlet UIWebView *wbLivingTags;
    IBOutlet UILabel *lblHeader;
}
@end

@implementation LivingTagsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [wbLivingTags setBackgroundColor:[UIColor clearColor]];
    [wbLivingTags setOpaque:NO];
    lblHeader.text=self.objHTML.strName;
    [wbLivingTags loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://livingtags.digiopia.in/tags/%@",self.objHTML.strWebURI]]]];
    wbLivingTags.delegate=self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark
#pragma mark webview delegate
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
@end
