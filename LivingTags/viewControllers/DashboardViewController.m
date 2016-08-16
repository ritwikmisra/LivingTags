//
//  DashboardViewController.m
//  LivingTags
//
//  Created by appsbeetech on 09/08/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "DashboardViewController.h"
#import "ProfileGetService.h"
#import "DashboardCell.h"
#import "SlideMenuController.h"

@interface DashboardViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView *tblDashboard;
    NSMutableArray *arrPics;
}

@end

@implementation DashboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //arrPics=[[NSMutableArray alloc]initWithObjects:@"create_tag_dashbord",@"my_tag_dashbord",@"read_tag_dashbord",nil];
    arrPics=[[NSMutableArray alloc]initWithObjects:@"read_tag_dashbord",@"create_tag_dashbord",@"my_tag_dashbord",nil];
    tblDashboard.backgroundColor=[UIColor clearColor];
    tblDashboard.separatorStyle=UITableViewCellSeparatorStyleNone;
    tblDashboard.bounces=NO;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (appDel.isGoToDashBoardFromQRbtnTapped) {
        appDel.isGoToDashBoardFromQRbtnTapped = NO;
        appDel.isCreateTagTappedFromDashboard = NO;
        appDel.isMyTagTappedFromDashboard = NO;
        appDel.isReadTagTappedFromDashboard = NO;
    }
    
    
    [[ProfileGetService service]callProfileEditServiceWithUserID:appDel.objUser.strUserID withCompletionHandler:^(id  _Nullable result, BOOL isError, NSString * _Nullable strMsg) {
        if (isError)
        {
            [self displayErrorWithMessage:strMsg];
        }
        else
        {
            NSLog(@"%@",result);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark
#pragma mark tableview datasource and delegate
#pragma mark

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (___isIphone6Plus)
    {
        return 180.0f;
    }
    if (___isIphone6)
    {
        return 180.0f;
    }
    if (___isIphone5_5s)
    {
        return 150.0f;
    }
    return 130.0f;
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
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==1)
    {
        appDel.isCreateTagTappedFromDashboard = YES;
        appDel.isMyTagTappedFromDashboard = NO;
        appDel.isReadTagTappedFromDashboard = NO;
        [self performSegueWithIdentifier:@"segueDashboardToTemplate" sender:self];
    }
    if (indexPath.row==2)
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
    }
}
@end
