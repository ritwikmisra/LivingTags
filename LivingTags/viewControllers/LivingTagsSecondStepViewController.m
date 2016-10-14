//
//  LivingTagsSecondStepViewController.m
//  LivingTags
//
//  Created by appsbeetech on 12/07/16.
//  Copyright © 2016 appsbeetech. All rights reserved.

#import "LivingTagsSecondStepViewController.h"
#import "PersonNameCell.h"
#import "PersonGenderCell.h"
#import "BirthDeathDateCell.h"
#import "AddImageCell.h"
#import "AddVideoCell.h"
#import "AddVideoTagCell.h"
#import "VoiceTagCell.h"
#import "AddLocationCell.h"

@interface LivingTagsSecondStepViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    IBOutlet UITableView *tblTagsCreation;
    NSString *strGender;
    BOOL isLiving;
}

@end

@implementation LivingTagsSecondStepViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"%@",self.strTagName);
    tblTagsCreation.separatorStyle=UITableViewCellSeparatorStyleNone;
    tblTagsCreation.delegate=self;
    tblTagsCreation.dataSource=self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    strGender=@"";
    isLiving=NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark
#pragma mark tableview delegates and datasource
#pragma mark

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.strTagName isEqualToString:@"Persons"])
    {
        switch (indexPath.row)
        {
            case 0:
                return 40.0f;
                break;
            case 1:
                return 40.0f;
                break;
            case 2:
                return 95.0f;
                break;
            default:
                return 110.0f;
                break;
        }

    }
    else if ([self.strTagName isEqualToString:@"Pet"])
    {
        switch (indexPath.row)
        {
            case 0:
                return 40.0f;
                break;
            case 1:
                return 40.0f;
                break;
            case 2:
                return 40.0f;
                break;
            default:
                return 110.0f;
                break;
        }
    }
    else if ([self.strTagName isEqualToString:@"Place"] || [self.strTagName isEqualToString:@"Thing"] || [self.strTagName isEqualToString:@"Others"])
    {
        switch (indexPath.row)
        {
            case 0:
                return 40.0f;
                break;
            case 1:
                return 40.0f;
                break;
            case 2:
                return 40.0f;
                break;
            default:
                return 110.0f;
                break;
        }
    }
    return 0.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *strIdentifier=@"tableviewCell";
    UITableViewCell *cell=nil;
    if ([self.strTagName isEqualToString:@"Persons"])
    {
        switch (indexPath.row)
        {
            case 0 :
            {
                PersonNameCell *cellPerson=[tableView dequeueReusableCellWithIdentifier:strIdentifier];
                if (!cellPerson)
                {
                    cellPerson=[[[NSBundle mainBundle]loadNibNamed:@"PersonNameCell" owner:self options:nil]objectAtIndex:0];
                }
                cell=cellPerson;
            }
                break;
                
            case 1 :
            {
                PersonGenderCell *cellGender=[tableView dequeueReusableCellWithIdentifier:strIdentifier];
                if (!cellGender)
                {
                    cellGender=[[[NSBundle mainBundle]loadNibNamed:@"PersonGenderCell" owner:self options:nil]objectAtIndex:0];
                }
                cell=cellGender;
                if (strGender.length==0)
                {
                    cellGender.imgMale.image=[UIImage imageNamed:@"radio_off"];
                    cellGender.imgFemale.image=[UIImage imageNamed:@"radio_off"];
                }
                else if ([strGender isEqualToString:@"M"])
                {
                    cellGender.imgMale.image=[UIImage imageNamed:@"radio_on"];
                    cellGender.imgFemale.image=[UIImage imageNamed:@"radio_off"];
                }
                else
                {
                    cellGender.imgFemale.image=[UIImage imageNamed:@"radio_on"];
                    cellGender.imgMale.image=[UIImage imageNamed:@"radio_off"];
                    
                }
                [cellGender.btnMale addTarget:self action:@selector(btnMalePressed:) forControlEvents:UIControlEventTouchUpInside];
                [cellGender.btnFemale addTarget:self action:@selector(btnFemalePressed:) forControlEvents:UIControlEventTouchUpInside];
                
            }
                
                break;
                
            case 2 :
            {
                BirthDeathDateCell *cellBirth=[tableView dequeueReusableCellWithIdentifier:strIdentifier];
                if (!cellBirth)
                {
                    cellBirth=[[[NSBundle mainBundle]loadNibNamed:@"BirthDeathDateCell" owner:self options:nil]objectAtIndex:0];
                }
                if (isLiving==NO)
                {
                    cellBirth.imgLiving.image=[UIImage imageNamed:@"living_button_off"];
                }
                else
                {
                    cellBirth.imgLiving.image=[UIImage imageNamed:@"living_button"];
                    
                }
                [cellBirth.btnLiving addTarget:self action:@selector(btnLivingPressed:) forControlEvents:UIControlEventTouchUpInside];
                cell=cellBirth;
            }
                
                break;
                
            case 3 :
                
            {
                AddImageCell *cellImage=[tableView dequeueReusableCellWithIdentifier:strIdentifier];
                if (!cellImage)
                {
                    cellImage=[[[NSBundle mainBundle]loadNibNamed:@"AddImageCell" owner:self options:nil]objectAtIndex:0];
                }
                cell=cellImage;
            }
                break;
                
            case 4 :
            {
                AddVideoCell *cellVideo=[tableView dequeueReusableCellWithIdentifier:strIdentifier];
                if (!cellVideo)
                {
                    cellVideo=[[[NSBundle mainBundle]loadNibNamed:@"AddVideoCell" owner:self options:nil]objectAtIndex:0];
                }
                cell=cellVideo;
            }
                break;
                
            case 5 :
            {
                AddVideoTagCell *cellText=[tableView dequeueReusableCellWithIdentifier:strIdentifier];
                if (!cellText)
                {
                    cellText=[[[NSBundle mainBundle]loadNibNamed:@"AddVideoTagCell" owner:self options:nil]objectAtIndex:0];
                }
                cell=cellText;
            }
                break;
                
            case 6 :
            {
                VoiceTagCell *cellVoice=[tableView dequeueReusableCellWithIdentifier:strIdentifier];
                if (!cellVoice)
                {
                    cellVoice=[[[NSBundle mainBundle]loadNibNamed:@"VoiceTagCell" owner:self options:nil]objectAtIndex:0];
                }
                cell=cellVoice;
            }
                break;
                
            case 7 :
            {
                AddLocationCell *cellLocation=[tableView dequeueReusableCellWithIdentifier:strIdentifier];
                if (!cellLocation)
                {
                    cellLocation=[[[NSBundle mainBundle]loadNibNamed:@"AddLocationCell" owner:self options:nil]objectAtIndex:0];
                }
                cell=cellLocation;
            }
                break;
            default:
                break;
        }
    }
    else if ([self.strTagName isEqualToString:@"Pet"])
    {
        switch (indexPath.row)
        {
            case 0 :
            {
                PersonNameCell *cellPerson=[tableView dequeueReusableCellWithIdentifier:strIdentifier];
                if (!cellPerson)
                {
                    cellPerson=[[[NSBundle mainBundle]loadNibNamed:@"PersonNameCell" owner:self options:nil]objectAtIndex:0];
                }
                cell=cellPerson;
            }
                break;
                
            case 1 :
            {
                PersonGenderCell *cellGender=[tableView dequeueReusableCellWithIdentifier:strIdentifier];
                if (!cellGender)
                {
                    cellGender=[[[NSBundle mainBundle]loadNibNamed:@"PersonGenderCell" owner:self options:nil]objectAtIndex:0];
                }
                cell=cellGender;
                if (strGender.length==0)
                {
                    cellGender.imgMale.image=[UIImage imageNamed:@"radio_off"];
                    cellGender.imgFemale.image=[UIImage imageNamed:@"radio_off"];
                }
                else if ([strGender isEqualToString:@"M"])
                {
                    cellGender.imgMale.image=[UIImage imageNamed:@"radio_on"];
                    cellGender.imgFemale.image=[UIImage imageNamed:@"radio_off"];
                }
                else
                {
                    cellGender.imgFemale.image=[UIImage imageNamed:@"radio_on"];
                    cellGender.imgMale.image=[UIImage imageNamed:@"radio_off"];
                    
                }
                [cellGender.btnMale addTarget:self action:@selector(btnMalePressed:) forControlEvents:UIControlEventTouchUpInside];
                [cellGender.btnFemale addTarget:self action:@selector(btnFemalePressed:) forControlEvents:UIControlEventTouchUpInside];
                
            }
                
                break;
                
            case 2 :
            {
                BirthDeathDateCell *cellBirth=[tableView dequeueReusableCellWithIdentifier:strIdentifier];
                if (!cellBirth)
                {
                    cellBirth=[[[NSBundle mainBundle]loadNibNamed:@"BirthDeathDateCell" owner:self options:nil]objectAtIndex:1];
                }
                if (isLiving==NO)
                {
                    cellBirth.imgLiving.image=[UIImage imageNamed:@"living_button_off"];
                }
                else
                {
                    cellBirth.imgLiving.image=[UIImage imageNamed:@"living_button"];
                    
                }
                [cellBirth.btnLiving addTarget:self action:@selector(btnLivingPressed:) forControlEvents:UIControlEventTouchUpInside];
                cell=cellBirth;
            }
                
                break;
                
            case 3 :
                
            {
                AddImageCell *cellImage=[tableView dequeueReusableCellWithIdentifier:strIdentifier];
                if (!cellImage)
                {
                    cellImage=[[[NSBundle mainBundle]loadNibNamed:@"AddImageCell" owner:self options:nil]objectAtIndex:0];
                }
                cell=cellImage;
            }
                break;
                
            case 4 :
            {
                AddVideoCell *cellVideo=[tableView dequeueReusableCellWithIdentifier:strIdentifier];
                if (!cellVideo)
                {
                    cellVideo=[[[NSBundle mainBundle]loadNibNamed:@"AddVideoCell" owner:self options:nil]objectAtIndex:0];
                }
                cell=cellVideo;
            }
                break;
                
            case 5 :
            {
                AddVideoTagCell *cellText=[tableView dequeueReusableCellWithIdentifier:strIdentifier];
                if (!cellText)
                {
                    cellText=[[[NSBundle mainBundle]loadNibNamed:@"AddVideoTagCell" owner:self options:nil]objectAtIndex:0];
                }
                cell=cellText;
            }
                break;
                
            case 6 :
            {
                VoiceTagCell *cellVoice=[tableView dequeueReusableCellWithIdentifier:strIdentifier];
                if (!cellVoice)
                {
                    cellVoice=[[[NSBundle mainBundle]loadNibNamed:@"VoiceTagCell" owner:self options:nil]objectAtIndex:0];
                }
                cell=cellVoice;
            }
                break;
                
            case 7 :
            {
                AddLocationCell *cellLocation=[tableView dequeueReusableCellWithIdentifier:strIdentifier];
                if (!cellLocation)
                {
                    cellLocation=[[[NSBundle mainBundle]loadNibNamed:@"AddLocationCell" owner:self options:nil]objectAtIndex:0];
                }
                cell=cellLocation;
            }
                break;
            default:
                break;
        }
    }
    else if ([self.strTagName isEqualToString:@"Place"] || [self.strTagName isEqualToString:@"Thing"] || [self.strTagName isEqualToString:@"Others"])
    {
        
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor clearColor];
    return cell;
}

#pragma mark
#pragma mark IBACTIONS
#pragma mark

-(void)btnMalePressed:(id)sender
{
    strGender=@"M";
    [tblTagsCreation beginUpdates];
    NSArray *paths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:1 inSection:0]];
    [tblTagsCreation reloadRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationFade];
    [tblTagsCreation endUpdates];

}

-(void)btnFemalePressed:(id)sender
{
    strGender=@"F";
    [tblTagsCreation beginUpdates];
    NSArray *paths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:1 inSection:0]];
    [tblTagsCreation reloadRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationFade];
    [tblTagsCreation endUpdates];
}

-(void)btnLivingPressed:(id)sender
{
    if (isLiving)
    {
        isLiving=NO;
    }
    else
    {
        isLiving=YES;
    }
    [tblTagsCreation beginUpdates];
    NSArray *paths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:2 inSection:0]];
    [tblTagsCreation reloadRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationFade];
    [tblTagsCreation endUpdates];
}
@end
