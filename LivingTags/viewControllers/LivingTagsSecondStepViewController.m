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
#import "CategoryCell.h"
#import "AddLogoCell.h"
#import "PreviewPopUpController.h"
#import "CustomdatePickerViewController.h"
#import <MapKit/MapKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <MediaPlayer/MPMoviePlayerController.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <CoreGraphics/CoreGraphics.h>


@interface LivingTagsSecondStepViewController ()<UITableViewDelegate,UITableViewDataSource,PreviewPopupDelegate,UITextFieldDelegate,CustomdatePickerViewControllerDelegate,MKMapViewDelegate,UITextViewDelegate,TagsCreateImageSelect,UIImagePickerControllerDelegate,UINavigationControllerDelegate,TagsCreateVideosSelect>
{
    IBOutlet UITableView *tblTagsCreation;
    NSString *strGender,*strBirthDate,*strDeathDate,*strPersonName,*strTextVwTags;////////// variables to be sent to the server
    BOOL isLiving,isLocation,isTextViewClicked;
    NSMutableArray *arrPlaceHolders;
    CustomdatePickerViewController *datePickerController ;
    NSString *strDate;//// to see if the birth date button is clicked or death date button is clicked
    
    ////// google place picker
    GMSPlacePicker *placePicker;
    GMSMapView *mapViewGoogle;
    GMSPlace *pickedPlace;
    CLLocationCoordinate2D locationUser;
    /////////
}

@end

