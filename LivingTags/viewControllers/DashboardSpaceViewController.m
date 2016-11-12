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

@interface DashboardSpaceViewController ()<UITableViewDelegate,UITableViewDataSource>
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
    
}

@end

@implementation DashboardSpaceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    tblComments.separatorStyle=UITableViewCellSeparatorStyleNone;
    isRecentComments=NO;
    
    [imgRecentComments setImage:[UIImage imageNamed:@"comment_active"]];
    [lblRecentComments setTextColor:[UIColor colorWithRed:36/255.0f green:93/255.0f blue:149/255.0f alpha:1.0]];
    [btnRecentComments setBackgroundColor:[UIColor clearColor]];
    
    [imgMyTags setImage:[UIImage imageNamed:@"tags_inactive"]];
    [lblMyTags setTextColor:[UIColor whiteColor]];
    [btnMyTags setBackgroundColor:[UIColor colorWithRed:36/255.0f green:93/255.0f blue:149/255.0f alpha:1.0]];

}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    vwColour.layer.cornerRadius=vwColour.frame.size.height/2;
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
    return 6;
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
    if (isRecentComments==NO)
    {
        DashboardSizeCell *cell=[tableView dequeueReusableCellWithIdentifier:@"identifier"];
        if (!cell)
        {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"DashboardSizeCell" owner:self options:nil]objectAtIndex:0];
        }
        cell.imgPic.layer.cornerRadius=self.view.frame.size.width/11;
        cell.imgPic.clipsToBounds=YES;

        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    else
    {
        MyTagsListingCell *cell=[tableView dequeueReusableCellWithIdentifier:@"identifier"];
        if (!cell)
        {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"MyTagsListingCell" owner:self options:nil]objectAtIndex:0];
        }
        cell.imgPerson.layer.cornerRadius=self.view.frame.size.width/11;
        cell.imgPerson.clipsToBounds=YES;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
}


#pragma mark
#pragma mark IBCTIONS
#pragma mark

-(IBAction)btnRecentCommentsPressed:(id)sender
{
    isRecentComments=YES;
    [imgRecentComments setImage:[UIImage imageNamed:@"comment_inactive"]];
    [lblRecentComments setTextColor:[UIColor whiteColor]];
    [btnRecentComments setBackgroundColor:[UIColor colorWithRed:36/255.0f green:93/255.0f blue:149/255.0f alpha:1.0]];
    
    [imgMyTags setImage:[UIImage imageNamed:@"tags_active"]];
    [lblMyTags setTextColor:[UIColor colorWithRed:36/255.0f green:93/255.0f blue:149/255.0f alpha:1.0]];
    [btnMyTags setBackgroundColor:[UIColor clearColor]];
    [tblComments reloadData];
}


-(IBAction)btnMyTagsPressed:(id)sender
{
    isRecentComments=NO;
    [imgRecentComments setImage:[UIImage imageNamed:@"comment_active"]];
    [lblRecentComments setTextColor:[UIColor colorWithRed:36/255.0f green:93/255.0f blue:149/255.0f alpha:1.0]];
    [btnRecentComments setBackgroundColor:[UIColor clearColor]];
    
    [imgMyTags setImage:[UIImage imageNamed:@"tags_inactive"]];
    [lblMyTags setTextColor:[UIColor whiteColor]];
    [btnMyTags setBackgroundColor:[UIColor colorWithRed:36/255.0f green:93/255.0f blue:149/255.0f alpha:1.0]];
    [tblComments reloadData];
}

@end
