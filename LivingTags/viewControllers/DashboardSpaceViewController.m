//
//  DashboardSpaceViewController.m
//  LivingTags
//
//  Created by appsbeetech on 10/11/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "DashboardSpaceViewController.h"
#import "DashboardSizeCell.h"
#import "MyTagsListingCell.h"
#import "ModelEditTagsListing.h"
#import "MyTagsEditModeController.h"
#import "DashboardMyTagsListingService.h"
#import "ProfileGetService.h"
#import "UIImageView+WebCache.h"
#import "CommentListingService.h"
#import "ModelCommentDetails.h"

@interface DashboardSpaceViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
    IBOutlet UITableView *tblComments;
    IBOutlet UIView *vwColour;
    IBOutlet UIButton *btnRecentComments;
    IBOutlet UIButton *btnMyTags;
    IBOutlet UIImageView *imgRecentComments;
    IBOutlet UIImageView *imgMyTags;
    IBOutlet UILabel *lblRecentComments;
    IBOutlet UILabel *lblMyTags;
    BOOL isRecentComments;
    NSMutableArray *arrResponse,*arrLabel,*arrComments;
    NSString *strTkey,*strSegueKey;
    IBOutlet UILabel *lblTotalSpace;
    IBOutlet UILabel *lblFreeSpace;
    IBOutlet UILabel *lblTags;
    IBOutlet UILabel *lblPercentage;
    int i;
    BOOL isScrollDown;
    BOOL isLazyLoading;
}

@end

@implementation DashboardSpaceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    tblComments.separatorStyle=UITableViewCellSeparatorStyleNone;
    isRecentComments=YES;
    
    [imgRecentComments setImage:[UIImage imageNamed:@"comment_active"]];
    [lblRecentComments setTextColor:[UIColor colorWithRed:36/255.0f green:93/255.0f blue:149/255.0f alpha:1.0]];
    [btnRecentComments setBackgroundColor:[UIColor clearColor]];
    
    [imgMyTags setImage:[UIImage imageNamed:@"tags_inactive"]];
    [lblMyTags setTextColor:[UIColor whiteColor]];
    [btnMyTags setBackgroundColor:[UIColor colorWithRed:36/255.0f green:93/255.0f blue:149/255.0f alpha:1.0]];
    arrResponse=[[NSMutableArray alloc]init];
    arrLabel=[[NSMutableArray alloc]initWithObjects:@"Person",@"Business",@"Pet",@"Place",@"Thing", @"Other",nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    i=0;
    isLazyLoading=YES;
    vwColour.layer.cornerRadius=vwColour.frame.size.height/2;
    [[ProfileGetService service]callProfileEditServiceWithUserID:appDel.objUser.strKey withCompletionHandler:^(id  _Nullable result, BOOL isError, NSString * _Nullable strMsg) {
        if (isError)
        {
            [self displayErrorWithMessage:strMsg];
        }
        else
        {
            float percentage=(([appDel.objUser.strTotalStorage floatValue]-[appDel.objUser.strStorageUsed floatValue])/[appDel.objUser.strTotalStorage floatValue])*100;
            NSLog(@"%2f",percentage);
            lblPercentage.text=[NSString stringWithFormat:@"%.02f %%",percentage];
            lblTags.text=[NSString stringWithFormat:@"Total no of tags : %@",appDel.objUser.strTagCounts];
            NSString *strTotalSpace=[self transformedValue:appDel.objUser.strTotalStorage];
            NSLog(@"%@",strTotalSpace);
            lblTotalSpace.text=[NSString stringWithFormat:@"Total space : %@",strTotalSpace];
            NSString *strSpaceUtilized=[self transformedValue:appDel.objUser.strStorageUsed];
            lblFreeSpace.text=[NSString stringWithFormat:@"Space used : %@",strSpaceUtilized];
            [[CommentListingService service] callChatListingServiceWithAKey:appDel.objUser.strAkey page:i published:@"Y" withCompletionHandler:^(id  _Nullable result, BOOL isError, NSString * _Nullable strMsg) {
                if (isError)
                {
                    [self displayErrorWithMessage:strMsg];
                }
                else
                {
                    arrComments=(id)result;
                }
                [tblComments reloadData];
            }];
        }
    }];

}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}

