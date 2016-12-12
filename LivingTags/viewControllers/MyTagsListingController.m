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
#import "UIImageView+WebCache.h"
#import "DeleteTagService.h"


@interface MyTagsListingController ()<UITableViewDataSource,UITableViewDelegate,DeleteTagsProtocol>
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
    /*MyTagsListingCell *cell=[tableView dequeueReusableCellWithIdentifier:@"identifier"];
    if (!cell)
    {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"MyTagsListingCell" owner:self options:nil]objectAtIndex:0];
    }
    ModelEditTagsListing *obj=[arrResponse objectAtIndex:indexPath.row];
    NSLog(@"%@",obj.strTLink);
    cell.backgroundColor=[UIColor whiteColor];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.imgPerson.layer.cornerRadius=self.view.frame.size.width/11;
    cell.imgPerson.clipsToBounds=YES;
    cell.btnEdit.tag=indexPath.row;
    cell.btnPreviewOnImage.tag=indexPath.row;
    cell.btnPreviewOnName.tag=indexPath.row;
    cell.lblName.text=obj.strTname;
    cell.lblTiming.text=obj.strPosted_time;
    cell.lblTagViews.text=obj.strTotal_views;
    cell.lblTagType.text=self.strTagName;
    cell.lblTagComments.text=obj.strTotal_comments;
    [cell.btnEdit addTarget:self action:@selector(btnEditPressed:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnPreviewOnName addTarget:self action:@selector(btnLivingTagsPreviewPressed:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnPreviewOnImage addTarget:self action:@selector(btnLivingTagsPreviewPressed:) forControlEvents:UIControlEventTouchUpInside];
    dispatch_async(dispatch_get_main_queue(), ^{
        [cell.imgPerson sd_setImageWithURL:[NSURL URLWithString:obj.strtphoto]
                          placeholderImage:[UIImage imageNamed:@"defltmale_user_icon"]
                                   options:SDWebImageHighPriority
                                  progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                      [cell.actMyTags startAnimating];
                                  }
                                 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                     [cell.actMyTags stopAnimating];
                                 }];
    });
    if (indexPath.row==5)
    {
        cell.imgBottom.hidden=YES;
    }
    return cell;*/
    MyTagsListingCell *cell=[tableView dequeueReusableCellWithIdentifier:@"identifier"];
     if (!cell)
     {
         cell=[[[NSBundle mainBundle]loadNibNamed:@"MyTagsListingCell" owner:self options:nil]objectAtIndex:2];
     }
    ModelEditTagsListing *obj=[arrResponse objectAtIndex:indexPath.row];
    NSLog(@"%@",obj.strTLink);
    cell.backgroundColor=[UIColor whiteColor];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.imgPerson.layer.cornerRadius=self.view.frame.size.width/11;
    cell.imgPerson.clipsToBounds=YES;
    cell.btnEdit.tag=indexPath.row;
    cell.btnPreviewOnImage.tag=indexPath.row;
    cell.btnPreviewOnName.tag=indexPath.row;
    cell.lblName.text=obj.strTname;
    cell.lblTiming.text=obj.strPosted_time;
    cell.lblTagViews.text=obj.strTotal_views;
    cell.lblTagType.text=self.strTagName;
    cell.delegate=self;
    cell.lblTagComments.text=obj.strTotal_comments;
    [cell.btnEdit addTarget:self action:@selector(btnEditPressed:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnPreviewOnName addTarget:self action:@selector(btnLivingTagsPreviewPressed:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnPreviewOnImage addTarget:self action:@selector(btnLivingTagsPreviewPressed:) forControlEvents:UIControlEventTouchUpInside];
    dispatch_async(dispatch_get_main_queue(), ^{
        [cell.imgPerson sd_setImageWithURL:[NSURL URLWithString:obj.strtphoto]
                          placeholderImage:[UIImage imageNamed:@"defltmale_user_icon"]
                                   options:SDWebImageHighPriority
                                  progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                      [cell.actMyTags startAnimating];
                                  }
                                 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                     [cell.actMyTags stopAnimating];
                                 }];
    });
    if (indexPath.row==5)
    {
        cell.imgBottom.hidden=YES;
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   ModelEditTagsListing *obj=[arrResponse objectAtIndex:indexPath.row];
    strTkey=obj.strtkey;
    [self performSegueWithIdentifier:@"segueMyTagsEdit" sender:self];
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

-(void)btnLivingTagsPreviewPressed:(id)sender
{
    ModelEditTagsListing *obj=[arrResponse objectAtIndex:[sender tag]];
    NSLog(@"%@",obj.strTLink);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:obj.strTLink]];
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

#pragma mark
#pragma mark delete tags functionality
#pragma mark

-(void)deleteTags:(id)sender
{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:tblListing];
    NSIndexPath *indexPath = [tblListing indexPathForRowAtPoint:buttonPosition];
    NSLog(@"%d",indexPath.row);
    ModelEditTagsListing *obj=[arrResponse objectAtIndex:indexPath.row];

    [[DeleteTagService service]deleteTagWithTKey:obj.strtkey aKey:appDel.objUser.strAkey withCompletionHandler:^(id  _Nullable result, BOOL isError, NSString * _Nullable strMsg) {
        if (isError)
        {
            [self displayErrorWithMessage:strMsg];
        }
        else
        {
            [arrResponse removeObjectAtIndex:indexPath.row];
            [tblListing reloadData];
        }
    }];
}

@end
