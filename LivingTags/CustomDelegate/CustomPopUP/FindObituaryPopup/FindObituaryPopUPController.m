//
//  FindObituaryPopUPController.m
//  LivingTags
//
//  Created by appsbeetech on 01/12/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "FindObituaryPopUPController.h"
#import "FindObituaryCell.h"
#import "UIImageView+WebCache.h"
#import "ModelFindObituary.h"

@interface FindObituaryPopUPController ()<UITableViewDelegate,UITableViewDataSource>
{
    IBOutlet UIView *vwObituary;
    IBOutlet UIButton *btnSkip;
    IBOutlet UITableView *tblObituary;
}

@end

@implementation FindObituaryPopUPController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"%@",self.arrObituary);
    tblObituary.separatorStyle=UITableViewCellSeparatorStyleNone;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"%@",self.arrObituary);
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    ////round corner for skip button/////
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark
#pragma mark tableview delegates and datasource
#pragma mark

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrObituary.count;
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
    ModelFindObituary *obj=[self.arrObituary objectAtIndex:indexPath.row];
    FindObituaryCell *cell=[tableView dequeueReusableCellWithIdentifier:@"identifier"];
    if (!cell)
    {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"FindObituaryCell" owner:self options:nil]objectAtIndex:0];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [cell.imgObituaryTags sd_setImageWithURL:[NSURL URLWithString:obj.strObituaryPic]
                                     placeholderImage:[UIImage imageNamed:@"defltmale_user_icon"]
                                              options:SDWebImageHighPriority
                                             progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                                 [cell.actTagsIndicator startAnimating];
                                             }
                                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                                [cell.actTagsIndicator stopAnimating];
                                                
                                            }];
    });
    cell.lblObituaryName.text=obj.strName;
    cell.lblDate.text=obj.strDate;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view removeFromSuperview];
    ModelFindObituary *obj=[self.arrObituary objectAtIndex:indexPath.row];
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectedObituary:)])
    {
        [self.delegate selectedObituary:obj];

    }
}

#pragma  mark
#pragma mark IBACTIONS
#pragma mark

-(IBAction)btnSkipPressed:(id)sender
{
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

@end
