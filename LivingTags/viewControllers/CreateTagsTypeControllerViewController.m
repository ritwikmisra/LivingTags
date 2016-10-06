//
//  CreateTagsTypeControllerViewController.m
//  LivingTags
//
//  Created by appsbeetech on 06/10/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "CreateTagsTypeControllerViewController.h"
#import "DashboardCell.h"


@interface CreateTagsTypeControllerViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    IBOutlet UITableView *tblTypes;
    NSMutableArray *arrPics,*arrLabel;

}

@end

@implementation CreateTagsTypeControllerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    arrLabel=[[NSMutableArray alloc]initWithObjects:@"Memorial tags",@"Other tags", nil];
    arrPics=[[NSMutableArray alloc]initWithObjects:@"memorial_tag",@"other_tag", nil];
    tblTypes.backgroundColor=[UIColor clearColor];
    tblTypes.separatorStyle=UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    tblTypes.separatorStyle=UITableViewCellSeparatorStyleNone;
}


#pragma mark
#pragma mark tableview delegates and datasource methods
#pragma mark 

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (___isIphone6Plus)
    {
        return 150.0f;
    }
    if (___isIphone6)
    {
        return 150.0f;
    }
    if (___isIphone5_5s)
    {
        return 135.0f;
    }
    return 95.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrPics.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DashboardCell *cell=[tableView dequeueReusableCellWithIdentifier:@"identifiew"];
    if (!cell)
    {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"DashboardCell" owner:self options:nil] objectAtIndex:0];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor clearColor];
    cell.imgDashboard.image=[UIImage imageNamed:[arrPics objectAtIndex:indexPath.row]];
    cell.lblName.text=[arrLabel objectAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==1)
    {
        //        appDel.isCreateTagTappedFromDashboard = YES;
        //        appDel.isMyTagTappedFromDashboard = NO;
        //        appDel.isReadTagTappedFromDashboard = NO;
    }
    /*if (indexPath.row==2)
     {
     appDel.isMyTagTappedFromDashboard = YES;
     appDel.isCreateTagTappedFromDashboard = NO;
     appDel.isReadTagTappedFromDashboard = NO;
     [self performSegueWithIdentifier:@"segueDashboardToMyTags" sender:self];
     }
     if (indexPath.row==0)
     {
     appDel.isReadTagTappedFromDashboard = YES;
     appDel.isMyTagTappedFromDashboard = NO;
     appDel.isCreateTagTappedFromDashboard = NO;
     [self performSegueWithIdentifier:@"segueDashBoardToReadTags" sender:self];
     }*/
}



@end
