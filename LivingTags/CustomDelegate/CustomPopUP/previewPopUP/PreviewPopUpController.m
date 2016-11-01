//
//  PreviewPopUpController.m
//  LivingTags
//
//  Created by appsbeetech on 18/10/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "PreviewPopUpController.h"
#import <QuartzCore/QuartzCore.h>

@interface PreviewPopUpController ()
{
    IBOutlet UIView *vwPopUP;
    IBOutlet UIButton *btnPreview;
    IBOutlet UIButton *btnPublic;
    IBOutlet UILabel *lblPopUP;

}

@end

@implementation PreviewPopUpController

- (void)viewDidLoad
{
    [super viewDidLoad];
    vwPopUP.layer.cornerRadius=10.0f;
    if (___isIphone5_5s)
    {
        [lblPopUP setFont:[UIFont systemFontOfSize:12]];
    }
    else if (___isIphone4_4s)
    {
        [lblPopUP setFont:[UIFont systemFontOfSize:10]];

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    ////round corner for preview button/////
    
    UIBezierPath *maskPath = [UIBezierPath
                              bezierPathWithRoundedRect:btnPreview.bounds
                              byRoundingCorners:(UIRectCornerBottomLeft )
                              cornerRadii:CGSizeMake(8.0f, 0.0f)
                              ];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = btnPreview.bounds;
    maskLayer.path = maskPath.CGPath;
    btnPreview.layer.mask = maskLayer;
    
    /////round corner for public button //////
    
    UIBezierPath *maskPath1= [UIBezierPath
                              bezierPathWithRoundedRect:btnPublic.bounds
                              byRoundingCorners:( UIRectCornerBottomRight)
                              cornerRadii:CGSizeMake(8.0f, 0.0f)
                              ];
    
    CAShapeLayer *maskLayer1 = [CAShapeLayer layer];
    maskLayer1.frame = btnPublic.bounds;
    maskLayer1.path = maskPath1.CGPath;
    btnPublic.layer.mask = maskLayer1;
}

#pragma mark
#pragma mark IBACTIONS
#pragma mark

-(IBAction)btnClosePressed:(id)sender
{
    [self.view removeFromSuperview];
}

-(IBAction)btnPreviewPressed:(id)sender
{
    [self.view removeFromSuperview];
    if (self.myDelegate && [self.myDelegate respondsToSelector:@selector(previewButtonPressed)])
    {
        [self.myDelegate previewButtonPressed];
    }
}

-(IBAction)btnPublishPressed:(id)sender
{
    [self.view removeFromSuperview];
    if (self.myDelegate && [self.myDelegate respondsToSelector:@selector(publishButtonPressed)])
    {
        [self.myDelegate publishButtonPressed];
    }
}
@end
