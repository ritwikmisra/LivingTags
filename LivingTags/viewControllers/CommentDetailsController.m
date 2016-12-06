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
#import "ModelAssetDetails.h"
#import "UIImageView+WebCache.h"
#import "DeleteCommentService.h"


@interface CommentDetailsController ()<UITableViewDelegate,UITableViewDataSource>
{
    IBOutlet UIImageView *imgComment;
    IBOutlet UIButton *btnDelete;
    IBOutlet UIButton *btnPublish;
    IBOutlet UILabel *lblSize;
    IBOutlet UITableView *tblCommentDetails;
    NSMutableArray *arrResponse;
    ModelCommentDetails *obj;
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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    arrResponse=[[NSMutableArray alloc]init];
    [[CommentDetailsService service]callCommentDetailsServiceWithAKey:appDel.objUser.strAkey tcKey:self.objService.strTCKey withCompletionHandler:^(id  _Nullable result, BOOL isError, NSString * _Nullable strMsg) {
        if (isError)
        {
            [self displayErrorWithMessage:strMsg];
        }
        else
        {
            NSLog(@"%@",result);
            obj=[[ModelCommentDetails alloc]initWithDictionary:result];
            dispatch_async(dispatch_get_main_queue(), ^{
                [imgComment sd_setImageWithURL:[NSURL URLWithString:obj.strTCommenterPhoto]
                                   placeholderImage:[UIImage imageNamed:@"defltmale_user_icon"]
                                            options:SDWebImageHighPriority
                                           progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                           }
                                          completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                              
                                          }];
            });
            
            NSString *strSize=[self transformedValue:obj.strSize];
            lblSize.text=[NSString stringWithFormat:@"DATA USED : %@",strSize];
            if ([obj.strTPublished isEqualToString:@"Y"])
            {
                btnPublish.hidden=YES;
            }
            else
            {
                btnPublish.hidden=NO;
            }
            NSLog(@"%@",obj.strTCommenter);
            [arrResponse addObject:obj.strTCommenter];
            NSLog(@"%@",obj.arrCommentAsset);
            for (int i=0; i<obj.arrCommentAsset.count; i++)
            {
                NSDictionary *dict=[obj.arrCommentAsset objectAtIndex:i];
                ModelAssetDetails *objAssets=[[ModelAssetDetails alloc]initwithDictionary:dict];
                NSLog(@"%@",objAssets.strTCKey);
                [arrResponse addObject:objAssets];
            }
            NSLog(@"%@",arrResponse);
            [tblCommentDetails reloadData];
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
    return arrResponse.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=nil;
    if (indexPath.row==0)
    {
        NSString *strComment=[arrResponse objectAtIndex:0];
        CommentDetailsCell *cell1=[tblCommentDetails dequeueReusableCellWithIdentifier:@"identifier"];
        if (!cell1)
        {
            cell1=[[[NSBundle mainBundle]loadNibNamed:@"CommentDetailsCell" owner:self options:nil] objectAtIndex:0];
        }
        cell1.txtVwComments.text=strComment;
        cell=cell1;
    }
    else
    {
        CommentDetailsCell *cell2=[tblCommentDetails dequeueReusableCellWithIdentifier:@"identifier"];
        if (!cell2)
        {
            cell2=[[[NSBundle mainBundle]loadNibNamed:@"CommentDetailsCell" owner:self options:nil] objectAtIndex:1];
        }
        ModelAssetDetails *objAssets=[arrResponse objectAtIndex:indexPath.row];
        if (objAssets.strAssetsThumb.length>0)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [cell2.imgAssets sd_setImageWithURL:[NSURL URLWithString:objAssets.strAssetsThumb]
                                             placeholderImage:[UIImage imageNamed:@"defltmale_user_icon"]
                                                      options:SDWebImageHighPriority
                                                     progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                                         [cell2.actIndicator startAnimating];
                                                     }
                                                    completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                                        [cell2.actIndicator stopAnimating];
                                                        
                                                    }];
            });
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [cell2.imgAssets sd_setImageWithURL:[NSURL URLWithString:objAssets.strAssets]
                                   placeholderImage:[UIImage imageNamed:@"defltmale_user_icon"]
                                            options:SDWebImageHighPriority
                                           progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                               [cell2.actIndicator startAnimating];
                                           }
                                          completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                              [cell2.actIndicator stopAnimating];
                                              
                                          }];
            });
        }
        if ([obj.strTPublished isEqualToString:@"Y"])
        {
            cell2.btnTick.hidden=YES;
        }
        cell=cell2;
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor whiteColor];
    return cell;
}

#pragma mark
#pragma mark IBACTIONS
#pragma mark

-(IBAction)btnPublishPressed:(id)sender
{
    
}

-(IBAction)btnDeletePressed:(id)sender
{
    [[DeleteCommentService service]callDeleteServiceWithAKey:appDel.objUser.strAkey tcKey:obj.strTCKey withCompletionHandler:^(id  _Nullable result, BOOL isError, NSString * _Nullable strMsg) {
        if (isError)
        {
            [self displayErrorWithMessage:strMsg];
        }
        else
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

-(void)btnTickPressed:(id)sender
{
    
}
@end
