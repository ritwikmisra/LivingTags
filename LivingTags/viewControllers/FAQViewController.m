//
//  FAQViewController.m
//  LivingTags
//
//  Created by appsbeetech on 22/11/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "FAQViewController.h"
#import "FAQCell.h"

@interface FAQViewController()<UITableViewDelegate,UITableViewDataSource>
{
    IBOutlet UITableView *tblFAQ;
    NSMutableArray *arrLabel,*arrStatus;
}
@end


@implementation FAQViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    tblFAQ.backgroundColor=[UIColor clearColor];
    tblFAQ.separatorStyle=UITableViewCellSeparatorStyleNone;
    arrLabel=[[NSMutableArray alloc]initWithObjects:@"What is a LivingTag?", @"How can an online memorial be shared in person?",@"What is a LivingTag Key?",@"Why would I want to create a LivingTag?",@"Are LivingTags only created for people?",@"What do I get when I create my LivingTag?",@"Can I add more memories later to my LivingTag?",@"What do I do with my LivingTag?",@"Will my LivingTag’s link, QR code, and Key ever change?",@"When am I ready to share my LivingTag?",@"Why is my LivingTag public by default?",@"Can I add a geographic location (geo-tag) to my LivingTag later?",nil];
    arrStatus=[[NSMutableArray alloc]initWithCapacity:arrLabel.count];
    for (int i=0; i<arrLabel.count; i++)
    {
        [arrStatus addObject:@"0"];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

#pragma mark
#pragma mark Tableview delegate and datasource
#pragma mark

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return arrLabel.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([[arrStatus objectAtIndex:section]isEqualToString:@"1"])
    {
        return 1;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150.0f;
}


-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *identifierHeader=@"HeaderCell";
    FAQCell *cellHeader=(FAQCell*)[tableView dequeueReusableCellWithIdentifier:identifierHeader];
    if (cellHeader==nil)
    {
        cellHeader=[[[NSBundle mainBundle]loadNibNamed:@"FAQCell" owner:self options:nil]objectAtIndex:0];
    }
    if (section==arrLabel.count-1)
    {
        cellHeader.vwFooter.hidden=YES;
    }
    cellHeader.lbl.text=[arrLabel objectAtIndex:section];
    cellHeader.contentView.backgroundColor=[UIColor whiteColor];
    cellHeader.btnHeader.tag=section;
    [cellHeader.btnHeader addTarget:self action:@selector(btnCellHeaderClicked:) forControlEvents:UIControlEventTouchUpInside];
    return cellHeader.contentView;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    FAQCell *cellRow=(FAQCell *)[tableView dequeueReusableCellWithIdentifier:@"identifier"];
    if (!cellRow)
    {
        cellRow=[[[NSBundle mainBundle]loadNibNamed:@"FAQCell" owner:self options:nil] objectAtIndex:1];
    }
    if (indexPath.section==0)
    {
        
    }
    else if (indexPath.section==1)
    {
        
    }
    else if (indexPath.section==2)
    {
        
    }
    else if (indexPath.section==3)
    {
        
    }
    else if (indexPath.section==4)
    {
        
    }
    else if (indexPath.section==5)
    {
        
    }
    else if (indexPath.section==6)
    {
        
    }
    else if (indexPath.section==7)
    {
        
    }
    else if (indexPath.section==8)
    {
        
    }
    else if (indexPath.section==9)
    {
        
    }
    else if (indexPath.section==10)
    {
        
    }
    else
    {
        
    }
    [cellRow.txtVwDetails setEditable:NO];
    cellRow.selectionStyle=UITableViewCellSelectionStyleNone;
    cellRow.backgroundColor=[UIColor clearColor];
    cell=cellRow;
    return cell;
}

#pragma mark
#pragma mark Button actions
#pragma mark

-(void)btnCellHeaderClicked:(id)sender
{
    int menuOpenStatus=[[arrStatus objectAtIndex:[sender tag]] intValue];
    
    NSLog(@"Clicked At: %ld",(long)[sender tag]);
    NSLog(@"Current MenuStatus: %d",menuOpenStatus);
    NSLog(@"Before arrMenuExpandStatus: %@",arrStatus);
    
    for (int i=0; i<arrStatus.count; i++)
    {
        if (i!=[sender tag] && [[arrStatus objectAtIndex:i] intValue]==1)
        {
            [arrStatus removeObjectAtIndex:i];
            [arrStatus insertObject:@"0" atIndex:i];
        }
    }
    if (menuOpenStatus==1)
    {
        [arrStatus removeObjectAtIndex:[sender tag]];
        [arrStatus insertObject:@"0" atIndex:[sender tag]];
    }
    else
    {
        [arrStatus removeObjectAtIndex:[sender tag]];
        [arrStatus insertObject:@"1" atIndex:[sender tag]];
    }
    [tblFAQ reloadData];
}

@end
