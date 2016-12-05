//
//  CommentDetailsController.m
//  LivingTags
//
//  Created by appsbeetech on 01/12/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "CommentDetailsController.h"

@interface CommentDetailsController ()
{
    IBOutlet UIImageView *imgComment;
}

@end

@implementation CommentDetailsController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    imgComment.layer.cornerRadius=imgComment.frame.size.width/2;
    imgComment.clipsToBounds=YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