@implementation LivingTagsSecondStepViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    appDel.arrImageSet=[[NSMutableArray alloc]init];
    appDel.arrVideoSet=[[NSMutableArray alloc]init];
    NSLog(@"%@",self.strTagName);
    tblTagsCreation.separatorStyle=UITableViewCellSeparatorStyleNone;
    tblTagsCreation.delegate=self;
    tblTagsCreation.dataSource=self;
    arrPlaceHolders=[[NSMutableArray alloc]initWithObjects:@"Business Name",@"Contact Name",@"Title",@"Business Address",@"Business Phone",@"Cell Phone",@"Fax",@"Email",@"Website", nil];
    strDate=@"";
    NSLog(@"%@",self.strToken);
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    strGender=@"";
    isLiving=NO;
    isLocation=NO;
    isTextViewClicked=NO;
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
            case 8:
                return 50.0f;

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
            case 8:
                return 50.0f;
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
                return 30.0f;
                break;
            case 2:
                return 50.0f;
                case 8:
                return 50.0f;
                break;
            default:
                return 110.0f;
                break;
        }
    }
    else
    {
        if (indexPath.row==9)
        {
            return 30.0f;
        }
        else if (indexPath.row==10)
        {
            return 60.0f;
        }
        else if (indexPath.row==11 || indexPath.row==12 || indexPath.row==13 || indexPath.row==14 || indexPath.row==15)
        {
            return 110.0f;
        }
        if (indexPath.row==16)
        {
            return 50.0f;
        }
        return 40.0f;
    }
    return 0.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.strTagName isEqualToString:@"Business"])
    {
        return 17;
    }
    return 9;
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
                cellPerson.txtPersonName.delegate=self;
                [cellPerson.txtPersonName addTarget:self action:@selector(textFieldEdited:) forControlEvents:UIControlEventEditingChanged];
                if (strPersonName.length>0)
                {
                    cellPerson.txtPersonName.text=strPersonName;
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
                    cellBirth.btnDeathDate.userInteractionEnabled=NO;
                    cellBirth.txtDeath.text=@"Death Date";
                    strDeathDate=@"";
                }
                cellBirth.txtBirth.userInteractionEnabled=NO;
                cellBirth.txtDeath.userInteractionEnabled=NO;
                cellBirth.txtBirth.text=strBirthDate;
                cellBirth.txtDeath.text=strDeathDate;
                [cellBirth.btnLiving addTarget:self action:@selector(btnLivingPressed:) forControlEvents:UIControlEventTouchUpInside];
                [cellBirth.btnBirthDate addTarget:self action:@selector(btnDeathDatePressed:) forControlEvents:UIControlEventTouchUpInside];
                [cellBirth.btnDeathDate addTarget:self action:@selector(btnBirthDatePressed:) forControlEvents:UIControlEventTouchUpInside];
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
                cellImage.delegate=self;
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
                cellVideo.delegate=self;
                cell=cellVideo;
            }
                break;
                
            case 5 :
            {
                if (isTextViewClicked==NO)
                {
                    AddVideoTagCell *cellText=[tableView dequeueReusableCellWithIdentifier:strIdentifier];
                    if (!cellText)
                    {
                        cellText=[[[NSBundle mainBundle]loadNibNamed:@"AddVideoTagCell" owner:self options:nil]objectAtIndex:0];
                    }
                    [cellText.btnTxt addTarget:self action:@selector(btnTextViewClicked:) forControlEvents:UIControlEventTouchUpInside];
                    cell=cellText;
                }
                else
                {
                    AddVideoTagCell *cellText=[tableView dequeueReusableCellWithIdentifier:strIdentifier];
                    if (!cellText)
                    {
                        cellText=[[[NSBundle mainBundle]loadNibNamed:@"AddVideoTagCell" owner:self options:nil]objectAtIndex:1];
                    }
                    cellText.txtTags.text=strTextVwTags;
                    cellText.txtTags.delegate=self;
                    [cellText.btnTextVwCross addTarget:self action:@selector(btnTextVwCrossPressed:) forControlEvents:UIControlEventTouchUpInside];
                    cell=cellText;
                }
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
                if (isLocation==0)
                {
                    AddLocationCell *cellLocation=[tableView dequeueReusableCellWithIdentifier:strIdentifier];
                    if (!cellLocation)
                    {
                        cellLocation=[[[NSBundle mainBundle]loadNibNamed:@"AddLocationCell" owner:self options:nil]objectAtIndex:0];
                    }
                    [cellLocation.btnMap addTarget:self action:@selector(btnMapPressed:) forControlEvents:UIControlEventTouchUpInside];
                    cell=cellLocation;
                }
                else
                {
                    AddLocationCell *cellLocation=[tableView dequeueReusableCellWithIdentifier:strIdentifier];
                    if (!cellLocation)
                    {
                        cellLocation=[[[NSBundle mainBundle]loadNibNamed:@"AddLocationCell" owner:self options:nil]objectAtIndex:1];
                    }
                    [cellLocation.btnCross addTarget:self action:@selector(btnMapCrossPressed:) forControlEvents:UIControlEventTouchUpInside];
                    cellLocation.mapTagLocation.delegate=self;
                    MKPointAnnotation*    annotation = [[MKPointAnnotation alloc] init];
                    annotation.coordinate = locationUser;
                    [cellLocation.mapTagLocation addAnnotation:annotation];
                    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(locationUser,9000, 900);
                    MKCoordinateRegion adjustedRegion = [cellLocation.mapTagLocation regionThatFits:viewRegion];
                    [cellLocation.mapTagLocation setRegion:adjustedRegion animated:YES];
                    cell=cellLocation;
                }
            }
                break;
                case 8:
            {
                AddLogoCell *cellButton=[tableView dequeueReusableCellWithIdentifier:strIdentifier];
                if (!cellButton)
                {
                    cellButton=[[[NSBundle mainBundle]loadNibNamed:@"AddLogoCell" owner:self options:nil]objectAtIndex:1];
                }
                [cellButton.btnNext addTarget:self action:@selector(btnNextPressed:) forControlEvents:UIControlEventTouchUpInside];
                cell=cellButton;
            }
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
                break;
            }
            case 8:
            {
                AddLogoCell *cellButton=[tableView dequeueReusableCellWithIdentifier:strIdentifier];
                if (!cellButton)
                {
                    cellButton=[[[NSBundle mainBundle]loadNibNamed:@"AddLogoCell" owner:self options:nil]objectAtIndex:1];
                }
                [cellButton.btnNext addTarget:self action:@selector(btnNextPressed:) forControlEvents:UIControlEventTouchUpInside];
                cell=cellButton;
            }
                break;
            default:
                break;
        }
    }
    else if ([self.strTagName isEqualToString:@"Place"] || [self.strTagName isEqualToString:@"Thing"] || [self.strTagName isEqualToString:@"Others"])
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
                UIColor *color = [UIColor colorWithRed:76/255.0f green:87/255.0f blue:95/255.0f alpha:1.0];
                cellPerson.txtPersonName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Title/Name" attributes:@{NSForegroundColorAttributeName: color}];

                cell=cellPerson;
            }
                break;
                
            case 1 :
            {
                CategoryCell *cellCategory=[tableView dequeueReusableCellWithIdentifier:strIdentifier];
                if (!cellCategory)
                {
                    cellCategory=[[[NSBundle mainBundle]loadNibNamed:@"CategoryCell" owner:self options:nil]objectAtIndex:0];
                }
                cell=cellCategory;
            }
                break;
                
            case 2 :
            {
                PersonNameCell *cellPerson=[tableView dequeueReusableCellWithIdentifier:strIdentifier];
                if (!cellPerson)
                {
                    cellPerson=[[[NSBundle mainBundle]loadNibNamed:@"PersonNameCell" owner:self options:nil]objectAtIndex:0];
                }
                UIColor *color = [UIColor colorWithRed:76/255.0f green:87/255.0f blue:95/255.0f alpha:1.0];
                cellPerson.txtPersonName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Contact Info" attributes:@{NSForegroundColorAttributeName: color}];

                cell=cellPerson;
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
                break;
            }
                case 8:
            {
                AddLogoCell *cellButton=[tableView dequeueReusableCellWithIdentifier:strIdentifier];
                if (!cellButton)
                {
                    cellButton=[[[NSBundle mainBundle]loadNibNamed:@"AddLogoCell" owner:self options:nil]objectAtIndex:1];
                }
                [cellButton.btnNext addTarget:self action:@selector(btnNextPressed:) forControlEvents:UIControlEventTouchUpInside];
                cell=cellButton;
            }
                break;
            default:
                break;
        }
    }
    else
    {
        if (indexPath.row<=8)
        {
            PersonNameCell *cellPerson=[tableView dequeueReusableCellWithIdentifier:strIdentifier];
            if (!cellPerson)
            {
                cellPerson=[[[NSBundle mainBundle]loadNibNamed:@"PersonNameCell" owner:self options:nil]objectAtIndex:0];
            }
            cellPerson.txtPersonName.placeholder=[arrPlaceHolders objectAtIndex:indexPath.row];
            UIColor *color = [UIColor colorWithRed:76/255.0f green:87/255.0f blue:95/255.0f alpha:1.0];
            cellPerson.txtPersonName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[arrPlaceHolders objectAtIndex:indexPath.row] attributes:@{NSForegroundColorAttributeName: color}];
            cell=cellPerson;
        }
        else if (indexPath.row==9)
        {
            CategoryCell *cellCategory=[tableView dequeueReusableCellWithIdentifier:strIdentifier];
            if (!cellCategory)
            {
                cellCategory=[[[NSBundle mainBundle]loadNibNamed:@"CategoryCell" owner:self options:nil]objectAtIndex:0];
            }
            cell=cellCategory;
        }
        else if (indexPath.row==10)
        {
            AddLogoCell *cellButton=[tableView dequeueReusableCellWithIdentifier:strIdentifier];
            if (!cellButton)
            {
                cellButton=[[[NSBundle mainBundle]loadNibNamed:@"AddLogoCell" owner:self options:nil]objectAtIndex:0];
            }
            [cellButton.btnNext addTarget:self action:@selector(btnNextPressed:) forControlEvents:UIControlEventTouchUpInside];
            cell=cellButton;

        }
        else if (indexPath.row==11)
        {
            AddImageCell *cellImage=[tableView dequeueReusableCellWithIdentifier:strIdentifier];
            if (!cellImage)
            {
                cellImage=[[[NSBundle mainBundle]loadNibNamed:@"AddImageCell" owner:self options:nil]objectAtIndex:0];
            }
            cell=cellImage;
        }
        else if (indexPath.row==12)
        {
            AddVideoCell *cellVideo=[tableView dequeueReusableCellWithIdentifier:strIdentifier];
            if (!cellVideo)
            {
                cellVideo=[[[NSBundle mainBundle]loadNibNamed:@"AddVideoCell" owner:self options:nil]objectAtIndex:0];
            }
            cell=cellVideo;

        }
        else if (indexPath.row==13)
        {
            AddVideoTagCell *cellText=[tableView dequeueReusableCellWithIdentifier:strIdentifier];
            if (!cellText)
            {
                cellText=[[[NSBundle mainBundle]loadNibNamed:@"AddVideoTagCell" owner:self options:nil]objectAtIndex:0];
            }
            cell=cellText;

        }
        else if (indexPath.row==14)
        {
            VoiceTagCell *cellVoice=[tableView dequeueReusableCellWithIdentifier:strIdentifier];
            if (!cellVoice)
            {
                cellVoice=[[[NSBundle mainBundle]loadNibNamed:@"VoiceTagCell" owner:self options:nil]objectAtIndex:0];
            }
            cell=cellVoice;

        }
        else if (indexPath.row==15)
        {
            AddLocationCell *cellLocation=[tableView dequeueReusableCellWithIdentifier:strIdentifier];
            if (!cellLocation)
            {
                cellLocation=[[[NSBundle mainBundle]loadNibNamed:@"AddLocationCell" owner:self options:nil]objectAtIndex:0];
            }
            cell=cellLocation;

        }
        else if (indexPath.row==16)
        {
            AddLogoCell *cellButton=[tableView dequeueReusableCellWithIdentifier:strIdentifier];
            if (!cellButton)
            {
                cellButton=[[[NSBundle mainBundle]loadNibNamed:@"AddLogoCell" owner:self options:nil]objectAtIndex:1];
            }
            [cellButton.btnNext addTarget:self action:@selector(btnNextPressed:) forControlEvents:UIControlEventTouchUpInside];
            cell=cellButton;
        }
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
    [self.view endEditing:YES];
    strGender=@"M";
    [tblTagsCreation beginUpdates];
    NSArray *paths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:1 inSection:0]];
    [tblTagsCreation reloadRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationFade];
    [tblTagsCreation endUpdates];

}

