

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
#import "ModelCreateTagsSecondStep.h"
#import "LivingTagsSecondStepService.h"
#import "CLCloudinary.h"
#import "CLUploader.h"
#import "CloudinaryImageUploadService.h"
#import "DeleteAssetService.h"
#import "RecordViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "PublishTagService.h"
#import "QRCodeScanViewController.h"
#import "PreviewAdService.h"
#import "ContactsPopupController.h"
#import "CategoryService.h"
#import "CategoryController.h"
#import"PreviewViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface LivingTagsSecondStepViewController ()<UITableViewDelegate,UITableViewDataSource,PreviewPopupDelegate,UITextFieldDelegate,CustomdatePickerViewControllerDelegate,MKMapViewDelegate,TagsCreateImageSelect,UIImagePickerControllerDelegate,UINavigationControllerDelegate,TagsCreateVideosSelect,CLUploaderDelegate,AVAudioPlayerDelegate,UIScrollViewDelegate,CallContactsServiceDelegate,SelectCategoryProtocol,UITextViewDelegate>
{
    IBOutlet UITableView *tblTagsCreation;
    NSString *strGender,*strBirthDate,*strDeathDate,*strPersonName,*strTextVwTags,*strPlace,*strContact,*strBusinessName,*strBusinessContactName,*strBusinessTitle,*strBusinessAddress,*strBusinessPhone,*strBusinessCellPhone,*strBusinessFax,*strBusinessEmail,*strBusinessWebsite,*strCategory;////////// variables to be sent to the server
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
    
    //// model tag creation
    ModelCreateTagsSecondStep *objTemplates;
    
    ////dictionary for update to server
    NSMutableDictionary *dictAPI;
    
    // cloudinary instance
    CLCloudinary *cloudinary;
    
    
    AVAudioPlayer *player;
    VoiceTagCell *cellVoiceRecord;
    NSTimer *timer;
    
    /////dictionary segue for QR codes
    NSMutableDictionary *dictQRCode;
    
    ///delete image array
    NSMutableArray *arrDeleteImages,*arrDeleteVideos;
    
    
    ////////contact info view controller
    ContactsPopupController *master;
    NSString *strURL;
    BOOL isBusinessLogo;
}

@end

