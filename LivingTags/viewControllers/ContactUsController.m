//
//  ContactUsController.m
//  LivingTags
//
//  Created by appsbeetech on 21/11/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "ContactUsController.h"
#import <MessageUI/MessageUI.h>


@interface ContactUsController ()<MFMailComposeViewControllerDelegate>
{
    IBOutlet UIWebView *wbViewAboutUS;

}

@end

@implementation ContactUsController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark
#pragma mark IBACTIONS
#pragma mark

-(IBAction)btnEmailInfoPressed:(id)sender
{
    MFMailComposeViewController *comp=[[MFMailComposeViewController alloc]init];
    [comp setMailComposeDelegate:self];
    if([MFMailComposeViewController canSendMail]) {
        [comp setToRecipients:[NSArray arrayWithObjects:@"", nil]];
        [comp setSubject:@"Living Tags"];
        [comp setMessageBody:@"" isHTML:NO];
        [comp setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
        [self presentViewController:comp animated:YES completion:nil];
    }
}

-(IBAction)btnEmailBizdevPressed:(id)sender
{
    MFMailComposeViewController *comp=[[MFMailComposeViewController alloc]init];
    [comp setMailComposeDelegate:self];
    if([MFMailComposeViewController canSendMail])
    {
        [comp setToRecipients:[NSArray arrayWithObjects:@"", nil]];
        [comp setSubject:@"Living Tags"];
        [comp setMessageBody:@"" isHTML:NO];
        [comp setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
        [self presentViewController:comp animated:YES completion:nil];
    }
}

#pragma mark
#pragma mark MAIL COMPOSER DELEGATES
#pragma mark

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    if(error) {
        UIAlertView *alrt=[[UIAlertView alloc]initWithTitle:@"" message:@"" delegate:nil cancelButtonTitle:@"" otherButtonTitles:nil, nil];
        [alrt show];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


@end