-(void)btnFemalePressed:(id)sender
{
    [self.view endEditing:YES];
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

-(void)btnNextPressed:(id)sender
{
    PreviewPopUpController *master=[[PreviewPopUpController alloc]initWithNibName:@"PreviewPopUpController" bundle:nil];
    master.view.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:master.view];
    [self addChildViewController:master];
    master.myDelegate=self;
    [master didMoveToParentViewController:self];
}


-(void)btnDeathDatePressed:(id)sender
{
    strDate=@"birth";
    [self datePickerOpen];
}

-(void)btnBirthDatePressed:(id)sender
{
    strDate=@"death";
    [self datePickerOpen];
}

//////************ map button***********///////////////

-(void)btnMapPressed:(id)sender
{

    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(appDel.center.latitude, appDel.center.longitude);
    CLLocationCoordinate2D northEast = CLLocationCoordinate2DMake(center.latitude + 0.001,
                                                                  center.longitude + 0.001);
    CLLocationCoordinate2D southWest = CLLocationCoordinate2DMake(center.latitude - 0.001,
                                                                  center.longitude - 0.001);
    GMSCoordinateBounds *viewport = [[GMSCoordinateBounds alloc] initWithCoordinate:northEast
                                                                         coordinate:southWest];
    GMSPlacePickerConfig *config = [[GMSPlacePickerConfig alloc] initWithViewport:viewport];
    placePicker = [[GMSPlacePicker alloc] initWithConfig:config];
    
    [placePicker pickPlaceWithCallback:^(GMSPlace *place, NSError *error) {
        if (error != nil) {
            NSLog(@"Pick Place error %@", [error localizedDescription]);
            [self displayErrorWithMessage:[error localizedDescription]];
            return;
        }
        
        if (place != nil) {
            NSLog(@"place.name:%@",place.name);
            
            [[GMSGeocoder geocoder] reverseGeocodeCoordinate:CLLocationCoordinate2DMake(place.coordinate.latitude, place.coordinate.longitude) completionHandler:^(GMSReverseGeocodeResponse* response, NSError* error)
             {
                 locationUser=CLLocationCoordinate2DMake(place.coordinate.latitude, place.coordinate.longitude);
                 isLocation=YES;
                 [tblTagsCreation beginUpdates];
                 NSArray *paths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:7 inSection:0]];
                 [tblTagsCreation reloadRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationFade];
                 [tblTagsCreation endUpdates];

                 NSLog(@"reverse geocoding results:");
                 for(GMSAddress* addressObj in [response results])
                 {
                     NSLog(@"locality=%@", addressObj.locality);
                     NSLog(@"subLocality=%@", addressObj.subLocality);
                     NSLog(@"administrativeArea=%@", addressObj.administrativeArea);
                     NSLog(@"postalCode=%@", addressObj.postalCode);
                     NSLog(@"country=%@", addressObj.country);
                     // NSLog(@"lines=%@", addressObj.lines);
                     // [self performSegueWithIdentifier:@"placeDetailsSegue" sender:self];
                     break;
                 }
             }];
            NSLog(@"place.formattedAddress:%@",place.formattedAddress);
            NSString *strCat = place.types[0];
            NSLog(@"Category:%@",strCat);
            pickedPlace = place;
        } else {
        }
    }];
}

