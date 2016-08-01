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
}

@end

@implementation PreviewViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    webPreview.delegate=self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[CreateTagsPublishService service]callPublishServiceWithLivingTagsID:self.strTemplateID withCompletionHandler:^(id  _Nullable result, BOOL isError, NSString * _Nullable strMsg) {
        if (isError)
        {
            
        }
        else
        {
            NSLog(@"%@",result);
            NSString *str=[NSString stringWithFormat:@"%@",result];
            [webPreview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        }
    }];
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
