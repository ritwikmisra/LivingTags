//
//  ViewOtherTagsController.m
//  LivingTags
//
//  Created by appsbeetech on 23/11/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "ViewOtherTagsController.h"
#import "LivingTagsCell.h"

@interface ViewOtherTagsController ()<UITableViewDelegate,UITableViewDataSource>
{
    IBOutlet UITableView *tblOtherTags;
}

@end

@implementation ViewOtherTagsController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
    if (___isIphone4_4s)
    {
        return 90.0f;
    }
    return 100.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LivingTagsCell *cell=[tableView dequeueReusableCellWithIdentifier:@"str"];
    if (!cell)
    {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"LivingTagsCell" owner:self options:nil]objectAtIndex:0];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor clearColor];
    return cell;
}


@end
