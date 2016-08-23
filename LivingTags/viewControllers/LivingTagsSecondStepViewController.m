//
//  LivingTagsSecondStepViewController.m
//  LivingTags
//
//  Created by appsbeetech on 12/07/16.
//  Copyright © 2016 appsbeetech. All rights reserved.

#import "LivingTagsSecondStepViewController.h"
#import <CoreGraphics/CoreGraphics.h>
#import "CKCalendarView.h"
#import "CreateTagsSecondStepCell.h"
#import "LivingTagsSecondStepService.h"
#import "ModelCreateTagsSecondStep.h"
#import "LivingTagsThirdStepViewController.h"
#import "CreateTagsUploadProfilePicService.h"
#import "CreateTagsUploadCoverPicService.h"
#import "CustomPopUpViewController.h"
#import "DatePickerViewController.h"

@interface LivingTagsSecondStepViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UITextViewDelegate,CKCalendarDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,CustomPopUPDelegate,SelectedDateDelegate>
{
    IBOutlet UILabel *lbl1;
    IBOutlet UILabel *lbl2;
    IBOutlet UILabel *lbl3;
    IBOutlet UILabel *lbl4;
    IBOutlet UITableView *tblSecondSteps;
    NSMutableArray *arrStatus;
    NSString *strGender,*strDateFrom,*strDateTo,*strName,*strMemorialQuote,*strDateFromServer,*strDateToServer;
    CKCalendarView *calendar;
    int textTag,btnUserPicTag;
    UIImageView *img;
    UIImage *imgChosen,*imgCoverPic;
    NSMutableDictionary *dictAPI;
    ModelCreateTagsSecondStep *objTemplates;
    IBOutlet UIButton *btnPreview;
    GMSPlacePicker *placePicker;
    GMSMapView *mapView;
    GMSPlace *pickedPlace;
    NSString *name2;
    NSString *address2;
    NSString *strCat,*strPrimaryLocation,*strSecondLocation,*strThirdLocation,*strLatitude1,*strLongitude1,*strLatitude2,*strLongitude2,*strLatitude3,*strLongitude3;
    BOOL isPrimaryLocationRemove,isSecondLocation,isThirdLocation,isProfileSuccess,isCoverSuccess,isSecondLocationSkip,isThirdLocationSkip;
    CustomPopUpViewController *customPopUP;
    DatePickerViewController *datePicker;
}

@property(nonatomic, weak) CKCalendarView *calendarCustom;
@property(nonatomic, strong) NSDateFormatter *dateFormatter;
@property(nonatomic, strong) NSDate *minimumDate;
@property(nonatomic, strong) NSArray *disabledDates;

@end