-(void)btnMapCrossPressed:(id)sender
{
    isLocation=NO;
    [tblTagsCreation beginUpdates];
    NSArray *paths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:7 inSection:0]];
    [tblTagsCreation reloadRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationFade];
    [tblTagsCreation endUpdates];
}

-(void)btnTextViewClicked:(id)sender
{
    isTextViewClicked=YES;
    [tblTagsCreation beginUpdates];
    NSArray *paths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:5 inSection:0]];
    [tblTagsCreation reloadRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationFade];
    [tblTagsCreation endUpdates];
}

-(void)btnTextVwCrossPressed:(id)sender
{
    strTextVwTags=@"";
    [self.view endEditing:YES];
    isTextViewClicked=NO;
    [tblTagsCreation beginUpdates];
    NSArray *paths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:5 inSection:0]];
    [tblTagsCreation reloadRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationFade];
    [tblTagsCreation endUpdates];
}
#pragma mark
#pragma mark Custom delegate preview popup
#pragma mark

-(void)previewButtonPressed
{
    
}

-(void)publishButtonPressed
{
    [self performSegueWithIdentifier:@"segueQRCode" sender:self];
}

#pragma mark
#pragma mark textfield delegate methods
#pragma mark

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

-(void)textFieldEdited:(id)sender
{
    UITextField *textField=(id)sender;
    if ([self.strTagName isEqualToString:@"Persons"])
    {
        strPersonName=textField.text;
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

#pragma mark 
#pragma mark Custom Date Picker
#pragma mark

-(void)datePickerOpen
{
    [self.view endEditing:YES];
    datePickerController=[[CustomdatePickerViewController alloc] initWithNibName:@"CustomdatePickerViewController" bundle:nil Delegate:self];
    datePickerController.view.frame=[[UIScreen mainScreen] bounds];
    [self.view addSubview:datePickerController.view];
    [self addChildViewController:datePickerController];
    [datePickerController didMoveToParentViewController:self];
}

-(void)didSelectedDate:(NSDate *)selectedDate
{
    if ([strDate isEqualToString:@"birth"])
    {
        strBirthDate=[dateFormatter stringFromDate:selectedDate];
        [datePickerController.view removeFromSuperview];
        NSLog(@"%@",strBirthDate);
    }
    else
    {
        strDeathDate=[dateFormatter stringFromDate:selectedDate];
        [datePickerController.view removeFromSuperview];
        NSDate *birthDate=[dateFormatter dateFromString:strBirthDate];
        if ([birthDate compare:selectedDate]==NSOrderedDescending)
        {
            [self displayErrorWithMessage:@"Death date should be higher than birth date"];
            strDeathDate=@"";
        }
    }
    [tblTagsCreation beginUpdates];
    NSArray *paths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:2 inSection:0]];
    [tblTagsCreation reloadRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationFade];
    [tblTagsCreation endUpdates];

}

