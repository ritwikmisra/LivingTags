//
//  MyLivingTagesViewController.m
//  LivingTags
//
//  Created by appsbeetech on 06/05/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "MyLivingTagesViewController.h"
#import "LivingTagsCell.h"
#import "LivingTagsListingService.h"
#import "ModelListing.h"
#import "UIImageView+WebCache.h"
#import "MyLivingTagsMapViewController.h"
#import "LivingTagsViewController.h"

@interface MyLivingTagesViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UITextFieldDelegate,RemoveMapFromListDelegate>
{
    IBOutlet UITextField *txtSearch;
    IBOutlet UITableView *tblTags;
    IBOutlet UIView *vwList;
    NSMutableArray *arrNames,*arrList;
    BOOL isScrollDown;
    int i;
    MyLivingTagsMapViewController *master;
    BOOL isLazyLoading;
    ModelListing *objSegue;
}

@end

@implementation MyLivingTagesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [txtSearch setValue:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
    [tblTags setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    arrList=[[NSMutableArray alloc]init];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    i=0;
    NSLog(@"%@",arrList);
    isLazyLoading=YES;
    [[LivingTagsListingService service]callListingServiceWithUserID:appDel.objUser.strUserID  paging:i withCompletionHandler:^(id  _Nullable result, BOOL isError, NSString * _Nullable strMsg) {
        if (isError)
        {
            [self displayErrorWithMessage:strMsg];
        }
        else
        {
            if ([result isKindOfClass:[NSMutableArray class]])
            {
                arrNames=(id)result;
                for (int k=0; k<arrNames.count; k++)
                {
                    ModelListing *obj=[[ModelListing alloc]initWithDictionary:[arrNames objectAtIndex:k]];
                    [arrList addObject:obj];
                }
                NSLog(@"%@",arrList);
                NSLog(@"%lu",(unsigned long)arrNames.count);
            }
            else
            {
                [arrNames removeAllObjects];
                [self displayErrorWithMessage:strMsg];
            }
            [tblTags reloadData];
        }
    }];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark
#pragma mark textfield delegate
#pragma mark

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
    return arrNames.count;
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
    NSMutableDictionary *dic=[arrNames objectAtIndex:indexPath.row];
    ModelListing *obj=[[ModelListing alloc] initWithDictionary:dic];
    cell.lblName.text=obj.strName;
    cell.lblDate.text=[NSString stringWithFormat:@"Created on %@",obj.strCreated];
    cell.lblLocation.text=obj.strAddress1;
    NSURL *url=[NSURL URLWithString:obj.strPicURI];
    dispatch_async(dispatch_get_main_queue(), ^{
        [cell.imgTag sd_setImageWithURL:url
                            placeholderImage:[UIImage imageNamed:@"defltmale_user_icon"]
                                     options:SDWebImageHighPriority
                                    progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                        if (cell.actIndicatorTag)
                                        {
                                            [cell.actIndicatorTag startAnimating];
                                        }
                                    }
                                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                       [cell.actIndicatorTag stopAnimating];
                                   }];
    });
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor clearColor];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   objSegue=[arrList objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"segueLivingTagsDetails" sender:self];
    
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
    NSArray *visibleRows = [tblTags visibleCells];
    UITableViewCell *lastVisibleCell = [visibleRows lastObject];
    NSIndexPath *path = [tblTags indexPathForCell:lastVisibleCell];
    NSLog(@"%ld",(long)path.row);
    if(path.row == arrNames.count-1 && isScrollDown==YES && isLazyLoading==YES)
    {
         NSLog(@"Load more");
        i=i+1;
        [self callWebService];
    }
    else
    {
        
    }
}

#pragma mark
#pragma mark IBACTION
#pragma mark

-(IBAction)btnMapPressed:(id)sender
{
    master=[MyLivingTagsMapViewController instance];
    master.view.frame=CGRectMake(vwList.frame.origin.x,0,vwList.frame.size.width, vwList.frame.size.height);
    [self addChildViewController:master];
    [master didMoveToParentViewController:self];
    NSLog(@"%@",arrList);
    master.arrListFromMap=arrList;
    [vwList addSubview:master.view];
    master.delegate=self;
}

#pragma mark
#pragma mark call webservice
#pragma mark

-(void)callWebService
{
    NSLog(@"%d",i);
    NSLog(@"%@",arrList);
    [[LivingTagsListingService service]callListingServiceWithUserID:appDel.objUser.strUserID paging:i withCompletionHandler:^(id  _Nullable result, BOOL isError, NSString * _Nullable strMsg) {
        if (isError)
        {
            [self displayErrorWithMessage:strMsg];
        }
        else
        {
            if ([result isKindOfClass:[NSMutableArray class]])
            {
                NSMutableArray *arr=(id)result;
                if (i==0)
                {
                    for (int k=0; k<arrNames.count; k++)
                    {
                        ModelListing *obj=[[ModelListing alloc]initWithDictionary:[arrNames objectAtIndex:k]];
                        [arrList addObject:obj];
                    }
                    NSLog(@"%lu",(unsigned long)arrNames.count);
                }
                else
                {
                    for (NSDictionary *dict in arr)
                    {
                        [arrNames addObject:dict];
                    }
                    if (arrList.count>0)
                    {
                        [arrList removeAllObjects];
                    }
                    for (int m=0; m<arrNames.count; m++)
                    {
                        ModelListing *obj=[[ModelListing alloc]initWithDictionary:[arrNames objectAtIndex:m]];
                        [arrList addObject: obj];
                    }
                }
            }
            else
            {
                isLazyLoading=NO;
            }
            NSLog(@"%lu",(unsigned long)arrNames.count);
            NSLog(@"%@",arrList);
            [tblTags reloadData];
        }
    }];
}

#pragma mark
#pragma mark Custom Mapview Delegate
#pragma mark

-(void)removeMapFromSuperview;
{
    master=[MyLivingTagsMapViewController instance];
    [master.view removeFromSuperview];
    [master removeFromParentViewController];
    master=nil;
}

#pragma mark
#pragma mark prepare for segue
#pragma mark

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"segueLivingTagsDetails"])
    {
        LivingTagsViewController *master1=[segue destinationViewController];
        master1.objHTML=objSegue;
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"Disappear");
    [arrNames removeAllObjects];
    [arrList removeAllObjects];
}
 @end