@implementation LivingTagsSecondStepViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    dictAPI=[[NSMutableDictionary alloc]init];
    calendar = [[CKCalendarView alloc] init];
    self.calendarCustom = calendar;
    calendar.delegate = self;
    strDateFrom=strDateTo=@"";
    strName=@"";
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat:@"yyyy-MM-dd"];
    self.minimumDate = [self.dateFormatter dateFromString:@"1950-11-01"];
    
    calendar.onlyShowCurrentMonth = NO;
    calendar.adaptHeightToNumberOfWeeksInMonth = YES;
    
    calendar.frame = CGRectMake(0, 30, [[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(localeDidChange) name:NSCurrentLocaleDidChangeNotification object:nil];
    arrStatus=[[NSMutableArray alloc]initWithObjects:@"0", nil];
    strGender=@"";
    NSLog(@"%@",self.strTemplateID);
    btnPreview.hidden=YES;
    isPrimaryLocationRemove=NO;
    isSecondLocation=NO;
    isThirdLocation=NO;
    isProfileSuccess=isCoverSuccess=YES;
    isSecondLocationSkip=isThirdLocationSkip=NO;
}

- (void)localeDidChange
{
    [self.calendarCustom setLocale:[NSLocale currentLocale]];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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
#pragma mark tableview datasource and delegate methods
#pragma mark

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%d",arrStatus.count);
    return arrStatus.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==2)
    {
        return 160.0f;
    }
    else if (indexPath.row==3)
    {
        return 60.0f;
    }
    else if (indexPath.row==7)
    {
        return 200.0f;
    }
    else if (indexPath.row==8)
    {
        return 100.0f;
    }
    else if (indexPath.row==4)
    {
        if (isPrimaryLocationRemove==YES)
        {
            return 120.0f;
        }
        return 70.0f;
    }
    else if (indexPath.row==5)
    {
        if (isSecondLocation==YES)
        {
            return 120.0f;
        }
        return 70.0f;
    }
    else if (indexPath.row==6)
    {
        if (isThirdLocation==YES)
        {
            return 120.0f;
        }
        return 70.0f;
    }
    else if (indexPath.row==9)
    {
        return 30.0f;
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
            if ([strGender isEqualToString:@"M"])
            {
                cellTags.lbl.text=@"What is his name?";
            }
            else if([strGender isEqualToString:@"F"])
            {
                cellTags.lbl.text=@"What is her name?";
            }
            else
            {
                cellTags.lbl.text=@"What is his/her name?";
            }
            cellTags.txtName.delegate=self;
            cellTags.txtName.autocapitalizationType = UITextAutocapitalizationTypeWords;
            if (strName.length>0)
            {
                cellTags.txtName.text=strName;
            }
            [cellTags.txtName addTarget:self action:@selector(textfieldEdited:) forControlEvents:UIControlEventEditingChanged];
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
            if ([strGender isEqualToString:@"M"])
            {
                cellTags.lbl.text=@"Add photos of him..";
            }
            else
            {
                cellTags.lbl.text=@"Add photos of her..";
            }
            img=cellTags.imgUser;
            if (imgChosen)
            {
                cellTags.imgUser.image=imgChosen;
                
            }
            cellTags.btnBrowseUserPic.tag=indexPath.row;
            if (isProfileSuccess==NO)
            {
                cellTags.lblImageUpload.text=@"Profile image Uploaded";
                [cellTags.btnBrowseUserPic setTitle:@"Change"  forState:UIControlStateNormal];
            }
            else
            {
                cellTags.lblImageUpload.text=@"Add profile pic.";
            }
            [cellTags.btnBrowseUserPic addTarget:self action:@selector(btnUserPicSelected:) forControlEvents:UIControlEventTouchUpInside];
            break;
            
        case 3:
            if (!cellTags)
            {
                cellTags=[[[NSBundle mainBundle]loadNibNamed:@"CreateTagsSecondStepCell" owner:self options:nil]objectAtIndex:3];
            }
            if ([strGender isEqualToString:@"M"])
            {
                cellTags.lbl.text=@"What is his age?";
            }
            else
            {
                cellTags.lbl.text=@"What is her age?";
            }
            cellTags.txtDateFrom.tag=indexPath.row;
            cellTags.txtDateTo.tag=9999;
            cellTags.txtDateFrom.delegate=self;
            cellTags.txtDateTo.delegate=self;
            cellTags.txtDateFrom.text=strDateFrom;
            cellTags.txtDateTo.text=strDateTo;
            break;
            
        case 4:
            if (isPrimaryLocationRemove==NO)
            {
                if (!cellTags)
                {
                    cellTags=[[[NSBundle mainBundle]loadNibNamed:@"CreateTagsSecondStepCell" owner:self options:nil]objectAtIndex:4];
                }
                /*if ([strGender isEqualToString:@"M"])
                {
                    cellTags.lbl.text=@"What is his location?";
                }
                else
                {
                    cellTags.lbl.text=@"What is her location?";
                }*/
                cellTags.lbl.text=@"Cemetary location..";
                cellTags.btnGetLocation.tag=indexPath.row;
                [cellTags.btnGetLocation addTarget:self action:@selector(btnGetLocationClicked:) forControlEvents:UIControlEventTouchUpInside];
            }
            else
            {
                if (!cellTags)
                {
                    cellTags=[[[NSBundle mainBundle]loadNibNamed:@"CreateTagsSecondStepCell" owner:self options:nil]objectAtIndex:7];
                }
                if ([strGender isEqualToString:@"M"])
                {
                    cellTags.lbl.text=@"What is his location?";
                }
                else
                {
                    cellTags.lbl.text=@"What is her location?";
                }
                cellTags.btnGetLocation.tag=indexPath.row;
                cellTags.btnRemoveLocation.tag=indexPath.row;
                cellTags.lblPrimaryLocation.text=strPrimaryLocation;
                [cellTags.btnGetLocation addTarget:self action:@selector(btnGetLocationClicked:) forControlEvents:UIControlEventTouchUpInside];
            }
            break;
            
        case 5:
            //skip functionality
            if (isSecondLocation==NO)
            {
                if (!cellTags)
                {
                    cellTags=[[[NSBundle mainBundle]loadNibNamed:@"CreateTagsSecondStepCell" owner:self options:nil]objectAtIndex:8];
                }
                cellTags.btnGetLocation.tag=indexPath.row;
                cellTags.btnSkipPressed.tag=indexPath.row;
                if (isSecondLocationSkip==NO)
                {
                    cellTags.btnSkipPressed.hidden=NO;
                }
                else
                {
                    cellTags.btnSkipPressed.hidden=YES;
                }
                [cellTags.btnGetLocation addTarget:self action:@selector(btnGetLocationClicked:) forControlEvents:UIControlEventTouchUpInside];
                [cellTags.btnSkipPressed addTarget:self action:@selector(btnSkipPressed:) forControlEvents:UIControlEventTouchUpInside ];
            }
            else
            {
                if (!cellTags)
                {
                    cellTags=[[[NSBundle mainBundle]loadNibNamed:@"CreateTagsSecondStepCell" owner:self options:nil]objectAtIndex:9];
                }
                cellTags.btnGetLocation.tag=indexPath.row;
                cellTags.btnRemoveLocation.tag=indexPath.row;
                cellTags.lblSecondLocation.text=strSecondLocation;
                [cellTags.btnGetLocation addTarget:self action:@selector(btnGetLocationClicked:) forControlEvents:UIControlEventTouchUpInside];
                [cellTags.btnRemoveLocation addTarget:self action:@selector(btnRemovePrimaryLocationPressed:) forControlEvents:UIControlEventTouchUpInside];
            }
            break;
        case 6:
            //skip functionality
            if (isThirdLocation==NO)
            {
                if (!cellTags)
                {
                    cellTags=[[[NSBundle mainBundle]loadNibNamed:@"CreateTagsSecondStepCell" owner:self options:nil]objectAtIndex:10];
                }
                cellTags.btnGetLocation.tag=indexPath.row;
                cellTags.btnSkipPressed.tag=indexPath.row;
                if (isThirdLocationSkip==NO)
                {
                    cellTags.btnSkipPressed.hidden=NO;
                }
                else
                {
                    cellTags.btnSkipPressed.hidden=YES;
                }
                [cellTags.btnGetLocation addTarget:self action:@selector(btnGetLocationClicked:) forControlEvents:UIControlEventTouchUpInside];
                [cellTags.btnSkipPressed addTarget:self action:@selector(btnSkipPressed:) forControlEvents:UIControlEventTouchUpInside ];

            }
            else
            {
                if (!cellTags)
                {
                    cellTags=[[[NSBundle mainBundle]loadNibNamed:@"CreateTagsSecondStepCell" owner:self options:nil]objectAtIndex:11];
                }
                cellTags.btnGetLocation.tag=indexPath.row;
                cellTags.lblThirdLocation.text=strThirdLocation;
                cellTags.btnRemoveLocation.tag=indexPath.row;
                [cellTags.btnGetLocation addTarget:self action:@selector(btnGetLocationClicked:) forControlEvents:UIControlEventTouchUpInside];
                [cellTags.btnRemoveLocation addTarget:self action:@selector(btnRemovePrimaryLocationPressed:) forControlEvents:UIControlEventTouchUpInside];
            }
            break;
            
        case 7:
            if (!cellTags)
            {
                cellTags=[[[NSBundle mainBundle]loadNibNamed:@"CreateTagsSecondStepCell" owner:self options:nil]objectAtIndex:5];
            }
            img=cellTags.imgCover;
            if ([strGender isEqualToString:@"M"])
            {
                cellTags.lbl.text=@"Add a cover pic of him";
            }
            else
            {
                cellTags.lbl.text=@"Add a cover pic of her";
            }
            if (imgCoverPic)
            {
                cellTags.imgCover.image=imgCoverPic;
            }
            if (isCoverSuccess==NO)
            {
                cellTags.lblImageUpload.text=@"Cover pic uploaded.";
                [cellTags.btnBrowseCover setTitle:@"Change"  forState:UIControlStateNormal];
            }
            else
            {
                cellTags.lblImageUpload.text=@"Add cover pic..";
            }
            cellTags.btnBrowseCover.tag=indexPath.row;
            [cellTags.btnBrowseCover addTarget:self action:@selector(btnCoverPicPressed:) forControlEvents:UIControlEventTouchUpInside];
            break;
            
        case 8:
            if (!cellTags)
            {
                cellTags=[[[NSBundle mainBundle]loadNibNamed:@"CreateTagsSecondStepCell" owner:self options:nil]objectAtIndex:6];
            }
            if ([strGender isEqualToString:@"M"])
            {
                cellTags.lbl.text=@"Any memorial quotes about him";
            }
            else
            {
                cellTags.lbl.text=@"Any memorial quotes about her";
            }
            cellTags.txtVwMemorialQuote.delegate=self;
            cellTags.txtVwMemorialQuote.tag=indexPath.row;
            if (strMemorialQuote.length>0)
            {
                cellTags.txtVwMemorialQuote.text=strMemorialQuote;
            }
            break;
            
        case 9:
            if (!cellTags)
            {
                cellTags=[[[NSBundle mainBundle]loadNibNamed:@"CreateTagsSecondStepCell" owner:self options:nil]objectAtIndex:12];
            }
            [cellTags.btnNext addTarget:self action:@selector(btnNextPressed:) forControlEvents:UIControlEventTouchUpInside];

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
    textTag=(int)textField.tag;
    if (textField.tag ==3 || textField.tag==9999)
    {
        //[self setTableviewContentOffsetWithView:@"textfield"];
        [textField resignFirstResponder];
        [self showDatePickerWithTextFieldTag:textField.tag];
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
}

-(void)textfieldEdited:(id)sender
{
    UITextField *text=(id)sender;
    strName=text.text;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"%ld",(long)textField.tag);
    if (textField.tag==0 && strName.length>0)
    {
        [self checkName];
    }
    [self updateTableView:textField.tag];
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
    if (arrStatus.count<10)
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
    [self checkName];
    strGender=@"M";
    [self checkGender];
//    CreateTagsSecondStepCell *cell=(CreateTagsSecondStepCell *)[self getSuperviewOfType:[UITableViewCell class] fromView:sender];
//    [cell.imgMale setImage:[UIImage imageNamed:@"radio_btn2"]];
//    [cell.imgFemale setImage:[UIImage imageNamed:@"radio_btn1"]];
    [tblSecondSteps reloadData];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self updateTableView:[sender tag]];
    });
}