-(void)didCancel
{
    [datePickerController.view removeFromSuperview];
}

#pragma mark
#pragma mark mapview delegates and datasource
#pragma mark

/*- (void)mapViewDidFinishRenderingMap:(MKMapView *)mapView fullyRendered:(BOOL)fullyRendered
{
    if (fullyRendered)
    {
        [self hideNetworkActivity];
    }
}*/

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKAnnotationView *pinView = nil;
    if([annotation isKindOfClass:[MKPointAnnotation class]])
    {
        static NSString *defaultPinID = @"com.invasivecode.pin";
        pinView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
        if ( pinView == nil )
            pinView = [[MKAnnotationView alloc]
                       initWithAnnotation:annotation reuseIdentifier:defaultPinID];
        pinView.canShowCallout = YES;
        pinView.image = [UIImage imageNamed:@"memorial"];    //add custom image to annotation
    }
    else
    {
        [mapView.userLocation setTitle:@"I am here"];
    }
    return pinView;
}


#pragma mark
#pragma mark textview delegate
#pragma mark

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    [tblTagsCreation setContentOffset:CGPointMake(0, 300) animated:YES];
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    strTextVwTags=textView.text;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        [tblTagsCreation setContentOffset:CGPointMake(0, 0) animated:YES];
        return NO;
    }
    return YES;
}