@implementation LivingTagsSecondStepViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    appDel.arrImageSet=[[NSMutableArray alloc]init];
    appDel.arrVideoSet=[[NSMutableArray alloc]init];
    dictAPI=[[NSMutableDictionary alloc]init];
    arrDeleteImages=[[NSMutableArray alloc]init];
    arrDeleteVideos=[[NSMutableArray alloc]init];
    NSLog(@"%@",self.strTagName);
    tblTagsCreation.separatorStyle=UITableViewCellSeparatorStyleNone;
    tblTagsCreation.delegate=self;
    tblTagsCreation.dataSource=self;
    arrPlaceHolders=[[NSMutableArray alloc]initWithObjects:@"Business Name",@"Contact Name",@"Title",@"Business Address",@"Business Phone",@"Cell Phone",@"Fax",@"Email",@"Website", nil];
    strDate=@"";
    strCategory=@"Category";
    cloudinary = [[CLCloudinary alloc] init];
    [cloudinary.config setValue:@"dw2w2nb2e" forKey:@"cloud_name"];
    [cloudinary.config setValue:@"963284535365757" forKey:@"api_key"];
    [cloudinary.config setValue:@"m7Op_O9CtqVTUOVkdbDdfA4u_6o" forKey:@"api_secret"];
    strGender=@"";
    isLiving=NO;
    isLocation=NO;
    isBusinessLogo=NO;
    isTextViewClicked=NO;
    strPlace=@"";
    
    [[AVAudioSession sharedInstance] setCategory:
     AVAudioSessionCategoryPlayAndRecord error:NULL];
    UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker;
    AudioSessionSetProperty(kAudioSessionProperty_OverrideAudioRoute,
                            sizeof(audioRouteOverride), &audioRouteOverride);

    NSDictionary *recordSetting2 = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [NSNumber numberWithInt:kAudioFormatMPEG4AAC], AVFormatIDKey,
                                    [NSNumber numberWithInt:AVAudioQualityMin], AVEncoderAudioQualityKey,
                                    [NSNumber numberWithInt: 1], AVNumberOfChannelsKey,
                                    [NSNumber numberWithFloat:8000.0], AVSampleRateKey,
                                    nil];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [tblTagsCreation reloadData];
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
    if ([self.strTagName isEqualToString:@"Person"])
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
    else if ([self.strTagName isEqualToString:@"Place"] || [self.strTagName isEqualToString:@"Thing"] || [self.strTagName isEqualToString:@"Other"])
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
    if ([self.strTagName isEqualToString:@"Person"])
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
                cellPerson.txtPersonName.autocapitalizationType=UITextAutocapitalizationTypeWords;
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
                if (appDel.strAudioURL.length>0)
                {
                    VoiceTagCell *cellVoice=[tableView dequeueReusableCellWithIdentifier:strIdentifier];
                    if (!cellVoice)
                    {
                        cellVoice=[[[NSBundle mainBundle]loadNibNamed:@"VoiceTagCell" owner:self options:nil]objectAtIndex:1];
                    }
                    cellVoice.sliderRecorder.minimumValue=0.0f;
                    cellVoice.sliderRecorder.maximumValue=appDel.audioLength;
                    [cellVoice.sliderRecorder setMinimumValue:0.0f];
                    [cellVoice.btnRecordPlay addTarget:self action:@selector(btnPlayPressed:) forControlEvents:UIControlEventTouchUpInside];
                    [cellVoice.sliderRecorder addTarget:self action:@selector(updateSlider) forControlEvents:UIControlEventValueChanged];
                    [cellVoice.btnClose addTarget:self action:@selector(btnDeleteVoicePressed:) forControlEvents:UIControlEventTouchUpInside];
                    cell=cellVoice;
                }
                else
                {
                    VoiceTagCell *cellVoice=[tableView dequeueReusableCellWithIdentifier:strIdentifier];
                    if (!cellVoice)
                    {
                        cellVoice=[[[NSBundle mainBundle]loadNibNamed:@"VoiceTagCell" owner:self options:nil]objectAtIndex:0];
                    }
                    [cellVoice.btnVoice addTarget:self action:@selector(btnVoicePressed:) forControlEvents:UIControlEventTouchUpInside];
                    cell=cellVoice;
                }
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
                cellPerson.txtPersonName.delegate=self;
                cellPerson.txtPersonName.placeholder=@"Pet Name";
                cellPerson.txtPersonName.autocapitalizationType=UITextAutocapitalizationTypeWords;
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
                    cellBirth=[[[NSBundle mainBundle]loadNibNamed:@"BirthDeathDateCell" owner:self options:nil]objectAtIndex:1];
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
                if (appDel.strAudioURL.length>0)
                {
                    VoiceTagCell *cellVoice=[tableView dequeueReusableCellWithIdentifier:strIdentifier];
                    if (!cellVoice)
                    {
                        cellVoice=[[[NSBundle mainBundle]loadNibNamed:@"VoiceTagCell" owner:self options:nil]objectAtIndex:1];
                    }
                    cellVoice.sliderRecorder.minimumValue=0.0f;
                    cellVoice.sliderRecorder.maximumValue=appDel.audioLength;
                    [cellVoice.sliderRecorder setMinimumValue:0.0f];
                    [cellVoice.btnRecordPlay addTarget:self action:@selector(btnPlayPressed:) forControlEvents:UIControlEventTouchUpInside];
                    [cellVoice.sliderRecorder addTarget:self action:@selector(updateSlider) forControlEvents:UIControlEventValueChanged];
                    [cellVoice.btnClose addTarget:self action:@selector(btnDeleteVoicePressed:) forControlEvents:UIControlEventTouchUpInside];
                    cell=cellVoice;
                }
                else
                {
                    VoiceTagCell *cellVoice=[tableView dequeueReusableCellWithIdentifier:strIdentifier];
                    if (!cellVoice)
                    {
                        cellVoice=[[[NSBundle mainBundle]loadNibNamed:@"VoiceTagCell" owner:self options:nil]objectAtIndex:0];
                    }
                    [cellVoice.btnVoice addTarget:self action:@selector(btnVoicePressed:) forControlEvents:UIControlEventTouchUpInside];
                    cell=cellVoice;
                }
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
    else if ([self.strTagName isEqualToString:@"Place"] || [self.strTagName isEqualToString:@"Thing"] || [self.strTagName isEqualToString:@"Other.0"])
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
                UIColor *color = [UIColor colorWithRed:144/255.0f green:146/255.0f blue:149/255.0f alpha:1.0];
                cellPerson.txtPersonName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Title/Name" attributes:@{NSForegroundColorAttributeName: color}];
                cellPerson.txtPersonName.delegate=self;
                cellPerson.txtPersonName.autocapitalizationType=UITextAutocapitalizationTypeWords;
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
                CategoryCell *cellCategory=[tableView dequeueReusableCellWithIdentifier:strIdentifier];
                if (!cellCategory)
                {
                    cellCategory=[[[NSBundle mainBundle]loadNibNamed:@"CategoryCell" owner:self options:nil]objectAtIndex:0];
                }
                cellCategory.lblCategory.text=strCategory;
                [cellCategory.btnCategory addTarget:self action:@selector(btnCategoryClicked:) forControlEvents:UIControlEventTouchUpInside];
                cell=cellCategory;
                
            }
                break;
                
            case 2 :
            {
                PersonNameCell *cellPerson=[tableView dequeueReusableCellWithIdentifier:strIdentifier];
                if (!cellPerson)
                {
                    cellPerson=[[[NSBundle mainBundle]loadNibNamed:@"PersonNameCell" owner:self options:nil]objectAtIndex:1];
                }
                UIColor *color = [UIColor colorWithRed:144/255.0f green:146/255.0f blue:149/255.0f alpha:1.0];
                cellPerson.txtPersonName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Contact Info" attributes:@{NSForegroundColorAttributeName: color}];
                [cellPerson.btnContact addTarget:self action:@selector(btnContactPressed:) forControlEvents:UIControlEventTouchUpInside];
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
                if (appDel.strAudioURL.length>0)
                {
                    VoiceTagCell *cellVoice=[tableView dequeueReusableCellWithIdentifier:strIdentifier];
                    if (!cellVoice)
                    {
                        cellVoice=[[[NSBundle mainBundle]loadNibNamed:@"VoiceTagCell" owner:self options:nil]objectAtIndex:1];
                    }
                    cellVoice.sliderRecorder.minimumValue=0.0f;
                    cellVoice.sliderRecorder.maximumValue=appDel.audioLength;
                    [cellVoice.sliderRecorder setMinimumValue:0.0f];
                    [cellVoice.btnRecordPlay addTarget:self action:@selector(btnPlayPressed:) forControlEvents:UIControlEventTouchUpInside];
                    [cellVoice.sliderRecorder addTarget:self action:@selector(updateSlider) forControlEvents:UIControlEventValueChanged];
                    [cellVoice.btnClose addTarget:self action:@selector(btnDeleteVoicePressed:) forControlEvents:UIControlEventTouchUpInside];
                    cell=cellVoice;
                }
                else
                {
                    VoiceTagCell *cellVoice=[tableView dequeueReusableCellWithIdentifier:strIdentifier];
                    if (!cellVoice)
                    {
                        cellVoice=[[[NSBundle mainBundle]loadNibNamed:@"VoiceTagCell" owner:self options:nil]objectAtIndex:0];
                    }
                    [cellVoice.btnVoice addTarget:self action:@selector(btnVoicePressed:) forControlEvents:UIControlEventTouchUpInside];
                    cell=cellVoice;
                }
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
            cellPerson.txtPersonName.delegate=self;

            cellPerson.txtPersonName.autocapitalizationType=UITextAutocapitalizationTypeWords;
            cellPerson.txtPersonName.placeholder=[arrPlaceHolders objectAtIndex:indexPath.row];
            cellPerson.txtPersonName.tag=indexPath.row;
            UIColor *color = [UIColor colorWithRed:144/255.0f green:146/255.0f blue:149/255.0f alpha:1.0];
            cellPerson.txtPersonName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[arrPlaceHolders objectAtIndex:indexPath.row] attributes:@{NSForegroundColorAttributeName: color}];
            [cellPerson.txtPersonName addTarget:self action:@selector(textFieldEdited:) forControlEvents:UIControlEventEditingChanged];
            switch (indexPath.row)
            {
                case 0:
                    cellPerson.txtPersonName.text=strPersonName;
                    break;
                case 1:
                    cellPerson.txtPersonName.text=strBusinessContactName;
                    break;
                    
                case 2:
                    cellPerson.txtPersonName.text=strBusinessTitle;
                    break;
                    
                case 3:
                    cellPerson.txtPersonName.text=strBusinessAddress;
                    break;
                    
                case 4:
                    cellPerson.txtPersonName.keyboardType=UIKeyboardTypePhonePad;
                    cellPerson.txtPersonName.text=strBusinessPhone;
                    break;
                    
                case 5:
                    cellPerson.txtPersonName.keyboardType=UIKeyboardTypePhonePad;
                    cellPerson.txtPersonName.text=strBusinessCellPhone;
                    break;
                    
                case 6:
                    cellPerson.txtPersonName.keyboardType=UIKeyboardTypePhonePad;
                    cellPerson.txtPersonName.text=strBusinessFax;
                    break;
                    
                case 7:
                    cellPerson.txtPersonName.keyboardType=UIKeyboardTypeEmailAddress;
                    cellPerson.txtPersonName.autocapitalizationType=UITextAutocapitalizationTypeNone;
                    cellPerson.txtPersonName.text=strBusinessEmail;
                    break;
                    
                case 8:
                    cellPerson.txtPersonName.keyboardType=UIKeyboardTypeURL;
                    cellPerson.txtPersonName.autocapitalizationType=UITextAutocapitalizationTypeNone;
                    cellPerson.txtPersonName.text=strBusinessWebsite;
                    break;

                    
                default:
                    break;
            }
            cell=cellPerson;
        }
        else if (indexPath.row==9)
        {
            CategoryCell *cellCategory=[tableView dequeueReusableCellWithIdentifier:strIdentifier];
            if (!cellCategory)
            {
                cellCategory=[[[NSBundle mainBundle]loadNibNamed:@"CategoryCell" owner:self options:nil]objectAtIndex:0];
            }
            cellCategory.lblCategory.text=strCategory;
            [cellCategory.btnCategory addTarget:self action:@selector(btnCategoryClicked:) forControlEvents:UIControlEventTouchUpInside];
            cell=cellCategory;
        }
        else if (indexPath.row==10)
        {
            AddLogoCell *cellButton=[tableView dequeueReusableCellWithIdentifier:strIdentifier];
            if (!cellButton)
            {
                cellButton=[[[NSBundle mainBundle]loadNibNamed:@"AddLogoCell" owner:self options:nil]objectAtIndex:0];
            }
            cellButton.btnAddLogo.tag=indexPath.row;
            cellButton.txtAddLogo.userInteractionEnabled=NO;
            [cellButton.btnAddLogo addTarget:self action:@selector(btnAddLogoPressed:) forControlEvents:UIControlEventTouchUpInside];
            if (isBusinessLogo)
            {
                cellButton.txtAddLogo.text=@"Logo Updated";
            }
            cell=cellButton;
        }
        else if (indexPath.row==11)
        {
            AddImageCell *cellImage=[tableView dequeueReusableCellWithIdentifier:strIdentifier];
            if (!cellImage)
            {
                cellImage=[[[NSBundle mainBundle]loadNibNamed:@"AddImageCell" owner:self options:nil]objectAtIndex:0];
            }
            cellImage.delegate=self;
            cell=cellImage;
        }
        else if (indexPath.row==12)
        {
            AddVideoCell *cellVideo=[tableView dequeueReusableCellWithIdentifier:strIdentifier];
            if (!cellVideo)
            {
                cellVideo=[[[NSBundle mainBundle]loadNibNamed:@"AddVideoCell" owner:self options:nil]objectAtIndex:0];
            }
            cellVideo.delegate=self;
            cell=cellVideo;
            
        }
        else if (indexPath.row==13)
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
        else if (indexPath.row==14)
        {
            if (appDel.strAudioURL.length>0)
            {
                VoiceTagCell *cellVoice=[tableView dequeueReusableCellWithIdentifier:strIdentifier];
                if (!cellVoice)
                {
                    cellVoice=[[[NSBundle mainBundle]loadNibNamed:@"VoiceTagCell" owner:self options:nil]objectAtIndex:1];
                }
                cellVoice.sliderRecorder.minimumValue=0.0f;
                cellVoice.sliderRecorder.maximumValue=appDel.audioLength;
                [cellVoice.sliderRecorder setMinimumValue:0.0f];
                [cellVoice.btnRecordPlay addTarget:self action:@selector(btnPlayPressed:) forControlEvents:UIControlEventTouchUpInside];
                [cellVoice.sliderRecorder addTarget:self action:@selector(updateSlider) forControlEvents:UIControlEventValueChanged];
                [cellVoice.btnClose addTarget:self action:@selector(btnDeleteVoicePressed:) forControlEvents:UIControlEventTouchUpInside];
                cell=cellVoice;
            }
            else
            {
                VoiceTagCell *cellVoice=[tableView dequeueReusableCellWithIdentifier:strIdentifier];
                if (!cellVoice)
                {
                    cellVoice=[[[NSBundle mainBundle]loadNibNamed:@"VoiceTagCell" owner:self options:nil]objectAtIndex:0];
                }
                [cellVoice.btnVoice addTarget:self action:@selector(btnVoicePressed:) forControlEvents:UIControlEventTouchUpInside];
                cell=cellVoice;
            }
            
        }
        else if (indexPath.row==15)
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