-(void)btnFemalePressed:(id)sender
{
    [self.view endEditing:YES];
    [self checkName];
    strGender=@"F";
    [self checkGender];
//    CreateTagsSecondStepCell *cell=(CreateTagsSecondStepCell *)[self getSuperviewOfType:[UITableViewCell class] fromView:sender];
//    [cell.imgMale setImage:[UIImage imageNamed:@"radio_btn1"]];
//    [cell.imgFemale setImage:[UIImage imageNamed:@"radio_btn2"]];
    [tblSecondSteps reloadData];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self updateTableView:[sender tag]];
    });
}

-(void)btnUserPicSelected:(id)sender
{
    btnUserPicTag=(int)[sender tag];
    [self updateTableView:[sender tag]];
    [self addCustomPOPUP];
}

-(void)btnRemovePrimaryLocationPressed:(id)sender
{
    if ([sender tag]==5)
    {
        isSecondLocation=NO;
        [tblSecondSteps beginUpdates];
        NSArray *paths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:[sender tag] inSection:0]];
        [tblSecondSteps reloadRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationFade];
        [tblSecondSteps endUpdates];
    }
    else
    {
        isThirdLocation=NO;
        [tblSecondSteps beginUpdates];
        NSArray *paths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:[sender tag] inSection:0]];
        [tblSecondSteps reloadRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationFade];
        [tblSecondSteps endUpdates];
    }
}

