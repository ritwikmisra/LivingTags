//
//  CommentDetailsController.m
//  LivingTags
//
//  Created by appsbeetech on 01/12/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "CommentDetailsController.h"
#import "CommentDetailsCell.h"

@interface CommentDetailsController ()<UITableViewDelegate,UITableViewDataSource>
{
    IBOutlet UIImageView *imgComment;
    IBOutlet UIButton *btnDelete;
    IBOutlet UIButton *btnPublish;
    IBOutlet UILabel *lblSize;
    IBOutlet UITableView *tblCommentDetails;
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
    return 2;
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
        cell=cell1;
    }
    else
    {
        CommentDetailsCell *cell2=[tblCommentDetails dequeueReusableCellWithIdentifier:@"identifier"];
        if (!cell2)
        {
            cell2=[[[NSBundle mainBundle]loadNibNamed:@"CommentDetailsCell" owner:self options:nil] objectAtIndex:1];
        }
        cell=cell2;
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor clearColor];
    return cell;
}
@end
