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
}

@end

@implementation PreviewPopUpController

- (void)viewDidLoad {
    [super viewDidLoad];
    vwPopUP.layer.cornerRadius=5.0f;
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
