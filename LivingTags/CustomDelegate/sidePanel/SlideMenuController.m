
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
    UIView *animateView;
    NSIndexPath *selectedIndexPath;
    NSIndexPath *deSelectedIndexPath;
    NSIndexPath *previousSelectedIndexPath;
    UIView *smallView;
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
    arrLabel=[[NSMutableArray alloc]initWithObjects:@"",@"DASHBOARD",@"PROFILE",@"CREATETAGS",@"READTAGS",@"MYTAGS",@"CONTACTS",@"PAYMENTS",@"COMMENTS",@"LOGOUT", nil];
    arrImages=[[NSMutableArray alloc]initWithObjects:@"",@"DASHBOARD",@"profile_icon_",@"creat_tag",@"read_tag",@"my_tag",@"contact",@"payments",@"comments",@"logout_icon", nil];
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
            return 145.0f; //150.0f
        }
        return 130.0; 
    }
    else
    {
        if (___isIphone6Plus)
        {
            return 60.0f;//65.0f
        }
        if (___isIphone6)
        {
            return 55.0f;//60.0f
        }
        if (___isIphone5_5s)
        {
            return 45.0f;//50.0f
        }
        return 45.0f;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //profile.png
    if (indexPath.row==0)
    {
        SidePanelCell *cell=(SidePanelCell *)[tableView dequeueReusableCellWithIdentifier:@"str"];
        if (!cell)
        {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"SidePanelCell" owner:self options:nil]objectAtIndex:1];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
       // [cell.btnLogout addTarget:self action:@selector(btnLogoutPressed:) forControlEvents:UIControlEventTouchUpInside];
        cell.lblName.text=appDel.objUser.strName;
        cell.lblEmail.text=appDel.objUser.strEmail;
        NSLog(@"%@ %@",appDel.objUser.strName,appDel.objUser.strEmail);
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
        SidePanelCell *cell=(SidePanelCell *)[tableView dequeueReusableCellWithIdentifier:@"str"];
        
        if (!cell)
        {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"SidePanelCell" owner:self options:nil]objectAtIndex:0];
        }
        CGFloat cellHeight = [tableView rectForRowAtIndexPath:indexPath].size.height;
        
        if (indexPath.row == 1)
        {
            if (appDel.isFirstTime)
            {
                cell.lblSidePanel.textColor=[UIColor whiteColor];
                animateView = [[UIView alloc]initWithFrame:CGRectMake(cell.frame.origin.y, cell.frame.origin.y, self.view.frame.size.width, cellHeight)];
                smallView = [[UIView alloc]initWithFrame:CGRectMake(cell.frame.origin.x, cell.frame.origin.y, 8, cellHeight)];
                smallView.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:127.0/255.0 blue:0.0/255.0 alpha:1];
                smallView.hidden = NO;
                selectedIndexPath = indexPath;
                // appDel.isFirstTime = NO;
                
                animateView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.3f];
                
                animateView.tag = indexPath.row;
                smallView.tag = indexPath.row;
                [animateView addSubview:smallView];
                [cell.contentView addSubview:animateView];

            }
            
        }
        
        else if (indexPath.row == 9)
        {
            
        }
        
        else
        {
            cell.lblSidePanel.textColor=[UIColor blackColor];
            animateView = [[UIView alloc]initWithFrame:CGRectMake(-self.view.frame.size.width, cell.frame.origin.y, self.view.frame.size.width,cellHeight)];
            smallView = [[UIView alloc]initWithFrame:CGRectMake(cell.frame.origin.x, cell.frame.origin.y, 8, cellHeight)];
            smallView.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:127.0/255.0 blue:0.0/255.0 alpha:1];
            smallView.hidden = NO;
            
            animateView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.3f];
            
            animateView.tag = indexPath.row;
            smallView.tag = indexPath.row;
            [animateView addSubview:smallView];
            [cell.contentView addSubview:animateView];

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
    SidePanelCell *deSelectedcell = (SidePanelCell *)[tableView cellForRowAtIndexPath:deSelectedIndexPath];
    SidePanelCell *previousSelectedcell = (SidePanelCell *)[tableView cellForRowAtIndexPath:selectedIndexPath];
    
    if (indexPath.row==0)
    {
        previousSelectedcell.lblSidePanel.textColor=[UIColor whiteColor];
        [[deSelectedcell.contentView subviews] objectAtIndex:3].hidden = NO;
    }
    
    else if (indexPath.row == 9)
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(displayAlertControllerForLogout)])
        {
            [self.delegate displayAlertControllerForLogout];
        }
    }
    
    else
    {
        if (appDel.isFirstTime)
        {
            deSelectedcell = (SidePanelCell *)[tableView cellForRowAtIndexPath:selectedIndexPath];
            appDel.isFirstTime = NO;
        }
        
        [[deSelectedcell.contentView subviews] objectAtIndex:3].hidden = YES;
        SidePanelCell *cell = (SidePanelCell *)[tableView cellForRowAtIndexPath:indexPath];
        [self performSelector:@selector(startAnimationforView:) withObject:cell afterDelay:0.2];
        previousSelectedcell.lblSidePanel.textColor = [UIColor blackColor];
        cell.lblSidePanel.textColor=[UIColor whiteColor];
        selectedIndexPath = indexPath;
        
    }
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
    
    if (indexPath.row == 0) {
        
    }
    else if (indexPath.row == 9)
    {
        
    }
    else
    {
        deSelectedIndexPath = indexPath;
    }
}

#pragma mark - Animation for view

-(void) startAnimationforView :(SidePanelCell *)cell
{
    NSIndexPath *path = [_tblSidePanel indexPathForCell:cell];
    
    CABasicAnimation *anim=[CABasicAnimation animationWithKeyPath:@"position.x"];
    anim.delegate=self;
    anim.fromValue=[NSNumber numberWithFloat:-self.view.frame.size.width];//-320.0f
    anim.toValue=[NSNumber numberWithFloat:(self.view.bounds.size.width/2)];
    anim.duration=0.2f;
    
    anim.repeatCount =1;
    anim.removedOnCompletion = NO;
    
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    anim.fillMode=kCAFillModeForwards;
    
    [[cell.contentView subviews] objectAtIndex:3].hidden = NO;
    if (path.row == 1)
    {
        [[[[cell.contentView subviews] objectAtIndex:3] subviews] objectAtIndex:0].hidden = NO;
    }
    
    UIView *vW = [[cell.contentView subviews] objectAtIndex:3];
    
    [vW.layer addAnimation:anim forKey:@"position.x"];
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [self performSelector:@selector(callSelectedRowAtIndexPath) withObject:nil afterDelay:0.2];
}

-(void)callSelectedRowAtIndexPath
{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectedRowAtIndexPath:)])
    {
        [self.delegate selectedRowAtIndexPath:selectedIndexPath];
    }
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
