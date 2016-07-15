//
//  LivingTagsSecondStepViewController.m
//  LivingTags
//
//  Created by appsbeetech on 12/07/16.
//  Copyright © 2016 appsbeetech. All rights reserved.

#import "LivingTagsSecondStepViewController.h"
#import "CreateTagsSecondStepCell.h"

@interface LivingTagsSecondStepViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UITextViewDelegate>
{
    IBOutlet UILabel *lbl1;
    IBOutlet UILabel *lbl2;
    IBOutlet UILabel *lbl3;
    IBOutlet UITableView *tblSecondSteps;
    NSMutableArray *arrStatus;
    NSString *strGender;
}

@end

@implementation LivingTagsSecondStepViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //arrStatus=[[NSMutableArray alloc]initWithObjects:@"0",@"0",@"0",@"0",@"0",@"0",@"0", nil];
    arrStatus=[[NSMutableArray alloc]initWithObjects:@"0", nil];
    strGender=@"";
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
    
    lbl2.layer.cornerRadius=lbl3.frame.size.width/2;
    lbl2.clipsToBounds=YES;
}

#pragma mark
#pragma mark tableview datasource and delegate methods
#pragma mark

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrStatus.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*if (___isIphone4_4s)
     {
     if (indexPath.row==2)
     {
     return 100.0f;
     }
     else if (indexPath.row==5)
     {
     return 110.0f;
     }
     else if (indexPath.row==6)
     {
     return 105.0f;
     }
     return 70.0f;
     }
     else if (___isIphone5_5s)
     {
     
     }
     else if(___isIphone6)
     {
     
     }
     else
     {
     
     }
     return 70.0f;*/
    if (indexPath.row==2)
    {
        return 160.0f;
    }
    else if (indexPath.row==3)
    {
        return 60.0f;
    }
    else if (indexPath.row==5)
    {
        return 150.0f;
    }
    else if (indexPath.row==6)
    {
        return 105.0f;
    }
    return 70.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=nil;
    CreateTagsSecondStepCell *cellTags=[tableView dequeueReusableCellWithIdentifier:@"identifier"];
    switch (indexPath.row)
    {
        case 0:
            if (!cellTags)
            {
                cellTags=[[[NSBundle mainBundle]loadNibNamed:@"CreateTagsSecondStepCell" owner:self options:nil]objectAtIndex:0];
            }
            cellTags.txtName.delegate=self;
            cellTags.txtName.tag=indexPath.row;
            break;
        case 1:
            if (!cellTags)
            {
                cellTags=[[[NSBundle mainBundle]loadNibNamed:@"CreateTagsSecondStepCell" owner:self options:nil]objectAtIndex:1];
            }
            cellTags.btnMale.tag=indexPath.row;
            cellTags.btnFemale.tag=indexPath.row;
            [cellTags.btnMale addTarget:self action:@selector(btnMalePressed:) forControlEvents:UIControlEventTouchUpInside];
            [cellTags.btnFemale addTarget:self action:@selector(btnFemalePressed:) forControlEvents:UIControlEventTouchUpInside];
            if ([strGender isEqualToString:@""])
            {
                [cellTags.imgMale setImage:[UIImage imageNamed:@"radio_btn1"]];
                [cellTags.imgMale setImage:[UIImage imageNamed:@"radio_btn1"]];
            }
            else if ([strGender isEqualToString:@"M"])
            {
                [cellTags.imgFemale setImage:[UIImage imageNamed:@"radio_btn1"]];
                [cellTags.imgMale setImage:[UIImage imageNamed:@"radio_btn2"]];
            }
            else
            {
                [cellTags.imgFemale setImage:[UIImage imageNamed:@"radio_btn2"]];
                [cellTags.imgMale setImage:[UIImage imageNamed:@"radio_btn1"]];
            }
            break;
            
        case 2:
            if (!cellTags)
            {
                cellTags=[[[NSBundle mainBundle]loadNibNamed:@"CreateTagsSecondStepCell" owner:self options:nil]objectAtIndex:2];
            }
            cellTags.btnBrowseUserPic.tag=indexPath.row;
            [cellTags.btnBrowseUserPic addTarget:self action:@selector(btnUserPicSelected:) forControlEvents:UIControlEventTouchUpInside];
            
            break;
            
        case 3:
            if (!cellTags)
            {
                cellTags=[[[NSBundle mainBundle]loadNibNamed:@"CreateTagsSecondStepCell" owner:self options:nil]objectAtIndex:3];
            }
            cellTags.txtDateFrom.tag=indexPath.row;
            cellTags.txtDateTo.tag=9999;
            cellTags.txtDateFrom.delegate=self;
            cellTags.txtDateTo.delegate=self;
            
            break;
            
        case 4:
            if (!cellTags)
            {
                cellTags=[[[NSBundle mainBundle]loadNibNamed:@"CreateTagsSecondStepCell" owner:self options:nil]objectAtIndex:4];
            }
            cellTags.btnGetLocation.tag=indexPath.row;
            [cellTags.btnGetLocation addTarget:self action:@selector(btnGetLocationClicked:) forControlEvents:UIControlEventTouchUpInside];
            break;
            
        case 5:
            if (!cellTags)
            {
                cellTags=[[[NSBundle mainBundle]loadNibNamed:@"CreateTagsSecondStepCell" owner:self options:nil]objectAtIndex:5];
            }
            cellTags.btnBrowseCover.tag=indexPath.row;
            [cellTags.btnBrowseCover addTarget:self action:@selector(btnCoverPicPressed:) forControlEvents:UIControlEventTouchUpInside];
            break;
            
        case 6:
            if (!cellTags)
            {
                cellTags=[[[NSBundle mainBundle]loadNibNamed:@"CreateTagsSecondStepCell" owner:self options:nil]objectAtIndex:6];
            }
            cellTags.txtVwMemorialQuote.delegate=self;
            cellTags.txtVwMemorialQuote.tag=indexPath.row;
            break;
            
        default:
            break;
    }
    cell=cellTags;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor clearColor];
    return cell;
}

