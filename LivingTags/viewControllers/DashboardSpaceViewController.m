//
//  DashboardSpaceViewController.m
//  LivingTags
//
//  Created by appsbeetech on 10/11/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "DashboardSpaceViewController.h"

@interface DashboardSpaceViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    IBOutlet UITableView *tblComments;
    IBOutlet UIView *vwColour;
}

@end

@implementation DashboardSpaceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    tblComments.separatorStyle=UITableViewCellSeparatorStyleNone;
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    vwColour.layer.cornerRadius=vwColour.frame.size.height/2;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark
#pragma mark tableview datasource and delegates
#pragma mark

@end
