//
//  CommentListController.m
//  LivingTags
//
//  Created by appsbeetech on 29/11/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "CommentListController.h"
#import "DashboardSizeCell.h"
#import "ModelCommentDetails.h"
#import "CommentListingService.h"
#import "UIImageView+WebCache.h"
#import "CommentDetailsController.h"


@interface CommentListController ()<UITableViewDelegate,UITableViewDataSource>
{
    IBOutlet UIButton *btnPublish;
    IBOutlet UIButton *btnUnpublish;
    BOOL isPublish;
    NSMutableArray *arrResponse;
    IBOutlet UITableView *tblComments;
    ModelCommentDetails *objSegue;
}

@end

@implementation CommentListController

- (void)viewDidLoad {
    [super viewDidLoad];
    tblComments.separatorStyle=UITableViewCellSeparatorStyleNone;
    tblComments.backgroundColor=[UIColor clearColor];
    isPublish=YES;
    [btnPublish setBackgroundColor:[UIColor whiteColor]];
    [btnPublish setTitleColor:[UIColor colorWithRed:36/255.0f green:93/255.0f blue:149/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [btnUnpublish setBackgroundColor:[UIColor colorWithRed:36/255.0f green:93/255.0f blue:149/255.0f alpha:1.0f]];
    [btnUnpublish setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self callWebService];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark
#pragma mark IBACTIONS
#pragma mark

-(IBAction)btnPublishPressed:(id)sender
{
    isPublish=YES;
    [btnPublish setBackgroundColor:[UIColor whiteColor]];
    [btnPublish setTitleColor:[UIColor colorWithRed:36/255.0f green:93/255.0f blue:149/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [btnUnpublish setBackgroundColor:[UIColor colorWithRed:36/255.0f green:93/255.0f blue:149/255.0f alpha:1.0f]];
    [btnUnpublish setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self callWebService];

}

-(IBAction)btnUnpublishPressed:(id)sender
{
    isPublish=NO;
    [btnUnpublish setBackgroundColor:[UIColor whiteColor]];
    [btnUnpublish setTitleColor:[UIColor colorWithRed:36/255.0f green:93/255.0f blue:149/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [btnPublish setBackgroundColor:[UIColor colorWithRed:36/255.0f green:93/255.0f blue:149/255.0f alpha:1.0f]];
    [btnPublish setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self callWebService];
}

#pragma mark
#pragma mark WEBSERVICE
#pragma mark

-(void)callWebService
{
    NSLog(@"%d",isPublish);
    if (isPublish)
    {
        [[CommentListingService service] callChatListingServiceWithAKey:appDel.objUser.strAkey page:0 published:@"Y" withCompletionHandler:^(id  _Nullable result, BOOL isError, NSString * _Nullable strMsg) {
            if (isError)
            {
                [self displayErrorWithMessage:strMsg];
            }
            else
            {
                arrResponse=(id)result;
            }
            [tblComments reloadData];
        }];
    }
    else
    {
        [[CommentListingService service] callChatListingServiceWithAKey:appDel.objUser.strAkey page:0 published:@"N" withCompletionHandler:^(id  _Nullable result, BOOL isError, NSString * _Nullable strMsg) {
            if (isError)
            {
                [self displayErrorWithMessage:strMsg];
                [arrResponse removeAllObjects];
            }
            else
            {
                arrResponse=(id)result;
            }
            [tblComments reloadData];
        }];

    }
}

#pragma mark
#pragma mark tableview datasource and delegate
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
    if (___isIphone6Plus)
    {
        return 100.0f;
    }
    return 80.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ModelCommentDetails *obj=[arrResponse objectAtIndex:indexPath.row];
    DashboardSizeCell *cell=[tableView dequeueReusableCellWithIdentifier:@"identifier"];
    if (!cell)
    {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"DashboardSizeCell" owner:self options:nil]objectAtIndex:0];
    }
    cell.imgPic.layer.cornerRadius=self.view.frame.size.width/12;
    cell.imgPic.clipsToBounds=YES;
    dispatch_async(dispatch_get_main_queue(), ^{
        [cell.imgPic sd_setImageWithURL:[NSURL URLWithString:obj.strTCommenterPhoto]
                                     placeholderImage:[UIImage imageNamed:@"defltmale_user_icon"]
                                              options:SDWebImageHighPriority
                                             progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                             }
                                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                                
                                            }];
    });
    cell.lblComment.text=[NSString stringWithFormat:@"%@ :%@",obj.strTCommenterName,obj.strTCommenter];
     cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.lblViewed.text=obj.strTCommentTime;
    NSString *strSpace=[self transformedValue:obj.strSize];
    cell.lblAttachment.text=[NSString stringWithFormat:@"%d attachments",obj.arrCommentAsset.count];
    cell.lblSize.text=strSpace;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //segueCommentDetails
    objSegue=[arrResponse objectAtIndex:indexPath.row];
    NSLog(@"%@",objSegue.strTCKey);
    [self performSegueWithIdentifier:@"segueCommentDetails" sender:self];
}

#pragma mark
#pragma mark prepare for segue
#pragma mark

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"segueCommentDetails"])
    {
        CommentDetailsController *master=[segue destinationViewController];
        master.objService=objSegue;
    }
}

@end