- (void)didReceiveMemoryWarning
{
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
    if (isRecentComments==YES)
    {
        return arrComments.count;
    }
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
    if (isRecentComments==YES)
    {
        ModelCommentDetails *obj=[arrComments objectAtIndex:indexPath.row];
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
    else
    {
        MyTagsListingCell *cell=[tableView dequeueReusableCellWithIdentifier:@"identifier"];
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
        cell.lblTagType.text=obj.strCname;
        cell.lblTagComments.text=obj.strTotal_comments;
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

        [cell.btnEdit addTarget:self action:@selector(btnEditPressed:) forControlEvents:UIControlEventTouchUpInside];
        if (indexPath.row==5)
        {
            cell.imgBottom.hidden=YES;
        }
        return cell;
    }
}


#pragma mark
#pragma mark IBCTIONS
#pragma mark

-(IBAction)btnRecentCommentsPressed:(id)sender
{
    i=0;
    isRecentComments=YES;
    [imgRecentComments setImage:[UIImage imageNamed:@"comment_active"]];
    [lblRecentComments setTextColor:[UIColor colorWithRed:36/255.0f green:93/255.0f blue:149/255.0f alpha:1.0]];
    [btnRecentComments setBackgroundColor:[UIColor whiteColor]];
    
    [imgMyTags setImage:[UIImage imageNamed:@"tags_inactive"]];
    [lblMyTags setTextColor:[UIColor whiteColor]];
    [btnMyTags setBackgroundColor:[UIColor colorWithRed:36/255.0f green:93/255.0f blue:149/255.0f alpha:1.0]];
    [tblComments reloadData];
}

-(IBAction)btnMyTagsPressed:(id)sender
{
    i=0;
    isLazyLoading=YES;
    isRecentComments=NO;
    [imgRecentComments setImage:[UIImage imageNamed:@"comment_inactive"]];
    [lblRecentComments setTextColor:[UIColor whiteColor]];
    [btnRecentComments setBackgroundColor:[UIColor colorWithRed:36/255.0f green:93/255.0f blue:149/255.0f alpha:1.0]];
    
    [imgMyTags setImage:[UIImage imageNamed:@"tags_active"]];
    [lblMyTags setTextColor:[UIColor colorWithRed:36/255.0f green:93/255.0f blue:149/255.0f alpha:1.0]];
    [btnMyTags setBackgroundColor:[UIColor whiteColor]];
    [self callWebService];
}

-(void)btnEditPressed:(id)sender
{
    MyTagsListingCell *cell=(MyTagsListingCell *)[self getSuperviewOfType:[UITableViewCell class] fromView:sender];
    NSLog(@"%@",cell.lblTagType.text);
    if ([cell.lblTagType.text isEqualToString:@"PERSON"])
    {
        strSegueKey=@"Person";
    }
    else if([cell.lblTagType.text isEqualToString:@"BUSINESS"])
    {
        strSegueKey=@"Business";

    }
    else if([cell.lblTagType.text isEqualToString:@"PET"])
    {
        strSegueKey=@"Pet";

    }
    else if([cell.lblTagType.text isEqualToString:@"PLACE"])
    {
        strSegueKey=@"Place";

    }
    else if([cell.lblTagType.text isEqualToString:@"THING"])
    {
        strSegueKey=@"Thing";

    }
    else if([cell.lblTagType.text isEqualToString:@"OTHER"])
    {
        strSegueKey=@"Other";
    }
    ModelEditTagsListing *obj=[arrResponse objectAtIndex:[sender tag]];
    strTkey=obj.strtkey;
    if (strTkey.length>0 && strSegueKey.length>0)
    {
        [self performSegueWithIdentifier:@"segueDashboardToEditTags" sender:self];
    }
    else
    {
        [self displayErrorWithMessage:@"This is not a valid tag.It doenot have any category name..."];
    }
}

#pragma mark
#pragma mark PREPARE FOR SEGUE
#pragma  mark

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"segueDashboardToEditTags"])
    {
        MyTagsEditModeController *master=[segue destinationViewController];
        master.strTKey=strTkey;
        master.strTagName=strSegueKey;
    }
}

#pragma mark
#pragma mark call Webservice
#pragma mark

-(void)callWebService
{
    if (!isRecentComments)
    {
        [[DashboardMyTagsListingService service]callDashboardMyTagsListServiceWithAkey:appDel.objUser.strKey page:i withCompletionHandler:^(id  _Nullable result, BOOL isError, NSString * _Nullable strMsg) {
            if (isError)
            {
               // [self displayErrorWithMessage:strMsg];
                isLazyLoading=NO;
            }
            else
            {
                if (i==0)
                {
                    arrResponse=(id)result;
                }
                else
                {
                    NSMutableArray *arr=(id)result;
                    NSLog(@"%@",arr);
                    if (arr.count>0)
                    {
                        for (int k=0; k<arr.count; k++)
                        {
                            [arrResponse addObject:[arr objectAtIndex:k]];
                        }
                    }
                }
                [tblComments reloadData];
            }
        }];
    }
    else
    {
        [[CommentListingService service] callChatListingServiceWithAKey:appDel.objUser.strAkey page:i published:@"Y" withCompletionHandler:^(id  _Nullable result, BOOL isError, NSString * _Nullable strMsg) {
            if (isError)
            {
                [self displayErrorWithMessage:strMsg];
                
            }
            else
            {
                arrComments=(id)result;
            }
            [tblComments reloadData];
        }];
    }
}

#pragma mark
#pragma mark scroll view delegate
#pragma mark


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([scrollView.panGestureRecognizer translationInView:scrollView].y > 0)
    {
        // down
        isScrollDown=NO;
    } else
    {
        // up
        isScrollDown=YES;
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSArray *visibleRows = [tblComments visibleCells];
    UITableViewCell *lastVisibleCell = [visibleRows lastObject];
    NSIndexPath *path = [tblComments indexPathForCell:lastVisibleCell];
    NSLog(@"%ld",(long)path.row);
    if (isRecentComments==NO)
    {
        if(path.row == arrResponse.count-1 && isScrollDown==YES && isLazyLoading==YES)
        {
            NSLog(@"Load more");
            i=i+1;
            [self callWebService];
        }
        else
        {
            
        }
    }
}



@end
