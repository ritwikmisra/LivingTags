//
//  QRCodeViewController.m
//  LivingTags
//
//  Created by appsbeetech on 09/08/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "QRCodeViewController.h"
#import "PreviewViewController.h"

@interface QRCodeViewController ()
{
    IBOutlet UILabel *lblWebsite;
}

@end

@implementation QRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",self.strWebURI);
    lblWebsite.text=[NSString stringWithFormat:@"http://livingtags.digiopia.in/tags/%@",self.strWebURI];
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