#pragma mark
#pragma mark Add Images delegate
#pragma mark

-(void)selectImages
{
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"Do you want to take a picture or select it from gallery??" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionCamera=[UIAlertAction actionWithTitle:@"CAMERA" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self takePictureFromCamera];
        [alertController dismissViewControllerAnimated:YES completion:^{
            
        }];
    }];
    
    UIAlertAction *actionGallery=[UIAlertAction actionWithTitle:@"GALLERY" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self takePictureFromGallery];
        [alertController dismissViewControllerAnimated:YES completion:^{
            
        }];

    }];

    [alertController addAction:actionCamera];
    [alertController addAction:actionGallery];

    [self presentViewController:alertController animated:YES completion:^{
        
    }];
}

-(void)takePictureFromCamera
{
    [self imageUploadFromCamera];
}

-(void)takePictureFromGallery
{
    [self imageUploadFromGallery];
}

-(void)imageUploadFromCamera
{
    if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront]|| [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear])
    {
        UIImagePickerController *picker=[[UIImagePickerController alloc]init] ;
        picker.delegate=self ;
        picker.sourceType=UIImagePickerControllerSourceTypeCamera ;
        picker.allowsEditing=NO ;
        [self presentViewController:picker animated:YES completion:nil] ;
    }
    else
    {
        [[[UIAlertView alloc]initWithTitle:@"ERROR" message:@"Camera not found." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil]show];
    }
}

-(void)imageUploadFromGallery
{
    UIImagePickerController *picker=[[UIImagePickerController alloc] init];
    picker.delegate=self;
    picker.allowsEditing=NO;
    picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:^{
        
    }];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    BOOL isImage = UTTypeConformsTo((__bridge CFStringRef)mediaType,
                                    kUTTypeImage) != 0;
    if (isImage==YES)
    {
        UIImage *imgChosen=info[UIImagePickerControllerOriginalImage] ;
        if ([appDel.arrImageSet containsObject:@"1"])
        {
            [appDel.arrImageSet replaceObjectAtIndex:appDel.arrImageSet.count-1 withObject:imgChosen];
        }
        else
        {
            [appDel.arrImageSet addObject:imgChosen];
        }
        [appDel.arrImageSet addObject:@"1"];
        [picker dismissViewControllerAnimated:YES completion:^{
            [tblTagsCreation beginUpdates];
            NSArray *paths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:3 inSection:0]];
            [tblTagsCreation reloadRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationFade];
            [tblTagsCreation endUpdates];
            
        }] ;
    }
    else
    {
        if (picker.sourceType==UIImagePickerControllerSourceTypeCamera)
        {
            NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
            if ([mediaType isEqualToString:@"public.movie"])
            {
                // Saving the video / // Get the new unique filename
                //        NSString *sourcePath = [[info objectForKey:@"UIImagePickerControllerMediaURL"]relativePath];
                //        UISaveVideoAtPathToSavedPhotosAlbum(sourcePath,nil,nil,nil);
                NSURL *videoURL     = [info objectForKey:UIImagePickerControllerMediaURL];
                NSData *videoData = [NSData dataWithContentsOfURL:videoURL];
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                NSString *documentsDirectory = [paths objectAtIndex:0];
                NSString *tempPath = [documentsDirectory stringByAppendingFormat:@"/vid1.mp4"];
                BOOL success = [videoData writeToFile:tempPath atomically:NO];
                if (success)
                {
                    UISaveVideoAtPathToSavedPhotosAlbum(tempPath,nil,nil,nil);
                    NSLog(@"Success");
                    AVAsset *asset = [AVAsset assetWithURL:videoURL];
                    AVAssetImageGenerator *imageGenerator = [[AVAssetImageGenerator alloc]initWithAsset:asset];
                    CMTime time = CMTimeMake(1,1);
                    CGImageRef imageRef = [imageGenerator copyCGImageAtTime:time actualTime:NULL error:NULL];
                    UIImage *imgThumbnail = [UIImage imageWithCGImage:imageRef];
                    if ([appDel.arrVideoSet containsObject:@"1"])
                    {
                        [appDel.arrVideoSet replaceObjectAtIndex:appDel.arrImageSet.count-1 withObject:imgThumbnail];
                    }
                    else
                    {
                        [appDel.arrVideoSet addObject:imgThumbnail];
                    }
                    [appDel.arrVideoSet addObject:@"1"];
                    CGImageRelease(imageRef);
                }
                else
                {
                    NSLog(@"Failure");
                }
            }
        }
        else
        {
            NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
            if ([mediaType isEqualToString:@"public.movie"])
            {
                // Saving the video / // Get the new unique filename
                //NSString *sourcePath = [[info objectForKey:@"UIImagePickerControllerMediaURL"]relativePath];
                //UISaveVideoAtPathToSavedPhotosAlbum(sourcePath,nil,nil,nil);
                NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
                NSData *videoData = [NSData dataWithContentsOfURL:videoURL];
                NSLog(@"%lu",(unsigned long)videoData.length);
                AVAsset *asset = [AVAsset assetWithURL:videoURL];
                AVAssetImageGenerator *imageGenerator = [[AVAssetImageGenerator alloc]initWithAsset:asset];
                CMTime time = CMTimeMake(1, 1);
                CGImageRef imageRef = [imageGenerator copyCGImageAtTime:time actualTime:NULL error:NULL];
                UIImage *imgThumbnail = [UIImage imageWithCGImage:imageRef];
                if ([appDel.arrVideoSet containsObject:@"1"])
                {
                    [appDel.arrVideoSet replaceObjectAtIndex:appDel.arrImageSet.count-1 withObject:imgThumbnail];
                }
                else
                {
                    [appDel.arrVideoSet addObject:imgThumbnail];
                }
                [appDel.arrVideoSet addObject:@"1"];
                CGImageRelease(imageRef);
            }
        }
        [picker dismissViewControllerAnimated:YES completion:^{
            [tblTagsCreation beginUpdates];
            NSArray *paths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:4 inSection:0]];
            [tblTagsCreation reloadRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationFade];
            [tblTagsCreation endUpdates];

        }];

    }
}

