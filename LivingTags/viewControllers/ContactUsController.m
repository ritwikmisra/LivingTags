//
//  ContactUsController.m
//  LivingTags
//
//  Created by appsbeetech on 21/11/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "ContactUsController.h"

@interface ContactUsController ()
{
    IBOutlet UIWebView *wbViewAboutUS;

}

@end

@implementation ContactUsController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *strhtmlFile=[[NSBundle mainBundle]pathForResource:@"about" ofType:@"html"] ;
    NSString *strHtml=[NSString stringWithContentsOfFile:strhtmlFile encoding:NSUTF8StringEncoding error:nil] ;
    [wbViewAboutUS loadHTMLString:strHtml baseURL:nil] ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