-(void)btnAddLogoPressed:(id)sender
{
    [self selectImageForBusinessLogo:[sender tag]];
}

-(void)btnDeleteVoicePressed:(id)sender
{
    appDel.strAudioURL=@"";
    if ([self.strTagName isEqualToString:@"Business"])
    {
        [tblTagsCreation beginUpdates];
        NSArray *paths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:14 inSection:0]];
        [tblTagsCreation reloadRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationFade];
        [tblTagsCreation endUpdates];
        
    }
    else
    {
        [tblTagsCreation beginUpdates];
        NSArray *paths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:6 inSection:0]];
        [tblTagsCreation reloadRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationFade];
        [tblTagsCreation endUpdates];
    }

}

-(void)btnCategoryClicked:(id)sender
{
    [self.view endEditing:YES];
    [[CategoryService service] callCategoryServiceWithCompletionHandler:^(id  _Nullable result, BOOL isError, NSString * _Nullable strMsg) {
        if (isError)
        {
            [self displayErrorWithMessage:strMsg];
        }
        else
        {
            NSLog(@"%@",result);
            if ([result isKindOfClass:[NSMutableArray class]])
            {
                CategoryController *master1=[[CategoryController alloc]initWithNibName:@"CategoryController" bundle:nil];
                master1.arrCategoryList=result;
                master1.objFolders=self.objFolders;
                master1.view.frame=[[UIScreen mainScreen]bounds];
                [self.view addSubview:master1.view];
                [self addChildViewController:master1];
                [master1 didMoveToParentViewController:self];
                master1.delegate=self;
            }
        }
    }];
}

-(void)btnContactPressed:(id)sender
{
    master=[[ContactsPopupController alloc]initWithNibName:@"ContactsPopupController" bundle:nil];
    master.objPopUPTemplates=objTemplates;
    master.view.frame=[UIScreen mainScreen].bounds;
    [self.view addSubview:master.view];
    [self addChildViewController:master];
    [master didMoveToParentViewController:self];
    master.delegate=self;
}

-(void)btnMalePressed:(id)sender
{
    [self.view endEditing:YES];
    strGender=@"M";
    [tblTagsCreation beginUpdates];
    NSArray *paths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:1 inSection:0]];
    [tblTagsCreation reloadRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationFade];
    [tblTagsCreation endUpdates];
    [self checkGender];
}

-(void)btnFemalePressed:(id)sender
{
    [self.view endEditing:YES];
    strGender=@"F";
    [tblTagsCreation beginUpdates];
    NSArray *paths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:1 inSection:0]];
    [tblTagsCreation reloadRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationFade];
    [tblTagsCreation endUpdates];
    [self checkGender];
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
    if ([self alertChecking])
    {
        PreviewPopUpController *master3=[[PreviewPopUpController alloc]initWithNibName:@"PreviewPopUpController" bundle:nil];
        master3.view.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        [self.view addSubview:master3.view];
        [self addChildViewController:master3];
        master3.myDelegate=self;
        [master3 didMoveToParentViewController:self];
    }
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
                 
                 if ([self.strTagName isEqualToString:@"Business"])
                 {
                     [tblTagsCreation beginUpdates];
                     NSArray *paths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:15  inSection:0]];
                     [tblTagsCreation reloadRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationFade];
                     [tblTagsCreation endUpdates];
                     
                 }
                 else
                 {
                     [tblTagsCreation beginUpdates];
                     NSArray *paths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:7 inSection:0]];
                     [tblTagsCreation reloadRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationFade];
                     [tblTagsCreation endUpdates];
                     
                 }
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
                     if (place.formattedAddress.length>0)
                     {
                         [self checkLocationWithAddress:place.formattedAddress];
                     }
                     else
                     {
                         NSString *strLocation=[NSString stringWithFormat:@"%@,%@",addressObj.locality,addressObj.country];
                         [self checkLocationWithAddress:strLocation];
                     }
                     break;
                 }
             }];
            NSLog(@"place.formattedAddress:%@",place.formattedAddress);
            strPlace=place.formattedAddress;
            NSString *strCat = place.types[0];
            NSLog(@"Category:%@",strCat);
            pickedPlace = place;
        } else {
        }
    }];
}

-(void)btnMapCrossPressed:(id)sender
{
    if ([self.strTagName isEqualToString:@"Business"])
    {
        isLocation=NO;
        [tblTagsCreation beginUpdates];
        NSArray *paths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:15 inSection:0]];
        [tblTagsCreation reloadRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationFade];
        [tblTagsCreation endUpdates];
    }
    else
    {
        isLocation=NO;
        [tblTagsCreation beginUpdates];
        NSArray *paths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:7 inSection:0]];
        [tblTagsCreation reloadRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationFade];
        [tblTagsCreation endUpdates];
    }
}

