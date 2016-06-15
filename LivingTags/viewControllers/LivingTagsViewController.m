//  LivingTagsViewController.m
//  LivingTags
//
//  Created by appsbeetech on 01/06/16.
//  Copyright © 2016 appsbeetech. All rights reserved.

#import "LivingTagsViewController.h"

@interface LivingTagsViewController ()
{
    IBOutlet UIWebView *wbLivingTags;
    IBOutlet UILabel *lblHeader;
}
@end

@implementation LivingTagsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [wbLivingTags setBackgroundColor:[UIColor clearColor]];
    [wbLivingTags setOpaque:NO];
    lblHeader.text=self.objHTML.strName;
    [wbLivingTags loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://livingtags.digiopia.in/tags/%@",self.objHTML.strWebURI]]]];
    wbLivingTags.delegate=self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
