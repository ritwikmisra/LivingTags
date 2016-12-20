//
//  QRCodeImagePopUpController.m
//  LivingTags
//
//  Created by appsbeetech on 20/12/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "QRCodeImagePopUpController.h"
#import "UIImageView+WebCache.h"


@interface QRCodeImagePopUpController ()
{
    IBOutlet UIImageView  *imgQRCode;
    IBOutlet UIActivityIndicatorView *actIndicator;
}

@end

@implementation QRCodeImagePopUpController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"%@",self.strQRLink);
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    dispatch_async(dispatch_get_main_queue(), ^{
        [imgQRCode sd_setImageWithURL:[NSURL URLWithString:self.strQRLink]
                                     placeholderImage:[UIImage imageNamed:@"defltmale_user_icon"]
                                              options:SDWebImageHighPriority
                                             progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                                 [actIndicator startAnimating];
                                             }
                                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                                [actIndicator stopAnimating];
                                                
                                            }];
    });

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark
#pragma mark IBACTIONS
#pragma mark

-(IBAction)btnOKPressed:(id)sender
{
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}


@end
