
//
//  SlideMenuController.m
//  LivingTags
//
//  Created by appsbeetech on 12/05/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "SlideMenuController.h"
#import "SidePanelCell.h"
#import "UIImageView+WebCache.h"

@interface SlideMenuController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *arrLabel,*arrImages;
}

@end

@implementation SlideMenuController

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

+(id)getSlideMenuInstance
{
    static SlideMenuController *slide=nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        slide=[[SlideMenuController alloc]init];
    });
    return slide;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _tblSidePanel.separatorStyle=UITableViewCellSeparatorStyleNone;
    arrLabel=[[NSMutableArray alloc]initWithObjects:@"",@"Profile",@"Create Tags",@"Read Tags",@"My Tags",@"Contacts",@"Payments",@"Comments", nil];
    arrImages=[[NSMutableArray alloc]initWithObjects:@"",@"profile_icon_",@"creat_tag",@"read_tag",@"my_tag",@"contact",@"payments",@"comments", nil];
    [_tblSidePanel setBounces:NO];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _tblSidePanel.delegate=self;
    _tblSidePanel.dataSource=self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
    return arrLabel.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
        if(___isIphone6Plus)
        {
            return 180.0f;
        }
        if (___isIphone6)
        {
            return 160.0f;
        }
        if (___isIphone5_5s)
        {
            return 150.0f;
        }
        return 130.0;
    }
    else
    {
        if (___isIphone6Plus)
        {
            return 65.0f;
        }
        if (___isIphone6)
        {
            return 60.0f;
        }
        if (___isIphone5_5s)
        {
            return 50.0f;
        }
        return 45.0f;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //profile.png
    if (indexPath.row==0)
    {
        SidePanelCell *cell=[tableView dequeueReusableCellWithIdentifier:@"str"];
        if (!cell)
        {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"SidePanelCell" owner:self options:nil]objectAtIndex:1];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        [cell.btnLogout addTarget:self action:@selector(btnLogoutPressed:) forControlEvents:UIControlEventTouchUpInside];
        cell.lblName.text=appDel.objUser.strName;
        cell.lblEmail.text=appDel.objUser.strEmail;
        NSURL *url=[NSURL URLWithString:appDel.objUser.strPicURI160];
        dispatch_async(dispatch_get_main_queue(), ^{
            [cell.imgSidePanelProfile sd_setImageWithURL:url
                                placeholderImage:[UIImage imageNamed:@"profile.png"]
                                         options:SDWebImageHighPriority
                                        progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                            if (cell.actIndicatorSidePanel)
                                            {
                                                [cell.actIndicatorSidePanel startAnimating];
                                            }
                                        }
                                       completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                           [cell.actIndicatorSidePanel stopAnimating];
                                       }];
        });

        cell.backgroundColor=[UIColor clearColor];
        return cell;
    }
    else
    {
        SidePanelCell *cell=[tableView dequeueReusableCellWithIdentifier:@"str"];
        if (!cell)
        {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"SidePanelCell" owner:self options:nil]objectAtIndex:0];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.lblSidePanel.text=[arrLabel objectAtIndex:indexPath.row];
        cell.imgSidePanel.image=[UIImage imageNamed:[arrImages objectAtIndex:indexPath.row]];
        cell.backgroundColor=[UIColor clearColor];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
        
    }
    else
    {
        SidePanelCell *cell = (SidePanelCell *)[tableView cellForRowAtIndexPath:indexPath];
        cell.lblSidePanel.textColor=[UIColor whiteColor];
        if (self.delegate && [self.delegate respondsToSelector:@selector(selectedRowAtIndexPath:)])
        {
            [self.delegate selectedRowAtIndexPath:indexPath];
        }
    }
   // [self tableView:_tblSidePanel didDeselectRowAtIndexPath:indexPath];
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
   /* double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        NSLog(@"Do some work");
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        SidePanelCell *cell = (SidePanelCell *)[tableView cellForRowAtIndexPath:indexPath];
        cell.lblSidePanel.textColor=[UIColor blackColor];
    });*/
    SidePanelCell *cell = (SidePanelCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.lblSidePanel.textColor=[UIColor blackColor];
}

#pragma mark
#pragma mark BUTTON LOGOUT ACTION
#pragma mark

-(void)btnLogoutPressed:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(displayAlertControllerForLogout)])
    {
        [self.delegate displayAlertControllerForLogout];
    }

}
@end
