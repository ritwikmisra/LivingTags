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
    arrLabel=[[NSMutableArray alloc]initWithObjects:@"Persons",@"Place",@"Thing",@"Pet",@"Business", @"Others",nil];
    arrPics=[[NSMutableArray alloc]initWithObjects:@"person_icon",@"place_icon",@"thing_icon",@"pet_icon",@"business_icon",@"other_icon", nil];
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
        return 200.0f;
    }
    if (___isIphone6)
    {
        return 170.0f;
    }
    if (___isIphone5_5s)
    {
        return 150.0f;
    }
    return 135.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DashboardCell *cell=[tableView dequeueReusableCellWithIdentifier:@"identifiew"];
    if (!cell)
    {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"DashboardCell" owner:self options:nil] objectAtIndex:1];
    }
    cell.btnLeft.tag=indexPath.row*2;
    cell.btnRIght.tag=indexPath.row*2+1;
    NSLog(@"Left button tag=%d.....right button tag=%d",cell.btnLeft.tag,cell.btnRIght.tag);
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.lblLeft.text=[arrLabel objectAtIndex:cell.btnLeft.tag];
    cell.lblRight.text=[arrLabel objectAtIndex:cell.btnRIght.tag];
    cell.imgIconleft.image=[UIImage imageNamed:[arrPics objectAtIndex:cell.btnLeft.tag]];
    cell.imgIconRight.image=[UIImage imageNamed:[arrPics objectAtIndex:cell.btnRIght.tag]];
    cell.backgroundColor=[UIColor clearColor];
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
