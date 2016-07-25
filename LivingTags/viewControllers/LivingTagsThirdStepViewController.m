//
//  LivingTagsThirdStepViewController.m
//  LivingTags
//
//  Created by appsbeetech on 25/07/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "LivingTagsThirdStepViewController.h"

@interface LivingTagsThirdStepViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UILabel *lbl1;
    IBOutlet UILabel *lbl2;
    IBOutlet UILabel *lbl3;
    IBOutlet UILabel *lbl4;
    IBOutlet UITableView *tblAThirdStep;
}

@end

@implementation LivingTagsThirdStepViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    tblAThirdStep.separatorStyle=UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)viewWillLayoutSubviews
{
    lbl3.layer.cornerRadius=lbl3.frame.size.width/2;
    lbl3.clipsToBounds=YES;
    
    lbl1.layer.cornerRadius=lbl3.frame.size.width/2;
    lbl1.clipsToBounds=YES;
    
    lbl4.layer.cornerRadius=lbl4.frame.size.width/2;
    lbl4.clipsToBounds=YES;
    
    lbl2.layer.cornerRadius=lbl3.frame.size.width/2;
    lbl2.clipsToBounds=YES;
}

#pragma mark
#pragma mark Tableview datasouce and delegate
#pragma mark

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