-(void)btnSkipPressed:(id)sender
{
    NSLog(@"%d",[sender tag]);
    if ([sender tag]==5)
    {
        isSecondLocationSkip=YES;
        [tblSecondSteps reloadData];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self setTableviewContentOffsetWithView:@"secondLocation"];
        });
    }
    else
    {
        isThirdLocationSkip=YES;
        [tblSecondSteps reloadData];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self setTableviewContentOffsetWithView:@"thirdLocation"];
        });
    }
    [self updateTableView:[sender tag]];
}

-(void)btnGetLocationClicked:(id)sender
{
    [self updateTableView:[sender tag]];
//    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:tblSecondSteps];
//    NSIndexPath *indexPath = [tblSecondSteps indexPathForRowAtPoint:buttonPosition];
//    CreateTagsSecondStepCell *createTagsCell = (CreateTagsSecondStepCell *)[tblSecondSteps cellForRowAtIndexPath:indexPath];
    NSLog(@"%d",[sender tag]);
    if ([sender tag]==4)
    {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self setTableviewContentOffsetWithView:@"1stLocation"];
        });
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
            [self displayNetworkActivity];
            if (error != nil) {
                NSLog(@"Pick Place error %@", [error localizedDescription]);
                return;
            }
            if (place != nil) {
                name2 = place.name;
                NSLog(@"place.name:%@",place.name);
                
                [[GMSGeocoder geocoder] reverseGeocodeCoordinate:CLLocationCoordinate2DMake(place.coordinate.latitude, place.coordinate.longitude) completionHandler:^(GMSReverseGeocodeResponse* response, NSError* error)
                 {
                     [self hideNetworkActivity];
                     NSLog(@"reverse geocoding results:");
                     for(GMSAddress* addressObj in [response results])
                     {
                         strLatitude1=[NSString stringWithFormat:@"%f",place.coordinate.latitude];
                         strLongitude1=[NSString stringWithFormat:@"%f",place.coordinate.longitude];
                         NSLog(@"locality=%@", addressObj.locality);
                         NSLog(@"subLocality=%@", addressObj.subLocality);
                         NSLog(@"administrativeArea=%@", addressObj.administrativeArea);
                         NSLog(@"postalCode=%@", addressObj.postalCode);
                         NSLog(@"country=%@", addressObj.country);
                         // NSLog(@"lines=%@", addressObj.lines);
                         // [self performSegueWithIdentifier:@"placeDetailsSegue" sender:self];
                         [self checkLocationWithType:@"First"];
                         break;
                     }
                 }];
                address2 = place.formattedAddress;
                NSLog(@"place.formattedAddress:%@",place.formattedAddress);
                strPrimaryLocation=place.formattedAddress;
                isPrimaryLocationRemove=YES;
                [tblSecondSteps beginUpdates];
                NSArray *paths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:[sender tag] inSection:0]];
                [tblSecondSteps reloadRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationFade];
                [tblSecondSteps endUpdates];

                strCat = place.types[0];
                NSLog(@"Category:%@",strCat);
                pickedPlace = place;
            } else {
                name2 = @"No place selected";
                address2 = @"";
            }
        }];
    }
    else if ([sender tag]==5)
    {
        if ([sender tag]==5)
        {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self setTableviewContentOffsetWithView:@"secondLocation"];
            });
        }
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
            [self displayNetworkActivity];
            if (error != nil) {
                NSLog(@"Pick Place error %@", [error localizedDescription]);
                return;
            }
            
            if (place != nil) {
                name2 = place.name;
                NSLog(@"place.name:%@",place.name);
                
                [[GMSGeocoder geocoder] reverseGeocodeCoordinate:CLLocationCoordinate2DMake(place.coordinate.latitude, place.coordinate.longitude) completionHandler:^(GMSReverseGeocodeResponse* response, NSError* error)
                 {
                     [self hideNetworkActivity];
                     NSLog(@"reverse geocoding results:");
                     for(GMSAddress* addressObj in [response results])
                     {
                         strLatitude2=[NSString stringWithFormat:@"%f",place.coordinate.latitude];
                         strLongitude2=[NSString stringWithFormat:@"%f",place.coordinate.longitude];
                         NSLog(@"locality=%@", addressObj.locality);
                         NSLog(@"subLocality=%@", addressObj.subLocality);
                         NSLog(@"administrativeArea=%@", addressObj.administrativeArea);
                         NSLog(@"postalCode=%@", addressObj.postalCode);
                         NSLog(@"country=%@", addressObj.country);
                         // NSLog(@"lines=%@", addressObj.lines);
                         // [self performSegueWithIdentifier:@"placeDetailsSegue" sender:self];
                         [self checkLocationWithType:@"Second"];
                         break;
                     }
                 }];
                address2 = place.formattedAddress;
                strSecondLocation=place.formattedAddress;
                isSecondLocation=YES;
                //[tblSecondSteps reloadData];
                [tblSecondSteps beginUpdates];
                NSArray *paths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:[sender tag] inSection:0]];
                [tblSecondSteps reloadRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationFade];
                [tblSecondSteps endUpdates];

                NSLog(@"place.formattedAddress:%@",place.formattedAddress);
                strCat = place.types[0];
                NSLog(@"Category:%@",strCat);
                pickedPlace = place;
                
            }
            else
            {
                name2 = @"No place selected";
                address2 = @"";
            }
        }];
}
    else
    {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self setTableviewContentOffsetWithView:@"thirdLocation"];
        });
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
            [self displayNetworkActivity];
            if (error != nil) {
                NSLog(@"Pick Place error %@", [error localizedDescription]);
                return;
            }
            
            if (place != nil) {
                name2 = place.name;
                NSLog(@"place.name:%@",place.name);
                
                [[GMSGeocoder geocoder] reverseGeocodeCoordinate:CLLocationCoordinate2DMake(place.coordinate.latitude, place.coordinate.longitude) completionHandler:^(GMSReverseGeocodeResponse* response, NSError* error)
                 {
                     [self hideNetworkActivity];
                     NSLog(@"reverse geocoding results:");
                     for(GMSAddress* addressObj in [response results])
                     {
                         strLatitude3=[NSString stringWithFormat:@"%f",place.coordinate.latitude];
                         strLongitude3=[NSString stringWithFormat:@"%f",place.coordinate.longitude];
                         NSLog(@"locality=%@", addressObj.locality);
                         NSLog(@"subLocality=%@", addressObj.subLocality);
                         NSLog(@"administrativeArea=%@", addressObj.administrativeArea);
                         NSLog(@"postalCode=%@", addressObj.postalCode);
                         NSLog(@"country=%@", addressObj.country);
                         // NSLog(@"lines=%@", addressObj.lines);
                         // [self performSegueWithIdentifier:@"placeDetailsSegue" sender:self];
                         [self checkLocationWithType:@"Third"];
                         break;
                     }
                 }];
                address2 = place.formattedAddress;
                strThirdLocation=place.formattedAddress;
                isThirdLocation=YES;
                //[tblSecondSteps reloadData];
                [tblSecondSteps beginUpdates];
                NSArray *paths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:[sender tag] inSection:0]];
                [tblSecondSteps reloadRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationFade];
                [tblSecondSteps endUpdates];

                NSLog(@"place.formattedAddress:%@",place.formattedAddress);
                strCat = place.types[0];
                NSLog(@"Category:%@",strCat);
                pickedPlace = place;
                
            } else {
                name2 = @"No place selected";
                address2 = @"";
            }
        }];
    }
}