-(void)btnTextViewClicked:(id)sender
{
    if ([self.strTagName isEqualToString:@"Business"])
    {
        isTextViewClicked=YES;
        [tblTagsCreation beginUpdates];
        NSArray *paths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:13 inSection:0]];
        [tblTagsCreation reloadRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationFade];
        [tblTagsCreation endUpdates];

    }
    else
    {
        isTextViewClicked=YES;
        [tblTagsCreation beginUpdates];
        NSArray *paths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:5 inSection:0]];
        [tblTagsCreation reloadRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationFade];
        [tblTagsCreation endUpdates];
    }
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:tblTagsCreation];
    NSIndexPath *indexPath = [tblTagsCreation indexPathForRowAtPoint:buttonPosition];
    AddVideoTagCell *cell=[tblTagsCreation cellForRowAtIndexPath:indexPath];
    [cell.txtTags becomeFirstResponder];
}

-(void)btnTextVwCrossPressed:(id)sender
{
    strTextVwTags=@"";
    [self.view endEditing:YES];
    isTextViewClicked=NO;
    if ([self.strTagName isEqualToString:@"Business"])
    {
        [tblTagsCreation beginUpdates];
        NSArray *paths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:13 inSection:0]];
        [tblTagsCreation reloadRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationFade];
        [tblTagsCreation endUpdates];

    }
    else
    {
        [tblTagsCreation beginUpdates];
        NSArray *paths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:5 inSection:0]];
        [tblTagsCreation reloadRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationFade];
        [tblTagsCreation endUpdates];

    }
}

-(void)btnVoicePressed:(id)sender
{
    [self performSegueWithIdentifier:@"segueAudio" sender:self];
}

-(void)btnPlayPressed:(id)sender
{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:tblTagsCreation];
    NSIndexPath *indexPath = [tblTagsCreation indexPathForRowAtPoint:buttonPosition];
    cellVoiceRecord=[tblTagsCreation cellForRowAtIndexPath:indexPath];
    [cellVoiceRecord.sliderRecorder setValue:0.0f];
    if (!player.playing)
    {
        NSData *objectData = [NSData dataWithContentsOfURL:[NSURL URLWithString:appDel.strAudioURL]];
        NSError *error;

        player = [[AVAudioPlayer alloc] initWithData:objectData error:&error];
        NSLog(@"%@",[error description]);
        [player setDelegate:self];
        [player prepareToPlay];
        player.volume=3.0;
        [player play];
        timer= [NSTimer scheduledTimerWithTimeInterval:0.0
                                                target:self
                                              selector:@selector(updateSlider)
                                              userInfo:nil
                                               repeats:YES];
    }
}

-(void)updateSlider
{
    [cellVoiceRecord.sliderRecorder setValue:[player currentTime]];
}

#pragma mark
#pragma mark Custom delegate preview popup
#pragma mark

-(void)previewButtonPressed
{
    if ([self alertChecking])
    {
        [[PreviewAdService service]previewAdServiceWithKey:self.objFolders.strTkey withCompletionHandler:^(id  _Nullable result, BOOL isError, NSString * _Nullable strMsg) {
            if (isError)
            {
                [self displayErrorWithMessage:strMsg];
            }
            else
            {
                NSLog(@"%@",[result objectForKey:@"previewUrl"]);
                strURL=[result objectForKey:@"previewUrl"];
                strURL=[strURL stringByReplacingOccurrencesOfString:@"https" withString:@"http"];
                NSLog(@"%@",strURL);
                //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[result objectForKey:@"previewUrl"]]];
                [self performSegueWithIdentifier:@"seguePreview" sender:self];

            }
        }];
    }
}

-(void)publishButtonPressed
{
    [[PublishTagService service]publishTagServiceWithKey:self.objFolders.strTkey tName:objTemplates.strtname aFolder:appDel.objUser.strAfolder tFolder:self.objFolders.strTFolder withCompletionHandler:^(id  _Nullable result, BOOL isError, NSString * _Nullable strMsg) {
        if (isError)
        {
            [self displayErrorWithMessage:strMsg];
        }
        else
        {
            NSLog(@"%@",result);
            dictQRCode=(NSMutableDictionary *)result;
            [self performSegueWithIdentifier:@"segueQRCode" sender:self];
        }
    }];
}

#pragma mark
#pragma mark textfield delegate methods
#pragma mark

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    switch (textField.tag)
    {
        case 4:
            if (textField.text.length>0)
            {
                [self checkBusinessPhone];
            }
            break;
            
        case 5:
            if (textField.text.length>0)
            {
                [self checkBusinessCell];
            }
            break;
            
        case 6:
            if (textField.text.length>0)
            {
                [self checkBusinessFaxNumber];
            }
            break;
            
        default:
            break;
    }
}

-(void)textFieldEdited:(id)sender
{
    UITextField *textField=(id)sender;
    if ([self.strTagName isEqualToString:@"Business"])
    {
        switch (textField.tag)
        {
            case 0:
                strPersonName=textField.text;
                break;
            case 1:
                strBusinessContactName=textField.text;
                break;
                
            case 2:
                strBusinessTitle=textField.text;
                break;
                
            case 4:
                strBusinessPhone=textField.text;
                break;
                
            case 5:
                strBusinessCellPhone=textField.text;
                break;
                //fax email website
            case 6:
                strBusinessFax=textField.text;
                break;
            case 7:
                strBusinessEmail=textField.text;
                break;
            case 8:
                strBusinessWebsite=textField.text;
                break;

                
            default:
                break;
        }

    }
    else
    {
        strPersonName=textField.text;

    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([self.strTagName isEqualToString:@"Business"])
    {
        switch (textField.tag)
        {
            case 0:
                if (textField.text.length>0)
                {
                    [self checkName];
                }
                break;
            case 1:
                if (textField.text.length>0)
                {
                    [self checkContactName];
                }
                break;
                
            case 2:
                if (textField.text.length>0)
                {
                    [self checkBusinessTitle];
                }
                break;
                
            case 7:
                if (textField.text.length>0)
                {
                    [self checkBusinessEmail];
                }
                break;
            case 8:
                if (textField.text.length>0)
                {
                    [self checkBusinessWebsite];
                }
                break;
               
            default:
                break;
        }
    }
    else
    {
        if (textField.text.length>0)
        {
            [self checkName];
        }
    }
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
        if (strDeathDate.length>0)
        {
            
            NSDate *deathDate=[dateFormatter dateFromString:strDeathDate];
            if ([deathDate compare:selectedDate]==NSOrderedAscending)
            {
                [self displayErrorWithMessage:@"Death date should be higher than birth date"];
                strBirthDate=@"";
            }
        }
        else
        {
            [self checkDatesFrom];
        }
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
        else
        {
            [self checkDatesTo];
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
    if (textView.text.length>0)
    {
        [self checkMemorialQuotes];
    }

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
        [picker dismissViewControllerAnimated:YES completion:^{
            [self uploadImageToCloudinary:imgChosen];
            
        }] ;
    }
    else
    {
        NSData *videoData;
        UIImage *imgThumbnail;
        if (picker.sourceType==UIImagePickerControllerSourceTypeCamera)
        {
            NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
            if ([mediaType isEqualToString:@"public.movie"])
            {
                // Saving the video / // Get the new unique filename
                //        NSString *sourcePath = [[info objectForKey:@"UIImagePickerControllerMediaURL"]relativePath];
                //        UISaveVideoAtPathToSavedPhotosAlbum(sourcePath,nil,nil,nil);
                NSURL *videoURL     = [info objectForKey:UIImagePickerControllerMediaURL];
                videoData = [NSData dataWithContentsOfURL:videoURL];
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
                    imgThumbnail = [UIImage imageWithCGImage:imageRef];
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
                videoData = [NSData dataWithContentsOfURL:videoURL];
                NSLog(@"%lu",(unsigned long)videoData.length);
                AVAsset *asset = [AVAsset assetWithURL:videoURL];
                AVAssetImageGenerator *imageGenerator = [[AVAssetImageGenerator alloc]initWithAsset:asset];
                CMTime time = CMTimeMake(1, 1);
                CGImageRef imageRef = [imageGenerator copyCGImageAtTime:time actualTime:NULL error:NULL];
                imgThumbnail = [UIImage imageWithCGImage:imageRef];
                CGImageRelease(imageRef);
            }
        }
        [picker dismissViewControllerAnimated:YES completion:^{
            [self uploadVideoToCloudinary:videoData image:imgThumbnail];
        }];
    }
}

-(void)deleteImagesFromIndex:(NSInteger)i
{
    
    [[DeleteAssetService service]deleteAssetWithkey:[arrDeleteImages objectAtIndex:i] withCompletionHandler:^(id  _Nullable result, BOOL isError, NSString * _Nullable strMsg) {
        if (isError)
        {
            [self displayErrorWithMessage:strMsg];
        }
        else
        {
            [arrDeleteImages removeObjectAtIndex:i];
            [appDel.arrImageSet removeObjectAtIndex:i];
            [tblTagsCreation beginUpdates];
            NSArray *paths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:3 inSection:0]];
            [tblTagsCreation reloadRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationFade];
            [tblTagsCreation endUpdates];

        }
    }];
}

