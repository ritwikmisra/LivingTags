//
//  LivingTagsThirdStepViewController.m
//  LivingTags
//
//  Created by appsbeetech on 25/07/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "LivingTagsThirdStepViewController.h"
#import "CreateTagsThirdStepCell.h"
#import "CreateTagsCell.h"

@interface LivingTagsThirdStepViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UILabel *lbl1;
    IBOutlet UILabel *lbl2;
    IBOutlet UILabel *lbl3;
    IBOutlet UILabel *lbl4;
    IBOutlet UITableView *tblAThirdStep;
}

@end

@implementation LivingTagsThirdStepViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    tblAThirdStep.separatorStyle=UITableViewCellSeparatorStyleNone;
    [tblAThirdStep setBounces:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)viewWillLayoutSubviews
{
    lbl3.layer.cornerRadius=lbl3.frame.size.width/2;
    lbl3.clipsToBounds=YES;
    
    lbl1.layer.cornerRadius=lbl3.frame.size.width/2;
    lbl1.clipsToBounds=YES;
    
    lbl4.layer.cornerRadius=lbl4.frame.size.width/2;
    lbl4.clipsToBounds=YES;
    
    lbl2.layer.cornerRadius=lbl3.frame.size.width/2;
    lbl2.clipsToBounds=YES;
}

#pragma mark
#pragma mark Tableview datasouce and delegate
#pragma mark

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case 0:
            return 180.0f;
            break;
        
        default:
            return 70.0f;
            break;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CreateTagsThirdStepCell *cellTags=[tableView dequeueReusableCellWithIdentifier:@"identifier"];
    switch (indexPath.row)
    {
        case 0:
            if (!cellTags)
            {
                cellTags=[[[NSBundle mainBundle]loadNibNamed:@"CreateTagsThirdStepCell" owner:self options:nil] objectAtIndex:indexPath.row];
            }
            [cellTags.btnBrowse addTarget:self action:@selector(btnUserBrowsePicClicked:) forControlEvents:UIControlEventTouchUpInside];
            break;
            
        case 1:
            if (!cellTags)
            {
                cellTags=[[[NSBundle mainBundle]loadNibNamed:@"CreateTagsThirdStepCell" owner:self options:nil] objectAtIndex:indexPath.row];
            }
            [cellTags.btnCalender addTarget:self action:@selector(btnCalenderPressed:) forControlEvents:UIControlEventTouchUpInside];
            break;
            
        case 2:
            if (!cellTags)
            {
                cellTags=[[[NSBundle mainBundle]loadNibNamed:@"CreateTagsThirdStepCell" owner:self options:nil] objectAtIndex:indexPath.row];
            }
            [cellTags.btnRecording addTarget:self action:@selector(btnRecordingPressed:) forControlEvents:UIControlEventTouchUpInside];
            break;
            
        case 3:
            if (!cellTags)
            {
                cellTags=[[[NSBundle mainBundle]loadNibNamed:@"CreateTagsThirdStepCell" owner:self options:nil] objectAtIndex:indexPath.row];
            }
            [cellTags.btnMorePicNo addTarget:self action:@selector(btnNoPressed:) forControlEvents:UIControlEventTouchUpInside];
            [cellTags.btnMorePicYes addTarget:self action:@selector(btnYesPressed:) forControlEvents:UIControlEventTouchUpInside];

            break;

        default:
            break;
    }
    cellTags.backgroundColor=[UIColor clearColor];
    cellTags.selectionStyle=UITableViewCellSelectionStyleNone;
    return cellTags;
}

#pragma mark
#pragma mark IBACITONS
#pragma mark

-(void)btnUserBrowsePicClicked:(id)sender
{
    NSLog(@"Pressed");
}

-(void)btnCalenderPressed:(id)sender
{
    NSLog(@"Pressed");
}

-(void)btnRecordingPressed:(id)sender
{
    NSLog(@"Pressed");
}

-(void)btnNoPressed:(id)sender
{
    NSLog(@"Pressed");
}

-(void)btnYesPressed:(id)sender
{
    NSLog(@"Pressed");
}

@end
