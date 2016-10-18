//
//  QRCodeScanViewController.m
//  LivingTags
//
//  Created by appsbeetech on 18/10/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "QRCodeScanViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface QRCodeScanViewController ()
{
    IBOutlet UILabel *lblTagHeading;
    IBOutlet UILabel *lblTagBody;
    IBOutlet UIView *vwQRCode;
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
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
