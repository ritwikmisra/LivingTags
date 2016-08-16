//
//  CustomPopUpViewController.m
//  LivingTags
//
//  Created by appsbeetech on 16/08/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "CustomPopUpViewController.h"

@interface CustomPopUpViewController ()
{
}

@end

@implementation CustomPopUpViewController

+(id)sharedInstance
{
    static CustomPopUpViewController *master=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        master=[[CustomPopUpViewController alloc]init];
    });
    return master;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark
#pragma mark  IBACTION
#pragma mark

-(IBAction)btnCameraPressed:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(takePictureFromCamera)])
    {
        [self.delegate takePictureFromCamera];
    }
}

-(IBAction)btnGalleryPressed:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(takePictureFromGallery)])
    {
        [self.delegate takePictureFromGallery];
    }

}

-(IBAction)btnCancelPressed:(id)sender
{
    [self.view removeFromSuperview];
}

@end
