//
//  CommentListController.m
//  LivingTags
//
//  Created by appsbeetech on 29/11/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "CommentListController.h"
#import "DashboardSizeCell.h"

@interface CommentListController ()<UITableViewDelegate,UITableViewDataSource>
{
    IBOutlet UIButton *btnPublish;
    IBOutlet UIButton *btnUnpublish;
    BOOL isPublish;
    NSMutableArray *arrResponse;
    IBOutlet UITableView *tblComments;
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
        
    }
    else
    {
        
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
    DashboardSizeCell *cell=[tableView dequeueReusableCellWithIdentifier:@"identifier"];
    if (!cell)
    {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"DashboardSizeCell" owner:self options:nil]objectAtIndex:0];
    }
    cell.imgPic.layer.cornerRadius=self.view.frame.size.width/12;
    cell.imgPic.clipsToBounds=YES;
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
