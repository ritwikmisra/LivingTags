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
        cellRow.txtVwDetails.text=@"A LivingTag is an online memorial—text, photos, videos and more—that chronicles  and preserves memories that you can share with your friends and family, or others around the world.In essence, it’s a collection of memories in one place that tells a story and that can be shared with anyone, anywhere, online or in person. It’s a personal website for you to own, build, and share.";
    }
    else if (indexPath.section==1)
    {
        cellRow.txtVwDetails.text=@"Your LivingTag comes with its own unique QR code, which can then be placed anywhere in the physical world or embedded on your own, personalized LivingTag Key.For example, you can place your LivingTag’s Key on your loved one’s gravestone. That way your friends and family, or anyone who scans the code when they visit the grave, can view your LivingTag and share in the memories you’ve preserved.";

    }
    else if (indexPath.section==2)
    {
        cellRow.txtVwDetails.text=@"Your LivingTag Key is a 2-inch by 2-inch piece of anodized aluminum that is laser-engraved with your unique LivingTag’s QR code. It comes with 3M adhesive tape so you can easily affix it to any surface.Your LivingTag Key is unique to your LivingTag and will never change. You can add to and edit your LivingTag as often as you like, but rest assured that your Key will always point to the latest version of your LivingTag.";

    }
    else if (indexPath.section==3)
    {
        cellRow.txtVwDetails.text=@"Memories are our greatest treasure, and a LivingTag helps preserve those memories. Though the reasons for creating a LivingTag are limitless, the most common reasons are to chronicle and preserve our memories, of people or of anything else you wish to remember,to celebrate the lives of our loved ones,to help cope with the loss of a loved one.to provide a way for our loved ones to live on,to share a story to those closest to us and to the world ,to deepen our connections to each other, to our loved ones, and to the world.";
    }
    else if (indexPath.section==4)
    {
        cellRow.txtVwDetails.text=@"Memories are our greatest treasure, and a LivingTag helps preserve those memories. Though the reasons for creating a LivingTag are limitless, the most common reasons are to chronicle and preserve our memories, of people or of anything else you wish to remember,to celebrate the lives of our loved ones,to help cope with the loss of a loved one.to provide a way for our loved ones to live on,to share a story to those closest to us and to the world ,to deepen our connections to each other, to our loved ones, and to the world.";

    }
    else if (indexPath.section==5)
    {
        cellRow.txtVwDetails.text=@"When you create your LivingTag, you get a unique link on our website for your memorial—basically, you can think of your LivingTag as a personal website.You also get a unique QR code, which can be engraved on your own, unique aluminum Key. You can affix your LivingTag Key on any surface. The link, QR code, and Key can be used to share your memorial, helping to celebrate and preserve your memories.";

    }
    else if (indexPath.section==6)
    {
        cellRow.txtVwDetails.text=@"Yes. Your LivingTag can be updated at any time. In fact, we hope you continually add memories to your LivingTag. The more memories you chronicle and preserve, the richer the memorial.";
    }
    else if (indexPath.section==7)
    {
        cellRow.txtVwDetails.text=@"Ultimately, we want you to share your LivingTag with others. You can share it with just your family and friends, or you can share it with the world so that anyone, anywhere, can experience your LivingTag’s story.";
    }
    else if (indexPath.section==8)
    {
        cellRow.txtVwDetails.text=@"No. Once you’ve created your LivingTag, you can count on the unique link and QR code, as well as any Keys you have made, to never change.";

    }
    else if (indexPath.section==9)
    {
        cellRow.txtVwDetails.text=@"Whenever you’d like. Once created, you can immediately begin sharing your LivingTag using the link, QR code, or Key.";

    }
    else if (indexPath.section==10)
    {
        cellRow.txtVwDetails.text=@"In addition to the unique link and QR code, you can also share your LivingTag like pdf (available in the LivingTags store),aluminum LivingTags Key (available in the LivingTags store),geo-tags Social media buttons";
    }
    else
    {
        cellRow.txtVwDetails.text=@"Absolutely. As soon as you’ve created your LivingTag, your unique link, QR code, and Key are yours to keep and use to share your LivingTag with others.";
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