-(void)deleteImagesFromIndex:(NSInteger)i
{
    [appDel.arrImageSet removeObjectAtIndex:i];
    [tblTagsCreation beginUpdates];
    NSArray *paths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:3 inSection:0]];
    [tblTagsCreation reloadRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationFade];
    [tblTagsCreation endUpdates];
}

#pragma mark
#pragma mark Image Picker Videos Delegate
#pragma mark

-(void)selectVideos
{
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"Do you want to shoot a video or select it from gallery??" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionCamera=[UIAlertAction actionWithTitle:@"CAMERA" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self imageUploadFromCamera];
        [alertController dismissViewControllerAnimated:YES completion:^{
            
        }];
    }];
    
    UIAlertAction *actionGallery=[UIAlertAction actionWithTitle:@"GALLERY" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self takeVideoFromGallery];
        [alertController dismissViewControllerAnimated:YES completion:^{
            
        }];
        
    }];
    
    [alertController addAction:actionCamera];
    [alertController addAction:actionGallery];
    
    [self presentViewController:alertController animated:YES completion:^{
        
    }];
}

-(void)takeVideoFromCamera
{
    [self videoUploadFromCamera];
}

-(void)takeVideoFromGallery
{
    [self videoUploadFromGallery];
}

-(void)videoUploadFromCamera
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
        [self presentViewController:picker animated:YES completion:NULL];
    }
    else
    {
        [[[UIAlertView alloc]initWithTitle:@"No camera available" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK ", nil] show];
    }
}

-(void)videoUploadFromGallery
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
    picker.videoMaximumDuration=300;
    [self presentViewController:picker animated:YES completion:NULL];
}


-(void)deleteVideosFromIndex:(NSInteger)i
{
    [appDel.arrVideoSet removeObjectAtIndex:i];
    [tblTagsCreation beginUpdates];
    NSArray *paths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:4 inSection:0]];
    [tblTagsCreation reloadRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationFade];
    [tblTagsCreation endUpdates];
}
@end