#pragma mark
#pragma mark Image Picker Videos Delegate
#pragma mark

-(void)selectVideos
{
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"Do you want to shoot a video or select it from gallery??" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionCamera=[UIAlertAction actionWithTitle:@"CAMERA" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self takeVideoFromCamera];
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
        picker.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie,nil];
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
    [[DeleteAssetService service]deleteAssetWithkey:[arrDeleteVideos objectAtIndex:i] withCompletionHandler:^(id  _Nullable result, BOOL isError, NSString * _Nullable strMsg) {
        if (isError)
        {
            [self displayErrorWithMessage:strMsg];
        }
        else
        {
            [arrDeleteVideos removeObjectAtIndex:i];
            [appDel.arrVideoSet removeObjectAtIndex:i];
            [tblTagsCreation beginUpdates];
            NSArray *paths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:4 inSection:0]];
            [tblTagsCreation reloadRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationFade];
            [tblTagsCreation endUpdates];

        }
    }];
}

#pragma mark
#pragma mark UPDATE DICTIONARY FOR API SERVICE
#pragma mark

//tcname

-(void)checkContactName
{
    NSLog(@"%@",objTemplates);
    if (objTemplates)
    {
        NSLog(@"%@",objTemplates.strTcname);
        if ([objTemplates.strTcname isEqualToString:strBusinessContactName])
        {
            [dictAPI removeObjectForKey:@"tcname"];
        }
        else
        {
            [dictAPI setObject:strBusinessContactName forKey:@"tcname"];
            [self updateDictionaryForServiceForKey:@"tcname"];
        }
    }
    else
    {
        [dictAPI setObject:strBusinessContactName forKey:@"tcname"];
        [self updateDictionaryForServiceForKey:@"tcname"];
    }

}

-(void)checkBusinessTitle
{
    NSLog(@"%@",objTemplates);
    if (objTemplates)
    {
        NSLog(@"%@",objTemplates.strtname);
        if ([objTemplates.strSlogan isEqualToString:strBusinessTitle])
        {
            [dictAPI removeObjectForKey:@"tslogan"];
        }
        else
        {
            [dictAPI setObject:strBusinessTitle forKey:@"tslogan"];
            [self updateDictionaryForServiceForKey:@"tslogan"];
        }
    }
    else
    {
        [dictAPI setObject:strBusinessTitle forKey:@"tslogan"];
        [self updateDictionaryForServiceForKey:@"tslogan"];
    }

}

-(void)checkBusinessPhone
{
    NSLog(@"%@",objTemplates);
    if (objTemplates)
    {
        if ([objTemplates.strTphone isEqualToString:strBusinessPhone])
        {
            [dictAPI removeObjectForKey:@"tphone"];
        }
        else
        {
            [dictAPI setObject:strBusinessPhone forKey:@"tphone"];
            [self updateDictionaryForServiceForKey:@"tphone"];
        }
    }
    else
    {
        [dictAPI setObject:strBusinessPhone forKey:@"tphone"];
        [self updateDictionaryForServiceForKey:@"tphone"];
    }
}

-(void)checkBusinessCell
{
    NSLog(@"%@",objTemplates);
    if (objTemplates)
    {
        NSLog(@"%@",objTemplates.strtname);
        if ([objTemplates.strMobile isEqualToString:strBusinessCellPhone])
        {
            [dictAPI removeObjectForKey:@"tmobile"];
        }
        else
        {
            [dictAPI setObject:strBusinessCellPhone forKey:@"tmobile"];
            [self updateDictionaryForServiceForKey:@"tmobile"];
        }
    }
    else
    {
        [dictAPI setObject:strBusinessCellPhone forKey:@"tmobile"];
        [self updateDictionaryForServiceForKey:@"tmobile"];
    }

}

-(void)checkBusinessFaxNumber
{
    NSLog(@"%@",objTemplates);
    if (objTemplates)
    {
        if ([objTemplates.strTfax isEqualToString:strBusinessFax])
        {
            [dictAPI removeObjectForKey:@"tfax"];
        }
        else
        {
            [dictAPI setObject:strBusinessFax forKey:@"tfax"];
            [self updateDictionaryForServiceForKey:@"tfax"];
        }
    }
    else
    {
        [dictAPI setObject:strBusinessFax forKey:@"tfax"];
        [self updateDictionaryForServiceForKey:@"tfax"];
    }

}

-(void)checkBusinessEmail
{
    NSLog(@"%@",objTemplates);
    if (objTemplates)
    {
        if ([objTemplates.strEmail isEqualToString:strBusinessEmail])
        {
            [dictAPI removeObjectForKey:@"tfax"];
        }
        else
        {
            [dictAPI setObject:strBusinessEmail forKey:@"tfax"];
            [self updateDictionaryForServiceForKey:@"tfax"];
        }
    }
    else
    {
        [dictAPI setObject:strBusinessEmail forKey:@"tfax"];
        [self updateDictionaryForServiceForKey:@"tfax"];
    }
}

-(void)checkBusinessWebsite
{
    NSLog(@"%@",objTemplates);
    if (objTemplates)
    {
        if ([objTemplates.strWebsite isEqualToString:strBusinessWebsite])
        {
            [dictAPI removeObjectForKey:@"twebsite"];
        }
        else
        {
            [dictAPI setObject:strBusinessWebsite forKey:@"twebsite"];
            [self updateDictionaryForServiceForKey:@"twebsite"];
        }
    }
    else
    {
        [dictAPI setObject:strBusinessWebsite forKey:@"twebsite"];
        [self updateDictionaryForServiceForKey:@"twebsite"];
    }
}

