//
//  SidePanelController.m
//  LivingTags
//
//  Created by appsbeetech on 25/10/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "SidePanelController.h"
#import "SidePanelCell.h"

@interface SidePanelController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *arrLabel,*arrImages;
    UIView *vw;
}

@end

@implementation SidePanelController

#pragma mark
#pragma mark init Methods
#pragma mark

-(id)init
{
    if (self=[super init]) {
        self.isSlideMenuVisible=NO;
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super initWithCoder:aDecoder])
    {
        self.isSlideMenuVisible=NO;
    }
    return self;
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        self.isSlideMenuVisible=NO;
    }
    return self;
}


#pragma mark
#pragma mark shared instance
#pragma mark

+(id)getInstance
{
    static SidePanelController *master=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        master=[[SidePanelController alloc]initWithNibName:@"SidePanelController" bundle:nil];
    });
    return master;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_imgBackGround setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    
    // Setting the swipe direction.
    
    // Adding the swipe gesture on image view
    [_imgBackGround addGestureRecognizer:tapGesture];
    _tblSidePanel.delegate=self;
    _tblSidePanel.dataSource=self;
    _tblSidePanel.backgroundColor=[UIColor clearColor];
    _tblSidePanel.separatorStyle=UITableViewCellSeparatorStyleNone;
    arrLabel=[[NSMutableArray alloc]initWithObjects:@"Dashboard",@"My Tags",@"Comments",@"Products",@"My Profile",@"Settings",@"Help",@"About Us",@"Contact Us", nil];
    arrImages=[[NSMutableArray alloc]initWithObjects:@"dashborad",@"tags",@"comment",@"product",@"my_profile",@"setting",@"help",@"about",@"contact", nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark
#pragma mark swipe gesture
#pragma mark

- (void)handleTap:(UITapGestureRecognizer *)swipe
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(swipeToCloseSidePanel)])
    {
        [self.delegate swipeToCloseSidePanel];
    }
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
    return arrLabel.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (___isIphone4_4s)
    {
        return 40.0f;
        
    }
    else if (___isIphone5_5s)
    {
        return 50.0f;
        
    }
    else if (___isIphone6)
    {
        return 55.0f;;
    }
    else if (___isIpad)
    {
        return 100.0f;
    }
    else
    {
        return 60.0f;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SidePanelCell *cell=(SidePanelCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil)
    {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"SidePanelCell" owner:self options:nil]objectAtIndex:0];
    }
    cell.lblSidePanel.text=[arrLabel objectAtIndex:indexPath.row];
    cell.imgSidePanel.image=[UIImage imageNamed:[arrImages objectAtIndex:indexPath.row]];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor clearColor];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",(long)indexPath.row);
    SidePanelCell *cell = (SidePanelCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:55.0f/255.0f green:68/255.0f blue:77/255.0f alpha:1.0];
    vw=[[UIView alloc]initWithFrame:CGRectMake(0, 0,5, cell.contentView.frame.size.height)];
    vw.backgroundColor=[UIColor colorWithRed:87.0f/255.0f green:198.0f/255.0f blue:249.0f/255.0f alpha:1];
    [cell.contentView addSubview:vw];
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectedRowAtIndexPath:)])
    {
        [self.delegate selectedRowAtIndexPath:indexPath];
    }

    //[self tableView:tblSidePanel didDeselectRowAtIndexPath:indexPath];
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SidePanelCell *cell = (SidePanelCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    [vw removeFromSuperview];
    vw=nil;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
