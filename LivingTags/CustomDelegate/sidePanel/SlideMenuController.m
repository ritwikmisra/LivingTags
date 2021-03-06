//
//  SlideMenuController.m
//  LivingTags
//
//  Created by appsbeetech on 12/05/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "SlideMenuController.h"
#import "SidePanelCell.h"

@interface SlideMenuController ()<UIGestureRecognizerDelegate,UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView *tblSidePanel;
    NSMutableArray *arrLabel;
}

@end

@implementation SlideMenuController

#pragma mark
#pragma mark init Methods
#pragma mark

-(id)init
{
    if (self=[super init]) {
        self.isSlideMenuPlaced=NO;
        self.isSlideMenuVisible=NO;
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super initWithCoder:aDecoder])
    {
        self.isSlideMenuPlaced=NO;
        self.isSlideMenuVisible=NO;
    }
    return self;
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        self.isSlideMenuPlaced=NO;
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
    tblSidePanel.separatorStyle=UITableViewCellSeparatorStyleNone;
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleFromTap:)];
    tapGesture.numberOfTapsRequired=1;
    self.imgBackground.userInteractionEnabled=YES;
    [self.imgBackground addGestureRecognizer:tapGesture];
    tapGesture.delegate=self;
    arrLabel=[[NSMutableArray alloc]initWithObjects:@"Profile",@"Create Tags",@"Read Tags",@"My Tags",@"Contacts",@"Payments",@"Comments",@"Logout", nil];
    tblSidePanel.delegate=self;
    tblSidePanel.dataSource=self;
}


-(void)handleFromTap:(UITapGestureRecognizer *)gesture
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tapGesturePressed)])
    {
        [self.delegate tapGesturePressed];
    }
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
    if (___isIphone6Plus)
    {
        return 80.0f;
    }
    if (___isIphone5_5s)
    {
        return 60.0f;
    }
    if (___isIphone6)
    {
        return 70.0f;
    }
    return 50.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SidePanelCell *cell=[tableView dequeueReusableCellWithIdentifier:@"str"];
    if (!cell)
    {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"SidePanelCell" owner:self options:nil]objectAtIndex:0];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.lbl.text=[arrLabel objectAtIndex:indexPath.row];
    cell.backgroundColor=[UIColor clearColor];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    SidePanelCell *cell = (SidePanelCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.lbl.textColor=[UIColor whiteColor];
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectedRowAtIndexPath:)])
    {
        [self.delegate selectedRowAtIndexPath:indexPath];
    }
    [self tableView:tblSidePanel didDeselectRowAtIndexPath:indexPath];
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        NSLog(@"Do some work");
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        SidePanelCell *cell = (SidePanelCell *)[tableView cellForRowAtIndexPath:indexPath];
        cell.lbl.textColor=[UIColor blackColor];
    });
}
@end