-(void)btnCoverPicPressed:(id)sender
{
    btnUserPicTag=(int)[sender tag];
    [self updateTableView:[sender tag]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self setTableviewContentOffsetWithView:@"coverPic"];
    });
    [self addCustomPOPUP];
}

-(void)btnNextPressed:(id)sender
{
    [self performSegueWithIdentifier:@"segueThirdStep" sender:self];
}


#pragma mark
#pragma mark textview delegate
#pragma mark


-(void)textViewDidBeginEditing:(UITextView *)textView
{
    textView.text=@"";
    [self setTableviewContentOffsetWithView:@"textView"];
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    [tblSecondSteps setContentOffset:CGPointMake(0, 300) animated:YES];
    strMemorialQuote=textView.text;
    [self checkMemorialQuotes];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"])
    {
        [self updateTableView:textView.tag];
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
        [tblSecondSteps setContentOffset:CGPointMake(0, 650) animated:YES];
    }
    else if ([strView isEqualToString:@"coverPic"])
    {
        [tblSecondSteps setContentOffset:CGPointMake(0, 450) animated:YES];
    }
    //thirdLocation
    //secondLocation
    else if ([strView isEqualToString:@"thirdLocation"])
    {
        [tblSecondSteps setContentOffset:CGPointMake(0, 300) animated:YES];
    }
    else if ([strView isEqualToString:@"secondLocation"])
    {
        [tblSecondSteps setContentOffset:CGPointMake(0, 200) animated:YES];
    }
    else if ([strView isEqualToString:@"1stLocation"])
    {
        [tblSecondSteps setContentOffset:CGPointMake(0, 160) animated:YES];
    }
    else
    {
        [tblSecondSteps setContentOffset:CGPointMake(0, 200) animated:YES];
    }
}

#pragma mark
#pragma mark CKCalender delegates and helper methods
#pragma mark

