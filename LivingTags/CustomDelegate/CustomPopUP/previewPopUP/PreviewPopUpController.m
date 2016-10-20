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

}

@end

@implementation PreviewPopUpController

- (void)viewDidLoad {
    [super viewDidLoad];
    vwPopUP.layer.cornerRadius=10.0f;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