-(void)checkBusinessAddress
{
    NSLog(@"%@",objTemplates);
    if (objTemplates)
    {
        if ([objTemplates.strAddress2 isEqualToString:strBusinessAddress])
        {
            [dictAPI removeObjectForKey:@"taddress2"];
        }
        else
        {
            [dictAPI setObject:strBusinessAddress forKey:@"taddress2"];
            [self updateDictionaryForServiceForKey:@"taddress2"];
        }
    }
    else
    {
        [dictAPI setObject:strBusinessAddress forKey:@"taddress2"];
        [self updateDictionaryForServiceForKey:@"taddress2"];
    }

}

-(void)checkName
{
    NSLog(@"%@",objTemplates);
    if (objTemplates)
    {
        NSLog(@"%@",objTemplates.strtname);
        if ([objTemplates.strtname isEqualToString:strPersonName])
        {
            [dictAPI removeObjectForKey:@"tname"];
        }
        else
        {
            [dictAPI setObject:strPersonName forKey:@"tname"];
            [self updateDictionaryForServiceForKey:@"tname"];
        }
    }
    else
    {
        [dictAPI setObject:strPersonName forKey:@"tname"];
        [self updateDictionaryForServiceForKey:@"tname"];
    }
}

-(void)checkDatesFrom
{       if (objTemplates)
    {
        NSLog(@"%@",objTemplates.strtborn);
        if ([objTemplates.strtborn isEqualToString:strBirthDate])
        {
            [dictAPI removeObjectForKey:@"tborn"];
        }
        else
        {
            [dictAPI setObject:strBirthDate forKey:@"tborn"];
            [self updateDictionaryForServiceForKey:@"tborn"];
        }
    }
    else
    {
        [dictAPI setObject:strBirthDate forKey:@"tborn"];
        [self updateDictionaryForServiceForKey:@"tborn"];
    }
}

-(void)checkGender
{
    if (objTemplates)
    {
        if ([objTemplates.strtgender isEqualToString:strGender])
        {
            [dictAPI removeObjectForKey:@"tgender"];
        }
        else
        {
            [dictAPI setObject:strGender forKey:@"tgender"];
            [self updateDictionaryForServiceForKey:@"tgender"];
        }
    }
    else
    {
        [dictAPI setObject:strGender forKey:@"tgender"];
        [self updateDictionaryForServiceForKey:@"tgender"];
    }
}

-(void)checkMemorialQuotes
{
    if (objTemplates)
    {
        if ([objTemplates.strMemorialQuote isEqualToString:strTextVwTags])
        {
            [dictAPI removeObjectForKey:@"tdetail"];
        }
        else
        {
            [dictAPI setObject:strTextVwTags forKey:@"tdetail"];
            [self updateDictionaryForServiceForKey:@"tdetail"];
        }
    }
    else
    {
        [dictAPI setObject:strTextVwTags forKey:@"tdetail"];
        [self updateDictionaryForServiceForKey:@"tdetail"];
    }
}

-(void)checkLocationWithAddress:(NSString *)strAddress
{
    /*tdata[taddress1],
    tdata[tlat1],
    tdata[tlong1]*/

    NSString *strLat=[NSString stringWithFormat:@"%f",locationUser.latitude];
    NSString *strLong=[NSString stringWithFormat:@"%f",locationUser.longitude];

    NSLog(@"%@",strAddress);
    if (objTemplates)
    {
        if ([objTemplates.strtaddress1 isEqualToString:strAddress])
        {
            [dictAPI removeObjectForKey:@"taddress1"];
            if ([objTemplates.strtlat1 isEqualToString:strLat])
            {
                [dictAPI removeObjectForKey:@"tlat1"];
            }
            if ([objTemplates.strtlong1 isEqualToString:strLong])
            {
                //long1
                [dictAPI removeObjectForKey:@"tlong1"];
            }
        }
        else
        {
            [dictAPI setObject:strAddress forKey:@"taddress1"];
            [dictAPI setObject:strLat forKey:@"tlat1"];
            [dictAPI setObject:strLong forKey:@"tlong1"];
            [self updateDictionaryForServiceForKey:@"taddress1"];
        }
    }
    else
    {
        [dictAPI setObject:strAddress forKey:@"taddress1"];
        [dictAPI setObject:strLat forKey:@"tlat1"];
        [dictAPI setObject:strLong forKey:@"tlong1"];
        [self updateDictionaryForServiceForKey:@"taddress1"];
    }

}

-(void)checkDatesTo
{
    if (objTemplates)
    {
        if ([objTemplates.strtdied isEqualToString:strDeathDate])
        {
            [dictAPI removeObjectForKey:@"tdied"];
        }
        else
        {
            [dictAPI setObject:strDeathDate forKey:@"tdied"];
            [self updateDictionaryForServiceForKey:@"tdied"];
        }
    }
    else
    {
        [dictAPI setObject:strDeathDate forKey:@"tdied"];
         [self updateDictionaryForServiceForKey:@"tdied"];
    }
}


#pragma mark
#pragma mark CALL WEBSERVICE
#pragma mark

-(void)updateDictionaryForServiceForKey:(NSString *)strKey
{
    NSLog(@"%@",dictAPI);
    //self.objFolders.strTkey
    NSLog(@"%@",self.objFolders.strTkey);

    [[LivingTagsSecondStepService service]callSecondStepServiceWithDIctionary:dictAPI tKey:self.objFolders.strTkey withCompletionHandler:^(id  _Nullable result, BOOL isError, NSString * _Nullable strMsg) {
        if (isError)
        {
            objTemplates=nil;
            [self displayErrorWithMessage:strMsg];
        }
        else
        {
            NSLog(@"%@",result);
            if ([strKey isEqualToString:@"taddress1"])
            {
                [dictAPI removeObjectForKey:@"tlat1"];
                [dictAPI removeObjectForKey:@"tlong1"];
                [dictAPI removeObjectForKey:strKey];
            }
            else
            {
                [dictAPI removeObjectForKey:strKey];
            }

            NSDictionary *dict=(id)result;
            objTemplates=[[ModelCreateTagsSecondStep alloc]initWithDictionary:dict];
        }
    }];
}

#pragma mark
#pragma mark cloudinary uploads
#pragma mark