- (void)calendar:(CKCalendarView *)calendar configureDateItem:(CKDateItem *)dateItem forDate:(NSDate *)date
{
    // TODO: play with the coloring if we want to...
    if ([self dateIsDisabled:date])
    {
        dateItem.backgroundColor = [UIColor redColor];
        dateItem.textColor = [UIColor whiteColor];
    }
}

- (BOOL)calendar:(CKCalendarView *)calendar willSelectDate:(NSDate *)date {
    return ![self dateIsDisabled:date];
}

- (void)calendar:(CKCalendarView *)calendar didSelectDate:(NSDate *)date
{
    NSLog(@"%d",textTag);
    if (textTag==3)
    {
        strDateFrom=[self.dateFormatter stringFromDate:date];
        [self checkDatesFrom];
    }
    else
    {
        strDateTo=[self.dateFormatter stringFromDate:date];
        [self checkDatesTo];
        [self updateTableView:3];
    }
    [self.calendarCustom removeFromSuperview];
    [tblSecondSteps reloadData];
}

- (BOOL)calendar:(CKCalendarView *)calendar willChangeToMonth:(NSDate *)date {
    if ([date laterDate:self.minimumDate] == date)
    {
        self.calendarCustom.backgroundColor = [UIColor grayColor];
        return YES;
    }
    else
    {
        self.calendarCustom.backgroundColor = [UIColor grayColor];
        return NO;
    }
}

- (void)calendar:(CKCalendarView *)calendar didLayoutInRect:(CGRect)frame
{
    NSLog(@"calendar layout: %@", NSStringFromCGRect(frame));
}

- (BOOL)dateIsDisabled:(NSDate *)date
{
    for (NSDate *disabledDate in self.disabledDates)
    {
        if ([disabledDate isEqualToDate:date])
        {
            return YES;
        }
    }
    return NO;
}


#pragma mark
#pragma mark IMAGE PICKER CONTROLLER DELEGATE
#pragma mark

-(void)imageUploadFromGallery
{
    UIImagePickerController *picker=[[UIImagePickerController alloc] init];
    picker.delegate=self;
    if (btnUserPicTag==2)
    {
        picker.allowsEditing=YES;

    }
    else
    {
        picker.allowsEditing=NO;

    }
    picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:^{
        
    }];
}

-(void)imageUploadFromCamera
{
    if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront]|| [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear])
    {
        UIImagePickerController *picker=[[UIImagePickerController alloc]init] ;
        picker.delegate=self ;
        picker.sourceType=UIImagePickerControllerSourceTypeCamera ;
        if (btnUserPicTag==2)
        {
            picker.allowsEditing=YES ;

        }
        else
        {
            picker.allowsEditing=NO ;

        }
        [self presentViewController:picker animated:YES completion:nil] ;
    }
    else
    {
        [[[UIAlertView alloc]initWithTitle:@"ERROR" message:@"Camera not found." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil]show];
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"%d",btnUserPicTag);
    if(btnUserPicTag==2)
    {
        imgChosen=info[UIImagePickerControllerEditedImage] ;
        dispatch_async(dispatch_get_main_queue(), ^{
            [[CreateTagsUploadProfilePicService service]callCreateTagsUploadProfileServiceWithLivingTagsID:self.strTemplateID user_ID:appDel.objUser.strUserID image:imgChosen withCompletionHandler:^(id  _Nullable result, BOOL isError, NSString * _Nullable strMsg) {
                isProfileSuccess=isError;
                if (isError)
                {
                    //[self displayErrorWithMessage:strMsg];
                }
                else
                {
                    NSLog(@"success");
                    [tblSecondSteps reloadData ];
                }
            }];
        });
    }
    else
    {
        imgCoverPic=info[UIImagePickerControllerOriginalImage] ;
        dispatch_async(dispatch_get_main_queue(), ^{
            [[CreateTagsUploadCoverPicService service]callCreateTagsCoverPicUploadServiceWithLivingTagsID:self.strTemplateID user_ID:appDel.objUser.strUserID coverImage:imgCoverPic withCompletionHandler:^(id  _Nullable result, BOOL isError, NSString * _Nullable strMsg) {
                isCoverSuccess=isError;
                if (isError)
                {
                   // [self displayErrorWithMessage:strMsg];
                }
                else
                {
                    NSLog(@"success");
                    [tblSecondSteps reloadData ];
                }
            }];
        });
    }
    [picker dismissViewControllerAnimated:YES completion:^{
    }] ;
}

#pragma mark
#pragma mark UPDATE DICTIONARY FOR API SERVICE
#pragma mark

-(void)checkName
{
    NSLog(@"%@",objTemplates);
    if (objTemplates)
    {
        NSLog(@"%@",objTemplates.strName);
        if ([objTemplates.strName isEqualToString:strName])
        {
            [dictAPI removeObjectForKey:@"name"];
        }
        else
        {
            [dictAPI setObject:strName forKey:@"name"];
            [self updateDictionaryForServiceForKey:@"name"];
        }
    }
    else
    {
        [dictAPI setObject:strName forKey:@"name"];
        [self updateDictionaryForServiceForKey:@"name"];
    }
    btnPreview.hidden=NO;
}

