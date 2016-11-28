//
//  PreviewViewController.m
//  LivingTags
//
//  Created by appsbeetech on 01/08/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "PreviewViewController.h"
#import "CreateTagsPublishService.h"

@interface PreviewViewController ()<UIWebViewDelegate>
{
    IBOutlet UIWebView *webPreview;
    IBOutlet UILabel *lblHeader;
}

@end

@implementation PreviewViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.str=[self.str stringByReplacingOccurrencesOfString:@"https" withString:@"http"];
    webPreview.backgroundColor=[UIColor clearColor];
    webPreview.delegate=self;
    lblHeader.text=self.strLabel;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"%@",self.str);
    [webPreview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.str]]];
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
#pragma mark WEBVIEW DELEGATE
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
    [self hideNetworkActivity];
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