-(void)uploadImageToCloudinary:(UIImage *)img
{
    if (isBusinessLogo==YES)
    {
   
        NSData *imageData=UIImageJPEGRepresentation(img, 0.2);
        CLUploader* uploader = [[CLUploader alloc] init:cloudinary delegate:self];
        NSString * strTimestamp = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970] * 1000];
        NSString *strPublicKey=[NSString stringWithFormat:@"%@/%@",self.objFolders.strProfileFolder,strTimestamp];
        // [uploader upload:imageData options:@{@"public_id":strPublicKey}];
        [self displayNetworkActivity];
        [uploader upload:imageData options:@{@"public_id":strPublicKey} withCompletion:^(NSDictionary *successResult, NSString *errorResult, NSInteger code, id context) {
            NSLog(@"%@",successResult);
            if (successResult.count>0)
            {
                @try
                {
                    NSString *strBytes=[successResult objectForKey:@"bytes"];
                    NSString *strFileName=[[successResult objectForKey:@"public_id"] lastPathComponent];
                    NSLog(@"%@",strFileName);
                    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
                    [dict setObject:strFileName forKey:@"tphoto"];
                    [dict setObject:strBytes forKey:@"tphotosize"];
                    [dict setObject:@"I" forKey:@"tphototype"];
                    [[LivingTagsSecondStepService service]callSecondStepServiceWithDIctionary:dict tKey:self.objFolders.strTkey withCompletionHandler:^(id  _Nullable result, BOOL isError, NSString * _Nullable strMsg) {
                        [self hideNetworkActivity];
                        if (isError)
                        {
                            [self displayErrorWithMessage:strMsg];
                        }
                        else
                        {
                            [arrDeleteImages addObject:result];
                            if ([appDel.arrImageSet containsObject:@"1"])
                            {
                                [appDel.arrImageSet replaceObjectAtIndex:appDel.arrImageSet.count-1 withObject:img];
                            }
                            else
                            {
                                [appDel.arrImageSet addObject:img];
                            }
                            [appDel.arrImageSet addObject:@"1"];
                            [tblTagsCreation beginUpdates];
                            NSIndexPath* indexPath1 = [NSIndexPath indexPathForRow:10 inSection:0];
                            NSIndexPath* indexPath2 = [NSIndexPath indexPathForRow:11 inSection:0];
                            // Add them in an index path array
                            NSArray* indexArray = [NSArray arrayWithObjects:indexPath1, indexPath2, nil];
                            // Launch reload for the two index path
                            [tblTagsCreation reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationFade];
                            [tblTagsCreation endUpdates];
                        }
                    }];
                }
                @catch (NSException *exception)
                {
                    [self displayErrorWithMessage:exception.reason];
                }
                @finally
                {
                    
                }
            }
            else
            {
                [self hideNetworkActivity];
                [self displayErrorWithMessage:errorResult];
            }
        } andProgress:^(NSInteger bytesWritten, NSInteger totalBytesWritten, NSInteger totalBytesExpectedToWrite, id context) {
            
        }];

    }
    else
    {
        NSData *imageData=UIImageJPEGRepresentation(img, 0.2);
        CLUploader* uploader = [[CLUploader alloc] init:cloudinary delegate:self];
        NSString * strTimestamp = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970] * 1000];
        NSString *strPublicKey=[NSString stringWithFormat:@"%@/%@",self.objFolders.strImageFolder,strTimestamp];
        // [uploader upload:imageData options:@{@"public_id":strPublicKey}];
        [self displayNetworkActivity];
        [uploader upload:imageData options:@{@"public_id":strPublicKey} withCompletion:^(NSDictionary *successResult, NSString *errorResult, NSInteger code, id context) {
            NSLog(@"%@",successResult);
            if (successResult.count>0)
            {
                @try
                {
                    NSString *strBytes=[successResult objectForKey:@"bytes"];
                    NSString *strPublicID=[successResult objectForKey:@"public_id"];
                    NSString *strCreated=[successResult objectForKey:@"created_at"];
                    NSString *strFileName=[[successResult objectForKey:@"public_id"] lastPathComponent];
                    NSLog(@"%@",strFileName);
                    [[CloudinaryImageUploadService service]callCloudinaryImageUploadServiceWithBytes:strBytes created_date:strCreated fileName:strFileName k_key:self.objFolders.strTkey type:@"I" public_id:strPublicID  withCompletionHandler:^(id  _Nullable result, BOOL isError, NSString * _Nullable strMsg) {
                        if (isError)
                        {
                            [self displayErrorWithMessage:strMsg];
                        }
                        else
                        {
                            [arrDeleteImages addObject:result];
                            if ([appDel.arrImageSet containsObject:@"1"])
                            {
                                [appDel.arrImageSet replaceObjectAtIndex:appDel.arrImageSet.count-1 withObject:img];
                            }
                            else
                            {
                                [appDel.arrImageSet addObject:img];
                            }
                            [appDel.arrImageSet addObject:@"1"];
                            if ([self.strTagName isEqualToString:@"Business"])
                            {
                                [tblTagsCreation beginUpdates];
                                NSArray *paths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:11 inSection:0]];
                                [tblTagsCreation reloadRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationFade];
                                [tblTagsCreation endUpdates];
                                
                            }
                            else
                            {
                                
                                [tblTagsCreation beginUpdates];
                                NSArray *paths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:3 inSection:0]];
                                [tblTagsCreation reloadRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationFade];
                                [tblTagsCreation endUpdates];
                            }
                        }
                    }];
                }
                @catch (NSException *exception)
                {
                    [self displayErrorWithMessage:exception.reason];
                }
                @finally
                {
                    
                }
            }
            else
            {
                [self hideNetworkActivity];
                [self displayErrorWithMessage:errorResult];
            }
        } andProgress:^(NSInteger bytesWritten, NSInteger totalBytesWritten, NSInteger totalBytesExpectedToWrite, id context) {
            
        }];
    }
}

-(void)uploadVideoToCloudinary:(NSData *)dataVideo image:(UIImage *)imgaThumb
{
    CLUploader* uploader = [[CLUploader alloc] init:cloudinary delegate:self];
    NSString * strTimestamp = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970] * 1000];
    NSString *strPublicKey=[NSString stringWithFormat:@"%@/%@",self.objFolders.strVideoFolder,strTimestamp];
    // [uploader upload:imageData options:@{@"public_id":strPublicKey}];
    [self displayNetworkActivity];
    //@{@"public_id":strPublicKey,@"resource_type":@"video"}
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    [dict setObject:strPublicKey forKey:@"public_id"];
    [dict setObject:@"video" forKey:@"resource_type"];

    
    UIApplication*    app = [UIApplication sharedApplication];
    __block UIBackgroundTaskIdentifier task;
    task = [app beginBackgroundTaskWithExpirationHandler:^{
        [app endBackgroundTask:task];
        task = UIBackgroundTaskInvalid;
    }];
    // Start the long-running task and return immediately.
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // Do the work associated with the task.
        NSLog(@"Started background task timeremaining = %f", [app backgroundTimeRemaining]);
        [uploader upload:dataVideo options:dict withCompletion:^(NSDictionary *successResult, NSString *errorResult, NSInteger code, id context) {
            NSLog(@"%@",errorResult);
            NSLog(@"%@",successResult);
            if (successResult.count>0)
            {
                @try
                {
                    NSString *strBytes=[successResult objectForKey:@"bytes"];
                    NSString *strPublicID=[successResult objectForKey:@"public_id"];
                    NSString *strCreated=[successResult objectForKey:@"created_at"];
                    NSString *strFileName=[[successResult objectForKey:@"public_id"] lastPathComponent];
                    NSLog(@"%@",strFileName);
                    [[CloudinaryImageUploadService service]callCloudinaryImageUploadServiceWithBytes:strBytes created_date:strCreated fileName:strFileName k_key:self.objFolders.strTkey type:@"V" public_id:strPublicID  withCompletionHandler:^(id  _Nullable result, BOOL isError, NSString * _Nullable strMsg) {
                        [app endBackgroundTask:task];
                        task = UIBackgroundTaskInvalid;
                        if (isError)
                        {
                            [self displayErrorWithMessage:strMsg];
                        }
                        else
                        {
                            [self displayErrorWithMessage:strMsg];
                            [arrDeleteVideos addObject:result];
                            if ([appDel.arrVideoSet containsObject:@"1"])
                            {
                                [appDel.arrVideoSet replaceObjectAtIndex:appDel.arrVideoSet.count-1 withObject:imgaThumb];
                            }
                            else
                            {
                                [appDel.arrVideoSet addObject:imgaThumb];
                            }
                            [appDel.arrVideoSet addObject:@"1"];
                            if ([self.strTagName isEqualToString:@"Business"])
                            {
                                [tblTagsCreation beginUpdates];
                                NSArray *paths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:12 inSection:0]];
                                [tblTagsCreation reloadRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationFade];
                                [tblTagsCreation endUpdates];
                                
                            }
                            else
                            {
                                [tblTagsCreation beginUpdates];
                                NSArray *paths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:4 inSection:0]];
                                [tblTagsCreation reloadRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationFade];
                                [tblTagsCreation endUpdates];
                            }
                            
                            
                        }
                    }];
                }
                @catch (NSException *exception)
                {
                    [self displayErrorWithMessage:exception.reason];
                    [app endBackgroundTask:task];
                    task = UIBackgroundTaskInvalid;
                }
                @finally
                {
                    
                }
            }
            else
            {
                [self hideNetworkActivity];
                [self displayErrorWithMessage:errorResult];
                [app endBackgroundTask:task];
                task = UIBackgroundTaskInvalid;
            }
        } andProgress:^(NSInteger bytesWritten, NSInteger totalBytesWritten, NSInteger totalBytesExpectedToWrite, id context) {
            
        }];
    });
}

