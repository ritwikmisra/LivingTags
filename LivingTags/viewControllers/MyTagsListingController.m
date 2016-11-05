//
//  MyTagsListingController.m
//  LivingTags
//
//  Created by appsbeetech on 05/11/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "MyTagsListingController.h"
#import "MyTagsListingCell.h"

@interface MyTagsListingController ()<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView *tblListing;
}

@end

@implementation MyTagsListingController

- (void)viewDidLoad {
    [super viewDidLoad];
    tblListing.separatorStyle=UITableViewCellSeparatorStyleNone;
    tblListing.backgroundColor=[UIColor clearColor];
    NSLog(@"%@",self.strTagName);
}

- (void)didReceiveMemoryWarning {
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
    MyTagsListingCell *cell=[tableView dequeueReusableCellWithIdentifier:@"identifier"];
    if (!cell)
    {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"MyTagsListingCell" owner:self options:nil]objectAtIndex:0];
    }
    cell.backgroundColor=[UIColor whiteColor];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.imgPerson.layer.cornerRadius=self.view.frame.size.width/11;
    cell.imgPerson.clipsToBounds=YES;
    cell.btnEdit.tag=indexPath.row;
    [cell.btnEdit addTarget:self action:@selector(btnEditPressed:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

#pragma mark
#pragma mark IBACTIONS
#pragma mark

-(void)btnEditPressed:(id)sender
{
    
}

@end
