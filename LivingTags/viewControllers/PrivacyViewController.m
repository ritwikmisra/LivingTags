//
//  PrivacyViewController.m
//  LivingTags
//
//  Created by appsbeetech on 19/11/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "PrivacyViewController.h"


@interface PrivacyViewController ()
{
    IBOutlet UIWebView *wbViewAboutUS;
    IBOutlet UILabel *lblHeader;
}

@end

@implementation PrivacyViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    //wbViewAboutUS.backgroundColor=[UIColor clearColor];
    NSString *strhtmlFile=[[NSBundle mainBundle]pathForResource:@"privacy_policy" ofType:@"html"] ;
    NSString *strHtml=[NSString stringWithContentsOfFile:strhtmlFile encoding:NSUTF8StringEncoding error:nil] ;
    [wbViewAboutUS loadHTMLString:strHtml baseURL:nil] ;
    lblHeader.text=self.str;
}




@end
