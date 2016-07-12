//
//  LivingTagsSecondStepViewController.m
//  LivingTags
//
//  Created by appsbeetech on 12/07/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "LivingTagsSecondStepViewController.h"

@interface LivingTagsSecondStepViewController ()
{
    IBOutlet UILabel *lbl1;
    IBOutlet UILabel *lbl2;
    IBOutlet UILabel *lbl3;
}

@end

@implementation LivingTagsSecondStepViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillLayoutSubviews
{
    lbl3.layer.cornerRadius=lbl3.frame.size.width/2;
    lbl3.clipsToBounds=YES;
    
    lbl1.layer.cornerRadius=lbl3.frame.size.width/2;
    lbl1.clipsToBounds=YES;
    
    lbl2.layer.cornerRadius=lbl3.frame.size.width/2;
    lbl2.clipsToBounds=YES;
}


@end
