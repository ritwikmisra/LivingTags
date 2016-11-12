//
//  MyTagsPrivacyController.m
//  LivingTags
//
//  Created by appsbeetech on 12/11/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "MyTagsPrivacyController.h"
#import "MyTagsCell.h"

@interface MyTagsPrivacyController ()<UITableViewDelegate,UITableViewDataSource>
{
    IBOutlet UITableView *tblMyTagsPrivacy;
    NSString *strStatus;
}
@end

@implementation MyTagsPrivacyController

-(void)viewDidLoad
{
    [super viewDidLoad];
    tblMyTagsPrivacy.separatorStyle=UITableViewCellSeparatorStyleNone;
    tblMyTagsPrivacy.backgroundColor=[UIColor clearColor];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

#pragma mark
#pragma mark tableview delegate and datasource
#pragma mark

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (___isIphone6Plus)
    {
        return 100.0f;
    }
    return 80.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyTagsCell *cell=[tableView dequeueReusableCellWithIdentifier:@"123"];
    if (!cell)
    {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"MyTagsCell" owner:self options:nil]objectAtIndex:0];
    }
    cell.backgroundColor=[UIColor whiteColor];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
    
}

@end
