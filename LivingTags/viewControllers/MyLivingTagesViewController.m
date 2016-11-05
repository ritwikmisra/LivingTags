//
//  MyLivingTagesViewController.m
//  LivingTags
//
//  Created by appsbeetech on 06/05/16.
//  Copyright © 2016 appsbeetech. All rights reserved.


#import "MyLivingTagesViewController.h"
#import "DashboardCell.h"
#import "LivingTagsSecondStepViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "MyTagsListingController.h"

@interface MyLivingTagesViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    IBOutlet UITableView *tblMyTagsCategory;
    NSMutableArray *arrPics,*arrLabel,*arrSelected;
    NSString *strTags;

}
@end

@implementation MyLivingTagesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    arrLabel=[[NSMutableArray alloc]initWithObjects:@"Persons",@"Place",@"Thing",@"Pet",@"Business", @"Others",nil];
    arrPics=[[NSMutableArray alloc]initWithObjects:@"person_icon",@"place_icon",@"thing_icon",@"pet_icon",@"business_icon",@"other_icon", nil];
    tblMyTagsCategory.separatorStyle=UITableViewCellSeparatorStyleNone;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    arrSelected=[[NSMutableArray alloc]initWithObjects:@"0",@"0",@"0",@"0",@"0",@"0", nil];
    tblMyTagsCategory.delegate=self;
    tblMyTagsCategory.dataSource=self;

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark
#pragma mark tableview delegates and datasource
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
        cell=[[[NSBundle mainBundle]loadNibNamed:@"DashboardCell" owner:self options:nil] objectAtIndex:2];
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
    
    cell.lblBatchCountRight.layer.cornerRadius=self.view.frame.size.height/65;
    cell.lblBatchCountRight.layer.masksToBounds=YES;
    
    cell.lbBatchCountLeft.layer.cornerRadius=self.view.frame.size.height/65;
    cell.lbBatchCountLeft.layer.masksToBounds=YES;

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
    strTags=[arrLabel objectAtIndex:[sender tag]];
    if ([arrSelected containsObject:@"1"])
    {
        int index=[arrSelected indexOfObject:@"1"];
        [arrSelected replaceObjectAtIndex:index withObject:@"0"];
    }
    [arrSelected replaceObjectAtIndex:[sender tag] withObject:@"1"];
    [tblMyTagsCategory reloadData];
    [self performSelector:@selector(moveToTagCreation) withObject:nil afterDelay:0.3];
}

-(void)btnRightPressed:(id)sender
{
    strTags=[arrLabel objectAtIndex:[sender tag]];
    if ([arrSelected containsObject:@"1"])
    {
        int index=[arrSelected indexOfObject:@"1"];
        [arrSelected replaceObjectAtIndex:index withObject:@"0"];
    }
    [arrSelected replaceObjectAtIndex:[sender tag] withObject:@"1"];
    [tblMyTagsCategory reloadData];
    //[self performSegueWithIdentifier:@"segueTagCreation" sender:self];
    [self performSelector:@selector(moveToTagCreation) withObject:nil afterDelay:0.3];
}

#pragma mark
#pragma mark WEB SERVICE CALLED
#pragma mark

-(void)moveToTagCreation
{
    [self performSegueWithIdentifier:@"segueMyTagsListing" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"segueMyTagsListing"])
    {
        MyTagsListingController *master=[segue destinationViewController];
        master.strTagName=strTags;
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [arrSelected removeAllObjects];
    arrSelected=nil;
    tblMyTagsCategory.delegate=nil;
    tblMyTagsCategory.dataSource=nil;
}


 @end
