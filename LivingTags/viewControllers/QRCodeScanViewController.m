//
//  QRCodeScanViewController.m
//  LivingTags
//
//  Created by appsbeetech on 18/10/16.
//  Copyright © 2016 appsbeetech. All rights reserved.


#import "QRCodeScanViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImageView+WebCache.h"
#import "PreviewViewController.h"

@interface QRCodeScanViewController ()
{
    IBOutlet UILabel *lblTagHeading;
    IBOutlet UILabel *lblTagBody;
    IBOutlet UIView *vwQRCode;
    IBOutlet UIImageView *imgQR;
    IBOutlet UILabel *lblPublishLink;
    IBOutlet UIActivityIndicatorView *actIndicatorQRCodes;

}

@end

@implementation QRCodeScanViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    vwQRCode.layer.borderWidth=1.0f;
    vwQRCode.layer.borderColor=[UIColor colorWithRed:76/255.0f green:87/255.0f blue:95/255.0f alpha:1.0].CGColor;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (___isIphone4_4s)
    {
        [lblTagHeading setFont:[UIFont systemFontOfSize:12]];
        [lblTagBody setFont:[UIFont systemFontOfSize:9]];
    }
    else if (___isIphone5_5s)
    {
        [lblTagHeading setFont:[UIFont systemFontOfSize:14]];
        [lblTagBody setFont:[UIFont systemFontOfSize:10]];
    }
    else if (___isIphone6)
    {
        
    }
    else
    {
        [lblTagHeading setFont:[UIFont systemFontOfSize:17]];
        [lblTagBody setFont:[UIFont systemFontOfSize:13]];
    }
    NSLog(@"%@",self.dictQR);
    dispatch_async(dispatch_get_main_queue(), ^{
        [imgQR sd_setImageWithURL:[NSURL URLWithString:[self.dictQR objectForKey:@"qrCodeUrl"]]
                 placeholderImage:[UIImage imageNamed:@"defltmale_user_icon"]
                          options:SDWebImageHighPriority
                         progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                             [actIndicatorQRCodes startAnimating];
                         }
                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                            [actIndicatorQRCodes stopAnimating];
                        }];
    });
    NSString *strLabel=[self.dictQR objectForKey:@"tagUrl"];
    lblPublishLink.text=strLabel;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark
#pragma mark IBACTIONS
#pragma mark

-(IBAction)btnViewYourLivingTagPressed:(id)sender
{
   // [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[self.dictQR objectForKey:@"tagUrl"]]];
    [self performSegueWithIdentifier:@"seguePublish" sender:self];
}

#pragma mark
#pragma mark PREPARE FOR SEGUE
#pragma mark

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"seguePublish"])
    {
        PreviewViewController *master=[segue destinationViewController];
        NSString *str=[self.dictQR objectForKey:@"tagUrl"];
        str=[str stringByReplacingOccurrencesOfString:@"https" withString:@"http"];
        master.str=str;
        master.strLabel=@"PUBLISHED TAG";
    }
}

@end