#pragma mark
#pragma mark textfield delegates
#pragma mark


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField.tag ==3)
    {
        [self setTableviewContentOffsetWithView:@"textfield"];

    }
   else
   {
        [self updateTableView:textField.tag];
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.tag ==3 || textField.tag==9999)
    {
        [self updateTableView:3];
    }
    [textField resignFirstResponder];
    return YES;
}

#pragma mark
#pragma mark tableview updates
#pragma mark

-(void)updateTableView:(NSInteger)i
{
    NSLog(@"%ld",(long)i);
    NSLog(@"%lu",(unsigned long)arrStatus.count);
    if (arrStatus.count<7)
    {
        if (arrStatus.count==i+1)
        {
            [arrStatus addObject:@"1"];
            [tblSecondSteps beginUpdates];
            NSArray *paths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:[arrStatus count]-1 inSection:0]];
            [tblSecondSteps insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationFade];
            [tblSecondSteps endUpdates];
        }
        else
        {
            NSLog(@"Wrong Position");
        }
    }
    else
    {
        NSLog(@"PAGE LOADED FULL");
    }
}

#pragma mark
#pragma mark IBACTIONS
#pragma mark

-(void)btnMalePressed:(id)sender
{
    [self.view endEditing:YES];
    strGender=@"M";
    CreateTagsSecondStepCell *cell=(CreateTagsSecondStepCell *)[self getSuperviewOfType:[UITableViewCell class] fromView:sender];
    [cell.imgMale setImage:[UIImage imageNamed:@"radio_btn2"]];
    [cell.imgFemale setImage:[UIImage imageNamed:@"radio_btn1"]];
    [self updateTableView:[sender tag]];
}

-(void)btnFemalePressed:(id)sender
{
    [self.view endEditing:YES];
    strGender=@"F";
    CreateTagsSecondStepCell *cell=(CreateTagsSecondStepCell *)[self getSuperviewOfType:[UITableViewCell class] fromView:sender];
    [cell.imgMale setImage:[UIImage imageNamed:@"radio_btn1"]];
    [cell.imgFemale setImage:[UIImage imageNamed:@"radio_btn2"]];
    [self updateTableView:[sender tag]];
}

-(void)btnUserPicSelected:(id)sender
{
    [self updateTableView:[sender tag]];
}

-(void)btnGetLocationClicked:(id)sender
{
    [self updateTableView:[sender tag]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self setTableviewContentOffsetWithView:@"coverPic"];
    });
}

-(void)btnCoverPicPressed:(id)sender
{
    [self updateTableView:[sender tag]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self setTableviewContentOffsetWithView:@"coverPic"];
});
}

#pragma mark
#pragma mark textview delegate
#pragma mark

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    [self setTableviewContentOffsetWithView:@"textView"];
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    [tblSecondSteps setContentOffset:CGPointMake(0, 300) animated:YES];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

#pragma mark
#pragma mark Set tableview Content offset
#pragma mark

-(void)setTableviewContentOffsetWithView:(NSString *)strView
{
    if ([strView isEqualToString:@"textView"])
    {
        [tblSecondSteps setContentOffset:CGPointMake(0, 500) animated:YES];
    }
    else if ([strView isEqualToString:@"coverPic"])
    {
        [tblSecondSteps setContentOffset:CGPointMake(0, 300) animated:YES];
    }
    else
    {
        [tblSecondSteps setContentOffset:CGPointMake(0, 200) animated:YES];
    }
}
@end