-(void)checkDatesFrom
{
    if (objTemplates)
    {
        NSLog(@"%@",objTemplates.strBorn);
        if ([objTemplates.strBorn isEqualToString:strDateFrom])
        {
            [dictAPI removeObjectForKey:@"born"];
        }
        else
        {
            [dictAPI setObject:strDateFrom forKey:@"born"];
            [self updateDictionaryForServiceForKey:@"born"];
        }
    }
    else
    {
        [dictAPI setObject:strDateFrom forKey:@"born"];
        [self updateDictionaryForServiceForKey:@"born"];
    }
}

-(void)checkGender
{
    if (objTemplates)
    {
        if ([objTemplates.strGender isEqualToString:strGender])
        {
            [dictAPI removeObjectForKey:@"gender"];
        }
        else
        {
            [dictAPI setObject:strGender forKey:@"gender"];
            [self updateDictionaryForServiceForKey:@"gender"];
        }
    }
    else
    {
        [dictAPI setObject:strGender forKey:@"gender"];
        [self updateDictionaryForServiceForKey:@"gender"];
    }
}

-(void)checkMemorialQuotes
{
    if (objTemplates)
    {
        if ([objTemplates.strMemorialQuote isEqualToString:strMemorialQuote])
        {
            [dictAPI removeObjectForKey:@"memorial_quote"];
        }
        else
        {
            [dictAPI setObject:strMemorialQuote forKey:@"memorial_quote"];
            [self updateDictionaryForServiceForKey:@"memorial_quote"];
        }
    }
    else
    {
        [dictAPI setObject:strMemorialQuote forKey:@"memorial_quote"];
        [self updateDictionaryForServiceForKey:@"memorial_quote"];
    }
}

-(void)checkLocationWithType:(NSString *)str
{
    if ([str isEqualToString:@"First"])
    {
        if (objTemplates)
        {
            if ([objTemplates.strAddress1 isEqualToString:strPrimaryLocation])
            {
                [dictAPI removeObjectForKey:@"address1"];
                if ([objTemplates.strLat1 isEqualToString:strLatitude1])
                {
                    [dictAPI removeObjectForKey:@"lat1"];
                }
                if ([objTemplates.strLong1 isEqualToString:strLatitude1])
                {
                    //long1
                    [dictAPI removeObjectForKey:@"long1"];
                }
            }
            else
            {
                [dictAPI setObject:strPrimaryLocation forKey:@"address1"];
                [dictAPI setObject:strLatitude1 forKey:@"lat1"];
                [dictAPI setObject:strLongitude1 forKey:@"long1"];
                [self updateDictionaryForServiceForKey:@"address1"];
            }
        }
        else
        {
            [dictAPI setObject:strPrimaryLocation forKey:@"address1"];
            [dictAPI setObject:strLatitude1 forKey:@"lat1"];
            [dictAPI setObject:strLongitude1 forKey:@"long1"];
            [self updateDictionaryForServiceForKey:@"address1"];
        }
    }
    else if([str isEqualToString:@"Second"])
    {
        //address2 lat2 long2
        if (objTemplates)
        {
            if ([objTemplates.strAddress2 isEqualToString:strSecondLocation])
            {
                [dictAPI removeObjectForKey:@"address2"];
                if ([objTemplates.strLat2 isEqualToString:strLatitude2])
                {
                    [dictAPI removeObjectForKey:@"lat2"];
                }
                if ([objTemplates.strLong2 isEqualToString:strLongitude2])
                {
                    //long1
                    [dictAPI removeObjectForKey:@"long2"];
                }
            }
            else
            {
                [dictAPI setObject:strSecondLocation forKey:@"address2"];
                [dictAPI setObject:strLatitude2 forKey:@"lat2"];
                [dictAPI setObject:strLongitude2 forKey:@"long2"];
                [self updateDictionaryForServiceForKey:@"address2"];
            }
        }
        else
        {
            [dictAPI setObject:strSecondLocation forKey:@"address2"];
            [dictAPI setObject:strLatitude2 forKey:@"lat2"];
            [dictAPI setObject:strLongitude2 forKey:@"long2"];
            [self updateDictionaryForServiceForKey:@"address2"];
        }
    }
    else
    {
        if (objTemplates)
        {
            //address3 lat3 long3
            if ([objTemplates.strAddress3 isEqualToString:strThirdLocation])
            {
                [dictAPI removeObjectForKey:@"address3"];
                if ([objTemplates.strLat3 isEqualToString:strLatitude3])
                {
                    [dictAPI removeObjectForKey:@"lat3"];
                }
                if ([objTemplates.strLong3 isEqualToString:strLongitude3])
                {
                    //long1
                    [dictAPI removeObjectForKey:@"long3"];
                }
            }
            else
            {
                [dictAPI setObject:strThirdLocation forKey:@"address3"];
                [dictAPI setObject:strLatitude3 forKey:@"lat3"];
                [dictAPI setObject:strLongitude3 forKey:@"long3"];
                [self updateDictionaryForServiceForKey:@"address3"];
            }
        }
        else
        {
            [dictAPI setObject:strThirdLocation forKey:@"address3"];
            [dictAPI setObject:strLatitude3 forKey:@"lat3"];
            [dictAPI setObject:strLongitude3 forKey:@"long3"];
            [self updateDictionaryForServiceForKey:@"address3"];
        }
    }
}


