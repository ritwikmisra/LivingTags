//
//  QRCodeViewController.m
//  LivingTags
//
//  Created by appsbeetech on 09/08/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "QRCodeViewController.h"
#import "PreviewViewController.h"
#import "UIImageView+WebCache.h"


@interface QRCodeViewController ()
{
    IBOutlet UILabel *lblWebsite;
    IBOutlet UIImageView *imgQRCode;
    IBOutlet UIActivityIndicatorView *actIndicator;
}

@end

@implementation QRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",self.strWebURI);
    lblWebsite.text=[NSString stringWithFormat:@"http://livingtags.digiopia.in/tags/%@",self.strWebURI];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //https://chart.googleapis.com/chart?chs=200x200&cht=qr&chl=<FULL_URL>&choe=UTF-8%22%20title=<name>
    NSString *strURL=[NSString stringWithFormat:@"https://chart.googleapis.com/chart?chs=200x200&cht=qr&chl=%@&choe=UTF-8%22%20title=livingtags.com",lblWebsite.text];
    NSLog(@"%@",strURL);
    NSURL *url=[NSURL URLWithString:strURL];
    dispatch_async(dispatch_get_main_queue(), ^{
        [imgQRCode sd_setImageWithURL:url
                            placeholderImage:[UIImage imageNamed:@"defltmale_user_icon"]
                                     options:SDWebImageHighPriority
                                    progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//                                        if (cellA.actProfileIndicator)
//                                        {
//                                            [cellA.actProfileIndicator startAnimating];
//                                        }
                                        [actIndicator startAnimating];
                                    }
                                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                     //  [cellA.actProfileIndicator stopAnimating];
                                       [actIndicator stopAnimating];
                                   }];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark
#pragma mark IBACTIONS
#pragma mark

-(IBAction)btnDashBoardPressed:(id)sender
{
    [self performSegueWithIdentifier:@"segueQRcodeToDashboard" sender:self];
}

-(IBAction)btnWebViewPressed:(id)sender
{
    [self performSegueWithIdentifier:@"segueWebPage" sender:self];
}

#pragma mark
#pragma mark prepare for segue
#pragma mark

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"segueWebPage"])
    {
        PreviewViewController *master=[segue destinationViewController];
        master.str=lblWebsite.text;
    }
}

@end
