//
//  MyTagsListingController.m
//  LivingTags
//
//  Created by appsbeetech on 05/11/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "MyTagsListingController.h"
#import "MyTagsListingCell.h"
#import "MyTagListService.h"
#import "ModelEditTagsListing.h"
#import "MyTagsEditModeController.h"

@interface MyTagsListingController ()<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView *tblListing;
    NSMutableArray *arrResponse;
    NSString *strTkey;
}

@end

@implementation MyTagsListingController

- (void)viewDidLoad {
    [super viewDidLoad];
    tblListing.separatorStyle=UITableViewCellSeparatorStyleNone;
    tblListing.backgroundColor=[UIColor clearColor];
    NSLog(@"%@",self.strTagName);
    arrResponse=[[NSMutableArray alloc]init];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[MyTagListService service]callListServiceWithakey:appDel.objUser.strKey tcKey:self.strTCKey withCompletionHandler:^(id  _Nullable result, BOOL isError, NSString * _Nullable strMsg) {
        if (isError)
        {
            [self displayErrorWithMessage:strMsg];
        }
        else
        {
            NSLog(@"%@",result);
            arrResponse=(id)result;
            [tblListing reloadData];
        }
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark
#pragma mark tableview datasource and delegates
#pragma mark

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (arrResponse.count>0)
    {
        return arrResponse.count;
    }
    return 0;
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
    MyTagsListingCell *cell=[tableView dequeueReusableCellWithIdentifier:@"identifier"];
    if (!cell)
    {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"MyTagsListingCell" owner:self options:nil]objectAtIndex:0];
    }
    ModelEditTagsListing *obj=[arrResponse objectAtIndex:indexPath.row];
    cell.backgroundColor=[UIColor whiteColor];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.imgPerson.layer.cornerRadius=self.view.frame.size.width/11;
    cell.imgPerson.clipsToBounds=YES;
    cell.btnEdit.tag=indexPath.row;
    cell.lblName.text=obj.strTname;
    cell.lblTiming.text=obj.strPosted_time;
    cell.lblTagViews.text=obj.strTotal_views;
    cell.lblTagType.text=self.strTagName;
    cell.lblTagComments.text=obj.strTotal_comments;
    [cell.btnEdit addTarget:self action:@selector(btnEditPressed:) forControlEvents:UIControlEventTouchUpInside];
    if (indexPath.row==5)
    {
        cell.imgBottom.hidden=YES;
    }
    return cell;
}

#pragma mark
#pragma mark IBACTIONS
#pragma mark

-(void)btnEditPressed:(id)sender
{
    //segueMyTagsEdit
    ModelEditTagsListing *obj=[arrResponse objectAtIndex:[sender tag]];
    strTkey=obj.strtkey;
    [self performSegueWithIdentifier:@"segueMyTagsEdit" sender:self];
}


#pragma mark
#pragma mark PREPARE FOR SEGUE
#pragma  mark

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"segueMyTagsEdit"])
    {
        MyTagsEditModeController *master=[segue destinationViewController];
        master.strTagName=self.strTagName;
        master.strTKey=strTkey;
        NSLog(@"%@ %@",self.strTagName,master.strTagName);
    }
}


@end
