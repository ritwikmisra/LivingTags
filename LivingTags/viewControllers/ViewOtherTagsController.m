//
//  ViewOtherTagsController.m
//  LivingTags
//
//  Created by appsbeetech on 23/11/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "ViewOtherTagsController.h"
#import "LivingTagsCell.h"
#import "ViewLocalTagsService.h"
#import "ModelViewLocalTags.h"
#import "MyLivingTagsMapViewController.h"
#import "UIImageView+WebCache.h"
#import "PreviewViewController.h"


@interface ViewOtherTagsController ()<UITableViewDelegate,UITableViewDataSource,RemoveMapFromListDelegate>
{
    IBOutlet UITableView *tblOtherTags;
    NSMutableArray *arrResponse;
    BOOL isScrollDown;
    BOOL isLazyLoading;
    int i;
    MyLivingTagsMapViewController *master;
    IBOutlet UIView *vwTable;
    NSString *strSegueLink;
}

@end

@implementation ViewOtherTagsController

- (void)viewDidLoad
{
    [super viewDidLoad];
    tblOtherTags.backgroundColor=[UIColor clearColor];
    tblOtherTags.separatorStyle=UITableViewCellSeparatorStyleNone;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    i=0;
    isLazyLoading=YES;
    [self callWebService];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
    if (___isIphone4_4s)
    {
        return 90.0f;
    }
    return 100.0f;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LivingTagsCell *cell=[tableView dequeueReusableCellWithIdentifier:@"str"];
    if (!cell)
    {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"LivingTagsCell" owner:self options:nil]objectAtIndex:0];
    }
    ModelViewLocalTags *obj=[arrResponse objectAtIndex:indexPath.row];
    cell.lblName.text=obj.strName;
    cell.lblDate.text=obj.strPostedOn;
    cell.lblLocation.text=[NSString stringWithFormat:@"%@ miles away",obj.strDistance];
    NSLog(@"%@",obj.strTPhoto);
    dispatch_async(dispatch_get_main_queue(), ^{
        [cell.imgTag sd_setImageWithURL:[NSURL URLWithString:obj.strTPhoto]
                                     placeholderImage:[UIImage imageNamed:@"defltmale_user_icon"]
                                              options:SDWebImageHighPriority
                                             progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                                 [cell.actIndicatorTag startAnimating];
                                             }
                                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                                [cell.actIndicatorTag stopAnimating];
                                                
                                            }];
    });

    cell.backgroundColor=[UIColor clearColor];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}


#pragma mark
#pragma mark call webservice
#pragma mark

-(void)callWebService
{
    [[ViewLocalTagsService service]getLocalLivingTagsWithAKey:appDel.objUser.strAkey page:i withCompletionHandler:^(id  _Nullable result, BOOL isError, NSString * _Nullable strMsg) {
        if (isError)
        {
            [self displayErrorWithMessage:strMsg];
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
            [tblOtherTags reloadData];
        }
    }];

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
    NSArray *visibleRows = [tblOtherTags visibleCells];
    UITableViewCell *lastVisibleCell = [visibleRows lastObject];
    NSIndexPath *path = [tblOtherTags indexPathForCell:lastVisibleCell];
    NSLog(@"%ld",(long)path.row);
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

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [arrResponse removeAllObjects];
    i=0;
}

#pragma mark
#pragma mark IBACTIONS
#pragma mark

-(IBAction)btnMapPressed:(id)sender
{
    master=[MyLivingTagsMapViewController instance];
    master.view.frame=CGRectMake(0,0,vwTable.frame.size.width, vwTable.frame.size.height);
    NSLog(@"%@",arrResponse);
    master.arrListFromMap=arrResponse;
    master.delegate=self;
    [vwTable addSubview:master.view];
    [self addChildViewController:master];
    [master didMoveToParentViewController:self];
}

#pragma mark
#pragma mark CUSTOM DELEGATE FOR MAP DELEGATE
#pragma mark

-(void)removeMapFromSuperview
{
    [master.view removeFromSuperview];
    [master removeFromParentViewController];
    master=nil;
}

-(void)moveToWebview:(NSString *)str
{
    strSegueLink=str;
    [master.view removeFromSuperview];
    [master removeFromParentViewController];
    master=nil;
    [self performSegueWithIdentifier:@"segueMapToPreview" sender:self];
}

#pragma mark
#pragma mark PREPARE FOR SEGUE
#pragma mark

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"segueMapToPreview"])
    {
        PreviewViewController *masterPreview=[segue destinationViewController];
        masterPreview.str=strSegueLink;
        masterPreview.strLabel=@"Published tags";
    }
}

@end