-(void)checkDatesTo
{
    if (objTemplates)
    {
        if ([objTemplates.strDied isEqualToString:strDateTo])
        {
            [dictAPI removeObjectForKey:@"died"];
        }
        else
        {
            [dictAPI setObject:strDateTo forKey:@"died"];
            [self updateDictionaryForServiceForKey:@"died"];
        }
    }
    else
    {
        [dictAPI setObject:strDateTo forKey:@"died"];
        [self updateDictionaryForServiceForKey:@"died"];
    }
}

-(void)updateDictionaryForServiceForKey:(NSString *)strKey
{
    NSLog(@"%@",dictAPI);
    [[LivingTagsSecondStepService service]callSecondStepServiceWithDIctionary:dictAPI UserID:appDel.objUser.strUserID livingTagsID:self.strTemplateID withCompletionHandler:^(id  _Nullable result, BOOL isError, NSString * _Nullable strMsg) {
        if (isError)
        {
            [self displayErrorWithMessage:strMsg];
        }
        else
        {
            NSLog(@"%@",result);
            if ([strKey isEqualToString:@"address1"])
            {
                //address1 lat1 long1
                [dictAPI removeObjectForKey:@"address1"];
                [dictAPI removeObjectForKey:@"lat1"];
                [dictAPI removeObjectForKey:@"long1"];
            }
            else if ([strKey isEqualToString:@"address2"])
            {
                //address2 lat2 long2
                [dictAPI removeObjectForKey:@"address2"];
                [dictAPI removeObjectForKey:@"lat2"];
                [dictAPI removeObjectForKey:@"long2"];
            }
            else if ([strKey isEqualToString:@"address3"])
            {
                //address3 lat3 long3
                [dictAPI removeObjectForKey:@"address3"];
                [dictAPI removeObjectForKey:@"lat3"];
                [dictAPI removeObjectForKey:@"long3"];
            }
            else
            {
                [dictAPI removeObjectForKey:strKey];
            }
            if ([result isKindOfClass:[NSDictionary class]])
            {
                NSMutableDictionary *dict=(id)result;
                objTemplates=[[ModelCreateTagsSecondStep alloc]initWithDictionary:dict];
            }
            else
            {
                objTemplates=nil;
            }
        }
    }];
}

#pragma mark
#pragma mark PREPARE FOR SEGUE
#pragma mark

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"segueThirdStep"])
    {
        LivingTagsThirdStepViewController *master=[segue destinationViewController];
        master.strTempID=self.strTemplateID;
    }
}

#pragma mark
#pragma mark ADD CUSTOM POP UP
#pragma mark

-(void)addCustomPOPUP
{
    customPopUP=[[CustomPopUpViewController alloc] initWithNibName:@"CustomPopUpViewController" bundle:nil];
    customPopUP.view.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:customPopUP.view];
    [self addChildViewController:customPopUP];
    customPopUP.delegate=self;
    [customPopUP didMoveToParentViewController:self];
}

#pragma mark
#pragma mark CUSTOM POP UP DELEGATES
#pragma mark

-(void)takePictureFromCamera
{
    [customPopUP.view removeFromSuperview];
    [self imageUploadFromCamera];
}

-(void)takePictureFromGallery
{
    [customPopUP.view removeFromSuperview];
    [self imageUploadFromGallery];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [customPopUP removeFromParentViewController];
    customPopUP=nil;
    [datePicker removeFromParentViewController];
    datePicker=nil;
}

#pragma mark
#pragma mark Date PIcker appear and delegate
#pragma mark

-(void)showDatePickerWithTextFieldTag:(NSInteger)i
{
    datePicker=[[DatePickerViewController alloc]initWithNibName:@"DatePickerViewController" bundle:nil];
    datePicker.textfieldTag=i;
    datePicker.view.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:datePicker.view];
    [self addChildViewController:datePicker];
    [datePicker didMoveToParentViewController:self];
    datePicker.delegate=self;
}

-(void)selectedDateWithValue:(NSString *)strDate withTag:(NSInteger)i
{
    NSLog(@"%d",i);
    if (i==3)
    {
         strDateFrom=strDate;
         [self checkDatesFrom];
    }
    else
    {
        strDateTo=strDate;
      //  [self checkDatesTo];
        if (strDateFrom.length>0 && strDateTo.length>0)
        {
            NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init] ;
            [dateFormatter setDateFormat:@"yyyy-MM-dd"] ;
            NSDate *date1 = [dateFormatter dateFromString:strDateFrom] ;
            NSDate *date2 = [dateFormatter dateFromString:strDateTo] ;
            NSLog(@"date1=%@ date2=%@",date1,date2) ;
            NSTimeInterval interval1  = [date1 timeIntervalSince1970] ;
            NSTimeInterval interval2  = [date2 timeIntervalSince1970] ;
            float diff=interval2-interval1;
            if (diff>=0)
            {
                [self checkDatesTo];
                [self updateTableView:3];
            }
            else
            {
                [self displayErrorWithMessage:@"Date of death should be more than the death of birth.."];
            }
        }
    }
    [tblSecondSteps reloadData];
}

@end
