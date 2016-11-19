//
//  AboutUsController.m
//  LivingTags
//
//  Created by appsbeetech on 19/11/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "AboutUsController.h"

@interface AboutUsController ()
{
    IBOutlet UIWebView *wbViewAboutUS;
}

@end

@implementation AboutUsController

-(void)viewDidLoad
{
    [super viewDidLoad];
    //wbViewAboutUS.backgroundColor=[UIColor clearColor];
    NSString *strhtmlFile=[[NSBundle mainBundle]pathForResource:@"about" ofType:@"html"] ;
    NSString *strHtml=[NSString stringWithContentsOfFile:strhtmlFile encoding:NSUTF8StringEncoding error:nil] ;
    [wbViewAboutUS loadHTMLString:strHtml baseURL:nil] ;
}

@end
