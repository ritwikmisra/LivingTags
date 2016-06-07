//
//  GroupPopupController.m
//  LivingTags
//
//  Created by appsbeetech on 31/05/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "GroupPopupController.h"
#import "GroupPopupCell.h"
#import "UIImageView+WebCache.h"

@interface GroupPopupController ()<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView *tblPopup;
}

@end

@implementation GroupPopupController


#pragma mark
#pragma mark singleton instance
#pragma mark

+(id)instance
{
    static GroupPopupController *master=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        master=[[GroupPopupController alloc]init];
    });
    return master;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    tblPopup.separatorStyle=UITableViewCellSeparatorStyleNone;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    ModelListing *obj=[self.arrGroupPopup firstObject];
    NSLog(@"%@",self.arrGroupPopup);
    NSString *str=[NSString stringWithFormat:@"%@ and %u others",obj.strName,self.arrGroupPopup.count-1];
    self.lblHeader.text=str;
    tblPopup.delegate=self;
    tblPopup.dataSource=self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return self.arrGroupPopup.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GroupPopupCell *cell=[tableView dequeueReusableCellWithIdentifier:@"identifier"];
    if (!cell)
    {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"GroupPopupCell" owner:self options:nil]objectAtIndex:0];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor clearColor];
    ModelListing *obj=[self.arrGroupPopup objectAtIndex:indexPath.row];
    NSLog(@"%@",obj.strName);
    cell.lblName.text=obj.strName;
    cell.lblDied.text=[NSString stringWithFormat:@"Died-%@",obj.strDied];
    NSURL *url=[NSURL URLWithString:obj.strPicURI];
    dispatch_async(dispatch_get_main_queue(), ^{
        [cell.img sd_setImageWithURL:url
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
    });
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ModelListing *obj=[self.arrGroupPopup objectAtIndex:indexPath.row];
    if (self.delegate && [self.delegate respondsToSelector:@selector(removePopupWithRow:)])
    {
        [self.delegate removePopupWithRow:obj];
    }
}

#pragma mark
#pragma mark IBACTION
#pragma mark

-(IBAction)btnClosePressed:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(removePopup)])
    {
        [self.delegate removePopup];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    tblPopup.delegate=nil;
    tblPopup.dataSource=nil;
}
@end