#pragma mark
#pragma mark PREPARE FOR SEGUE
#pragma mark

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"segueAudio"])
    {
        RecordViewController *master1=[segue destinationViewController];
        master1.objFolders=self.objFolders;
    }
    if ([segue.identifier isEqualToString:@"segueQRCode"])
    {
        QRCodeScanViewController *master2=[segue destinationViewController];
        master2.dictQR=dictQRCode;
    }
    //seguePreview
    if ([segue.identifier isEqualToString:@"seguePreview"])
    {
        PreviewViewController *masterPreview=[segue destinationViewController];
        masterPreview.str=strURL;
        masterPreview.strLabel=@"PREVIEW TAG";
    }
}

#pragma mark
#pragma mark avplayer delegate
#pragma mark

- (void) audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [timer invalidate];
    [cellVoiceRecord.sliderRecorder setValue:appDel.audioLength];

}

#pragma mark
#pragma mark scrollview delegate
#pragma mark

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (player.playing)
    {
        [player stop];
        [timer invalidate];
    }
}

#pragma mark
#pragma mark ALERT CHECKING
#pragma mark

-(BOOL)alertChecking
{
    if ([self.strTagName isEqualToString:@"Pet"])
    {
        if (strPersonName.length==0)
        {
            [self displayErrorWithMessage:@"Please enter  name."];
            return NO;
        }
        /*if (strGender.length==0)
        {
            [self displayErrorWithMessage:@"Please enter gender."];
            return NO;
        }
        if (isLiving==NO)
        {
            if (strDeathDate.length==0)
            {
                [self displayErrorWithMessage:@"Please enter death date."];
                return NO;
            }
        }
        if (strBirthDate.length==0)
        {
            [self displayErrorWithMessage:@"Please enter birth date."];
            return NO;
            
        }
        if (strTextVwTags.length==0)
        {
            [self displayErrorWithMessage:@"Please enter a memorial quote."];
            return NO;
        }
        if (isLocation==NO)
        {
            [self displayErrorWithMessage:@"Please enter a location."];
            return NO;
        }*/
    }
    else if([self.strTagName isEqualToString:@"Persons"])
    {
        if (strPersonName.length==0)
        {
            [self displayErrorWithMessage:@"Please enter  name."];
            return NO;
        }
      /*  if (strGender.length==0)
        {
            [self displayErrorWithMessage:@"Please enter gender."];
            return NO;
            
        }
        if (isLiving==NO)
        {
            if (strDeathDate.length==0)
            {
                [self displayErrorWithMessage:@"Please enter death date."];
                return NO;
                
            }
        }
        if (strBirthDate.length==0)
        {
            [self displayErrorWithMessage:@"Please enter birth date."];
            return NO;
            
        }
        if (strTextVwTags.length==0)
        {
            [self displayErrorWithMessage:@"Please enter a memorial quote."];
            return NO;
        }
        if (isLocation==NO)
        {
            [self displayErrorWithMessage:@"Please enter a location."];
            return NO;
        }*/
    }
    else if([self.strTagName isEqualToString:@"Business"])
    {
        if (strPersonName.length==0)
        {
            [self displayErrorWithMessage:@"Please enter Business name"];
            return NO;
        }
        /*if (strBusinessContactName.length==0)
        {
            [self displayErrorWithMessage:@"Please enter business contact name."];
            return NO;
        }
        if (strBusinessTitle.length==0)
        {
            [self displayErrorWithMessage:@"Please enter business title."];
            return NO;
        }
        if (strBusinessPhone.length==0)
        {
            [self displayErrorWithMessage:@"Please enter business phone number."];
            return NO;
        }
        if (strBusinessEmail.length==0)
        {
            [self displayErrorWithMessage:@"Please enter business email"];
            return NO;
        }
        if (strTextVwTags.length==0)
        {
            [self displayErrorWithMessage:@"Please enter Memorial quote."];
            return NO;
        }
        if (isLocation==NO)
        {
            [self displayErrorWithMessage:@"Please enter location."];
            return NO;
        }*/
    }
    else
    {
        if (strPersonName.length==0)
        {
            [self displayErrorWithMessage:@"Please enter the title"];
            return NO;
        }
       /* if (strCategory.length==0)
        {
            [self displayErrorWithMessage:@"Please enter the category name"];
            return NO;
        }
        if (strTextVwTags.length==0)
        {
            [self displayErrorWithMessage:@"Please enter the memorial quote"];
            return NO;
        }
        if (isLocation==NO)
        {
            [self displayErrorWithMessage:@"Please enter the location"];
            return NO;
        }*/
    }
    return YES;
}

#pragma mark 
#pragma mark CONTACT INFO CUSTOM DELEGATES
#pragma mark

-(void)callWebServiceWithDict:(NSMutableDictionary *)dict
{
    [[LivingTagsSecondStepService service]callSecondStepServiceWithDIctionary:dict tKey:self.objFolders.strTkey withCompletionHandler:^(id  _Nullable result, BOOL isError, NSString * _Nullable strMsg) {
        if (isError)
        {
            [self displayErrorWithMessage:strMsg];
        }
        else
        {
            objTemplates=[[ModelCreateTagsSecondStep alloc]initWithDictionary:result];
            [master.view removeFromSuperview];
            [master removeFromParentViewController];
            strContact=[NSString stringWithFormat:@"%@,%@,%@",objTemplates.strTcname,objTemplates.strTphone,objTemplates.strTfax];
            [tblTagsCreation beginUpdates];
            NSArray *paths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:2 inSection:0]];
            [tblTagsCreation reloadRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationFade];
            [tblTagsCreation endUpdates];

        }
    }];
}

#pragma mark
#pragma mark CATEGORY SELECTION DELEGATE
#pragma mark

-(void)selectedCategoryWithName:(NSString *)strName
{
    strCategory=strName;
    if ([self.strTagName isEqualToString:@"Business"])
    {
        [tblTagsCreation beginUpdates];
        NSArray *paths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:9 inSection:0]];
        [tblTagsCreation reloadRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationFade];
        [tblTagsCreation endUpdates];
    }
    else
    {
        [tblTagsCreation beginUpdates];
        NSArray *paths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:1 inSection:0]];
        [tblTagsCreation reloadRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationFade];
        [tblTagsCreation endUpdates];

    }
}

#pragma mark
#pragma mark business logo
#pragma mark

-(void)selectImageForBusinessLogo:(NSInteger)i
{
    NSLog(@"%d",i);
    isBusinessLogo=YES;
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

@end
