//
//  MyLivingTagesViewController.m
//  LivingTags
//
//  Created by appsbeetech on 06/05/16.
//  Copyright © 2016 appsbeetech. All rights reserved.


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
    NSMutableArray *arrNames,*arrList,*arrMaps;
    BOOL isScrollDown,isCreated;
    int i;
    MyLivingTagsMapViewController *master;
    BOOL isLazyLoading;
    ModelListing *objSegue;
    IBOutlet UIView *vwCreatedTags;
    IBOutlet UIView *vwPendingTags;
    IBOutlet UIButton *btnCreatedTags;
    IBOutlet UIButton *btnPendingTags;
}
@end

@implementation MyLivingTagesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [txtSearch setValue:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
    [tblTags setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    isCreated=YES;
    vwCreatedTags.backgroundColor=[UIColor colorWithRed:246/255.0f green:132/255.0f blue:31/255.0f alpha:1];
    [btnCreatedTags setTitleColor:[UIColor colorWithRed:246/255.0f green:132/255.0f blue:31/255.0f alpha:1] forState:UIControlStateNormal];
    vwPendingTags.backgroundColor=[UIColor clearColor];
    [btnPendingTags setTitleColor:[UIColor colorWithRed:142/255.0f green:142/255.0f blue:142/255.0f alpha:1] forState:UIControlStateNormal];
    tblTags.delegate=self;
    tblTags.dataSource=self;
    i=0;
    arrList=[[NSMutableArray alloc]init];
    arrMaps=[[NSMutableArray alloc]init];
    NSLog(@"%@",arrList);
    isLazyLoading=YES;
    /*[[LivingTagsListingService service]callListingServiceWithUserID:appDel.objUser.strUserID  paging:i name:txtSearch.text withCompletionHandler:^(id  _Nullable result, BOOL isError, NSString * _Nullable strMsg) {
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
                    if ([obj.strPublished isEqualToString:@"P"])
                    {
                        [arrMaps addObject:obj];
                    }
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
    }];*/
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

-(IBAction)textfieldEdited:(id)sender
{
    UITextField *textfield=(id)sender;
    if (textfield.text.length==0)
    {
        //[self callWebService];
    }
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
    //return arrNames.count;
    if (isCreated==YES)
    {
        return 7;
    }
    return 4;
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
    if (isCreated==YES)
    {
        LivingTagsCell *cell=[tableView dequeueReusableCellWithIdentifier:@"str"];
        if (!cell)
        {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"LivingTagsCell" owner:self options:nil]objectAtIndex:0];
        }
//        NSMutableDictionary *dic=[arrNames objectAtIndex:indexPath.row];
//        ModelListing *obj=[[ModelListing alloc] initWithDictionary:dic];
//        cell.lblName.text=obj.strName;
//        cell.lblDate.text=[NSString stringWithFormat:@"Created on %@",obj.strCreated];
//        cell.lblLocation.text=obj.strAddress1;
        /*NSURL *url=[NSURL URLWithString:obj.strPicURI];
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
         });*/
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
        return cell;
    }
    else
    {
        LivingTagsCell *cell=[tableView dequeueReusableCellWithIdentifier:@"str"];
        if (!cell)
        {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"LivingTagsCell" owner:self options:nil]objectAtIndex:1];
        }
        //NSMutableDictionary *dic=[arrNames objectAtIndex:indexPath.row];
//        ModelListing *obj=[[ModelListing alloc] initWithDictionary:dic];
//        cell.lblName.text=obj.strName;
//        cell.lblDate.text=[NSString stringWithFormat:@"Created on %@",obj.strCreated];
//        cell.lblLocation.text=obj.strAddress1;
        /*NSURL *url=[NSURL URLWithString:obj.strPicURI];
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
         });*/
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
        return cell;

    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    objSegue=[arrList objectAtIndex:indexPath.row];
    if ([objSegue.strPublished isEqualToString:@"P"])
    {
        //[self performSegueWithIdentifier:@"segueLivingTagsDetails" sender:self];
    }
}
#pragma mark
#pragma mark scroll view delegate
#pragma mark


/*-(void)scrollViewDidScroll:(UIScrollView *)scrollView
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
}*/

#pragma mark
#pragma mark IBACTION
#pragma mark

-(IBAction)btnMapPressed:(id)sender
{
    master=[MyLivingTagsMapViewController instance];
    master.view.frame=CGRectMake(vwList.frame.origin.x,0,vwList.frame.size.width, vwList.frame.size.height);
    [self addChildViewController:master];
    [master didMoveToParentViewController:self];
    NSLog(@"%@",arrMaps);
    //master.arrListFromMap=arrMaps;
    [vwList addSubview:master.view];
    master.delegate=self;
}

-(IBAction)btnPendingtagsPressed:(id)sender
{
    [btnCreatedTags setTitleColor:[UIColor colorWithRed:142/255.0f green:142/255.0f blue:142/255.0f alpha:1] forState:UIControlStateNormal];
    [btnPendingTags setTitleColor:[UIColor colorWithRed:246/255.0f green:132/255.0f blue:31/255.0f alpha:1] forState:UIControlStateNormal];
    vwPendingTags.backgroundColor=[UIColor colorWithRed:246/255.0f green:132/255.0f blue:31/255.0f alpha:1];
    vwCreatedTags.backgroundColor=[UIColor clearColor];
    isCreated=NO;
    [tblTags reloadData];
}

-(IBAction)btnCreatedTagsPressed:(id)sender
{
    [btnCreatedTags setTitleColor:[UIColor colorWithRed:246/255.0f green:132/255.0f blue:31/255.0f alpha:1] forState:UIControlStateNormal];
    [btnPendingTags setTitleColor:[UIColor colorWithRed:142/255.0f green:142/255.0f blue:142/255.0f alpha:1] forState:UIControlStateNormal];
    vwPendingTags.backgroundColor=[UIColor clearColor];
    vwCreatedTags.backgroundColor=[UIColor colorWithRed:246/255.0f green:132/255.0f blue:31/255.0f alpha:1];
    isCreated=YES;
    [tblTags reloadData];
}

-(IBAction)btnSearchPressed:(id)sender
{

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
    NSLog(@"Names:%@\n List:%@",arrNames,arrList);
    [arrNames removeAllObjects];
    [arrList removeAllObjects];
    [arrMaps removeAllObjects];
    NSLog(@"Names:%@\n List:%@",arrNames,arrList);
    tblTags.delegate=nil;
    tblTags.dataSource=nil;
}
 @end
