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
    NSMutableArray *arrPics,*arrLabel,*arrSelected;
}

@end

@implementation CreateTagsTypeControllerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    arrLabel=[[NSMutableArray alloc]initWithObjects:@"Persons",@"Place",@"Thing",@"Pet",@"Business", @"Others",nil];
    arrPics=[[NSMutableArray alloc]initWithObjects:@"person_icon",@"place_icon",@"thing_icon",@"pet_icon",@"business_icon",@"other_icon", nil];
    arrSelected=[[NSMutableArray alloc]initWithObjects:@"0",@"0",@"0",@"0",@"0",@"0", nil];
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
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.lblLeft.text=[arrLabel objectAtIndex:cell.btnLeft.tag];
    cell.lblRight.text=[arrLabel objectAtIndex:cell.btnRIght.tag];
    cell.imgIconleft.image=[UIImage imageNamed:[arrPics objectAtIndex:cell.btnLeft.tag]];
    cell.imgIconRight.image=[UIImage imageNamed:[arrPics objectAtIndex:cell.btnRIght.tag]];
    cell.backgroundColor=[UIColor clearColor];
    [cell.btnRIght addTarget:self action:@selector(btnRightPressed:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnLeft addTarget:self action:@selector(btnLeftPressed:) forControlEvents:UIControlEventTouchUpInside];
    if ([[arrSelected objectAtIndex:cell.btnLeft.tag]isEqualToString:@"1"])
    {
        cell.imgBackgroundLeft.image=[UIImage imageNamed:@"bg_btn_hover"];
    }
    else if ([[arrSelected objectAtIndex:cell.btnRIght.tag]isEqualToString:@"1"])
    {
        cell.imgBackgroundRight.image=[UIImage imageNamed:@"bg_btn_hover"];

    }
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

#pragma mark
#pragma mark IBACTIONS
#pragma mark

-(void)btnLeftPressed:(id)sender
{
    if ([arrSelected containsObject:@"1"])
    {
        int index=[arrSelected indexOfObject:@"1"];
        [arrSelected replaceObjectAtIndex:index withObject:@"0"];
    }
    [arrSelected replaceObjectAtIndex:[sender tag] withObject:@"1"];
    [tblTypes reloadData];
}

-(void)btnRightPressed:(id)sender
{
    if ([arrSelected containsObject:@"1"])
    {
        int index=[arrSelected indexOfObject:@"1"];
        [arrSelected replaceObjectAtIndex:index withObject:@"0"];
    }
    [arrSelected replaceObjectAtIndex:[sender tag] withObject:@"1"];
    [tblTypes reloadData];
}
@end
