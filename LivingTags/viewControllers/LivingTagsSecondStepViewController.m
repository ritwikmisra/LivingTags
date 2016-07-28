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

@interface LivingTagsSecondStepViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UITextViewDelegate,CKCalendarDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    IBOutlet UILabel *lbl1;
    IBOutlet UILabel *lbl2;
    IBOutlet UILabel *lbl3;
    IBOutlet UILabel *lbl4;
    IBOutlet UITableView *tblSecondSteps;
    NSMutableArray *arrStatus;
    NSString *strGender,*strDateFrom,*strDateTo,*strName,*strMemorialQuote;
    CKCalendarView *calendar;
    int textTag,btnUserPicTag;
    UIImageView *img;
    UIImage *imgChosen,*imgCoverPic;
    NSMutableDictionary *dictAPI;
    BOOL isAPICalling;
    ModelCreateTagsSecondStep *objTemplates;
    IBOutlet UIButton *btnNext;
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
    isAPICalling=NO;
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
    btnNext.hidden=YES;
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
            img=cellTags.imgUser;
            if (imgChosen)
            {
                cellTags.imgUser.image=imgChosen;
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
            cellTags.txtDateFrom.text=strDateFrom;
            cellTags.txtDateTo.text=strDateTo;
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
            img=cellTags.imgCover;
            if (imgCoverPic)
            {
                cellTags.imgCover.image=imgCoverPic;
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
            if (strMemorialQuote.length>0)
            {
                cellTags.txtVwMemorialQuote.text=strMemorialQuote;
            }
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
        [self.view addSubview:calendar];
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
    [self checkName];
    strGender=@"M";
    CreateTagsSecondStepCell *cell=(CreateTagsSecondStepCell *)[self getSuperviewOfType:[UITableViewCell class] fromView:sender];
    [cell.imgMale setImage:[UIImage imageNamed:@"radio_btn2"]];
    [cell.imgFemale setImage:[UIImage imageNamed:@"radio_btn1"]];
    [self updateTableView:[sender tag]];
}


-(void)btnFemalePressed:(id)sender
{
    [self.view endEditing:YES];
    [self checkName];
    strGender=@"F";
    CreateTagsSecondStepCell *cell=(CreateTagsSecondStepCell *)[self getSuperviewOfType:[UITableViewCell class] fromView:sender];
    [cell.imgMale setImage:[UIImage imageNamed:@"radio_btn1"]];
    [cell.imgFemale setImage:[UIImage imageNamed:@"radio_btn2"]];
    [self updateTableView:[sender tag]];
}


-(void)btnUserPicSelected:(id)sender
{
    btnUserPicTag=(int)[sender tag];
    [self updateTableView:[sender tag]];
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"Please select the image from gallery or click it from your camera.." message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *actionCamera=[UIAlertAction actionWithTitle:@"CAMERA" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self imageUploadFromCamera];
    }];
    UIAlertAction *actionGallery=[UIAlertAction actionWithTitle:@"GALLERY" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self imageUploadFromGallery];
    }];
    UIAlertAction *actionCancel=[UIAlertAction actionWithTitle:@"CANCEL" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [alertController dismissViewControllerAnimated:YES completion:^{
            
        }];
    }];
    [alertController addAction:actionCamera];
    [alertController addAction:actionGallery];
    [alertController addAction:actionCancel];
    [alertController setModalPresentationStyle:UIModalPresentationPopover];
    
    UIPopoverPresentationController *popPresenter = [alertController
                                                     popoverPresentationController];
    popPresenter.sourceView = img;
    popPresenter.sourceRect = img.bounds;
    [self presentViewController:alertController animated:YES completion:nil];
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
    btnUserPicTag=(int)[sender tag];
    [self updateTableView:[sender tag]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self setTableviewContentOffsetWithView:@"coverPic"];
    });
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"Please select the image from gallery or click it from your camera.." message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *actionCamera=[UIAlertAction actionWithTitle:@"CAMERA" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self imageUploadFromCamera];
    }];
    UIAlertAction *actionGallery=[UIAlertAction actionWithTitle:@"GALLERY" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self imageUploadFromGallery];
    }];
    UIAlertAction *actionCancel=[UIAlertAction actionWithTitle:@"CANCEL" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [alertController dismissViewControllerAnimated:YES completion:^{
            
        }];
    }];
    [alertController addAction:actionCamera];
    [alertController addAction:actionGallery];
    [alertController addAction:actionCancel];
    [alertController setModalPresentationStyle:UIModalPresentationPopover];
    
    UIPopoverPresentationController *popPresenter = [alertController
                                                     popoverPresentationController];
    popPresenter.sourceView = img;
    popPresenter.sourceRect = img.bounds;
    [self presentViewController:alertController animated:YES completion:nil];
}

-(IBAction)btnNextPressed:(id)sender
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
    picker.allowsEditing=YES;
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
        picker.allowsEditing=YES ;
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
    }
    else
    {
        imgCoverPic=info[UIImagePickerControllerEditedImage] ;
    }
    [picker dismissViewControllerAnimated:YES completion:^{
        [tblSecondSteps reloadData ];
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
    btnNext.hidden=NO;
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
            
        }
        else
        {
            NSLog(@"%@",result);
            [dictAPI removeObjectForKey:strKey];
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

@end
