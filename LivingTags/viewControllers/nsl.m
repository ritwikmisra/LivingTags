//
//  CommentDetailsController.m
//  LivingTags
//
//  Created by appsbeetech on 01/12/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "CommentDetailsController.h"
#import "CommentDetailsCell.h"
#import "CommentDetailsService.h"

@interface CommentDetailsController ()<UITableViewDelegate,UITableViewDataSource>
{
    IBOutlet UIImageView *imgComment;
    IBOutlet UIButton *btnDelete;
    IBOutlet UIButton *btnPublish;
    IBOutlet UILabel *lblSize;
    IBOutlet UITableView *tblCommentDetails;
    NSMutableArray *arrTickStatus;
}

@end

@implementation CommentDetailsController

- (void)viewDidLoad
{
    [super viewDidLoad];
    btnDelete.layer.cornerRadius=9.0f;
    btnPublish.layer.cornerRadius=9.0f;
    if (___isIphone5_5s)
    {
        [lblSize setFont:[UIFont systemFontOfSize:10.0f]];
    }
    tblCommentDetails.separatorStyle=UITableViewCellSeparatorStyleNone;
    tblCommentDetails.backgroundColor=[UIColor clearColor];
    arrTickStatus=[[NSMutableArray alloc]init];
    for (int i=0; i<10; i++)
    {
        [arrTickStatus addObject:@"0"];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"%@",self.objService.strTCKey);
    [[CommentDetailsService service]callCommentDetailsServiceWithAKey:appDel.objUser.strAkey tcKey:self.objService.strTCKey withCompletionHandler:^(id  _Nullable result, BOOL isError, NSString * _Nullable strMsg) {
        if (isError)
        {
            [self displayErrorWithMessage:strMsg];
        }
        else
        {
            
        }
    }];

}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    imgComment.layer.cornerRadius=imgComment.frame.size.width/2;
    imgComment.clipsToBounds=YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=nil;
    if (indexPath.row%2==0)
    {
        CommentDetailsCell *cell1=[tblCommentDetails dequeueReusableCellWithIdentifier:@"identifier"];
        if (!cell1)
        {
            cell1=[[[NSBundle mainBundle]loadNibNamed:@"CommentDetailsCell" owner:self options:nil] objectAtIndex:0];
        }
        cell1.btnTick.tag=indexPath.row;
        if ([[arrTickStatus objectAtIndex:indexPath.row] isEqualToString:@"0"])
        {
            [cell1.btnTick setBackgroundImage:[UIImage imageNamed:@"living_button_off"] forState:UIControlStateNormal];
        }
        else
        {
            [cell1.btnTick setBackgroundImage:[UIImage imageNamed:@"living_button"] forState:UIControlStateNormal];
        }
        [cell1.btnTick addTarget:self action:@selector(btnTickClicked:) forControlEvents:UIControlEventTouchUpInside];
        cell=cell1;
    }
    else
    {
        CommentDetailsCell *cell2=[tblCommentDetails dequeueReusableCellWithIdentifier:@"identifier"];
        if (!cell2)
        {
            cell2=[[[NSBundle mainBundle]loadNibNamed:@"CommentDetailsCell" owner:self options:nil] objectAtIndex:1];
        }
        cell2.btnTick.tag=indexPath.row;
        if ([[arrTickStatus objectAtIndex:indexPath.row] isEqualToString:@"0"])
        {
            [cell2.btnTick setBackgroundImage:[UIImage imageNamed:@"living_button_off"] forState:UIControlStateNormal];
        }
        else
        {
            [cell2.btnTick setBackgroundImage:[UIImage imageNamed:@"living_button"] forState:UIControlStateNormal];
        }
        [cell2.btnTick addTarget:self action:@selector(btnTickClicked:) forControlEvents:UIControlEventTouchUpInside];
        cell=cell2;
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor whiteColor];
    return cell;
}

#pragma mark
#pragma mark IBACTION
#pragma mark

-(void)btnTickClicked:(id)sender
{
    UIButton *btn=(id)sender;
    if ([[arrTickStatus objectAtIndex:[sender tag]]isEqualToString:@"1"])
    {
        [arrTickStatus replaceObjectAtIndex:[sender tag] withObject:@"0"];
    }
    else
    {
        [arrTickStatus replaceObjectAtIndex:[sender tag] withObject:@"1"];
    }
    [tblCommentDetails beginUpdates];
    NSArray *paths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:[sender tag] inSection:0]];
    [tblCommentDetails reloadRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationFade];
    [tblCommentDetails endUpdates];
}
@end
