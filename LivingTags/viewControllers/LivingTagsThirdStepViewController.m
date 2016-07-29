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
#import <CoreGraphics/CoreGraphics.h>
#import "CKCalendarView.h"
#import "CreateTagsThirdStepService.h"

@interface LivingTagsThirdStepViewController ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,CKCalendarDelegate,UITextFieldDelegate>
{
    IBOutlet UILabel *lbl1;
    IBOutlet UILabel *lbl2;
    IBOutlet UILabel *lbl3;
    IBOutlet UILabel *lbl4;
    IBOutlet UITableView *tblAThirdStep;
    UIImageView *img;
    CKCalendarView *calendar;
    NSString *strDate;
    NSMutableDictionary *dictPicDetails;
}

@property(nonatomic, weak) CKCalendarView *calendarCustom;
@property(nonatomic, strong) NSDateFormatter *dateFormatter;
@property(nonatomic, strong) NSDate *minimumDate;
@property(nonatomic, strong) NSArray *disabledDates;

@end

@implementation LivingTagsThirdStepViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    tblAThirdStep.separatorStyle=UITableViewCellSeparatorStyleNone;
    [tblAThirdStep setBounces:NO];
    appDel.arrCreateTagsUploadImage=[[NSMutableArray alloc]init];
    calendar = [[CKCalendarView alloc] init];
    self.calendarCustom = calendar;
    calendar.delegate = self;
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat:@"yyyy-MM-dd"];
    self.minimumDate = [self.dateFormatter dateFromString:@"1950-11-01"];
    
    calendar.onlyShowCurrentMonth = NO;
    calendar.adaptHeightToNumberOfWeeksInMonth = YES;
    
    calendar.frame = CGRectMake(0, 30, [[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(localeDidChange) name:NSCurrentLocaleDidChangeNotification object:nil];
    dictPicDetails=[[NSMutableDictionary alloc]init];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"%@",appDel.dataVoice);
    if (appDel.dataVoice.length>0)
    {
        [dictPicDetails setObject:appDel.dataVoice forKey:@"4"];
    }
    [tblAThirdStep reloadData];
}

- (void)localeDidChange
{
    [self.calendarCustom setLocale:[NSLocale currentLocale]];
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
    return appDel.arrStatus.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case 0:
            return 150.0f;
            break;
            
        case 1:
            return 50.0f;
            break;
            
        case 4:
            return 40.0f;
            break;
            
        case 5:
            return 40.0f;
            break;

        default:
            return 60.0f;
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
                cellTags=[[[NSBundle mainBundle]loadNibNamed:@"CreateTagsThirdStepCell" owner:self options:nil] objectAtIndex:0];
            }
            cellTags.btnBrowse.tag=indexPath.row;
            [cellTags.btnBrowse addTarget:self action:@selector(btnUserBrowsePicClicked:) forControlEvents:UIControlEventTouchUpInside];
            break;
            
        case 1:
            if (!cellTags)
            {
                cellTags=[[[NSBundle mainBundle]loadNibNamed:@"CreateTagsThirdStepCell" owner:self options:nil] objectAtIndex:4];
            }
            cellTags.txtCaptions.delegate=self;
            if ([dictPicDetails objectForKey:@"2"])
            {
                cellTags.txtCaptions.text=[dictPicDetails objectForKey:@"2"];
           }
            [cellTags.txtCaptions addTarget:self action:@selector(textfieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
            break;
             
        case 2:
            if (!cellTags)
            {
                cellTags=[[[NSBundle mainBundle]loadNibNamed:@"CreateTagsThirdStepCell" owner:self options:nil] objectAtIndex:1];
            }
            cellTags.btnCalender.tag=indexPath.row;
            cellTags.lblCalender.text=strDate;
            if ([dictPicDetails objectForKey:@"3"])
            {
                cellTags.lblCalender.text=[dictPicDetails objectForKey:@"3"];

            }
            [cellTags.btnCalender addTarget:self action:@selector(btnCalenderPressed:) forControlEvents:UIControlEventTouchUpInside];
            break;
            
        case 3:
            if (!cellTags)
            {
                cellTags=[[[NSBundle mainBundle]loadNibNamed:@"CreateTagsThirdStepCell" owner:self options:nil] objectAtIndex:2];
            }
            cellTags.btnRecording.tag=indexPath.row;
            if (appDel.dataVoice.length>0)
            {
                cellTags.lblRecording.text=@"MyRecording.m4a";
            }
            else
            {
                cellTags.lblRecording.text=@"No recording voice";
            }
            [cellTags.btnRecording addTarget:self action:@selector(btnRecordingPressed:) forControlEvents:UIControlEventTouchUpInside];
            break;
            
        case 4:
            if (!cellTags)
            {
                cellTags=[[[NSBundle mainBundle]loadNibNamed:@"CreateTagsThirdStepCell" owner:self options:nil] objectAtIndex:3];
            }
            [cellTags.btnAddPhoto addTarget:self action:@selector(btnAddPhoto:) forControlEvents:UIControlEventTouchUpInside];

            break;

        case 5:
            if (!cellTags)
            {
                cellTags=[[[NSBundle mainBundle]loadNibNamed:@"CreateTagsThirdStepCell" owner:self options:nil] objectAtIndex:5];
            }
            [cellTags.btnNext addTarget:self action:@selector(btnNext:) forControlEvents:UIControlEventTouchUpInside];
            
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
    NSLog(@"preseed");
    [self imageUploadPopUp];
}

-(void)btnCalenderPressed:(id)sender
{
    [self.view addSubview:calendar];
}

-(void)btnRecordingPressed:(id)sender
{
    [self performSegueWithIdentifier:@"segueAudio" sender:self];
}

-(void)btnNext:(id)sender
{

}

-(void)btnAddPhoto:(id)sender
{
    [self updateTableView:5];
}

#pragma mark
#pragma mark IMAGE PICKER CONTROLLER METHODS
#pragma mark

-(void)imageUploadPopUp
{
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"Please select the image from gallery or click it from your camera.." message:nil preferredStyle:UIAlertControllerStyleAlert];
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
    [self presentViewController:alertController animated:YES completion:^{
        
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

-(void)imageUploadFromGallery
{
    UIImagePickerController *picker=[[UIImagePickerController alloc] init];
    picker.delegate=self;
    picker.allowsEditing=YES;
    picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:^{
        
    }];
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *imgChosen=info[UIImagePickerControllerEditedImage] ;
    [appDel.arrCreateTagsUploadImage addObject:imgChosen];
    [picker dismissViewControllerAnimated:YES completion:^{
        [tblAThirdStep reloadData ];
        [dictPicDetails setObject:imgChosen forKey:@"1"];
    }] ;
}

-(void)uploadImage:(UIImage *)img1
{
    [[CreateTagsThirdStepService service]callThirdStepServiceWithImage:img1 livingTagsID:self.strTempID userID:appDel.objUser.strUserID withCompletionHandler:^(id  _Nullable result, BOOL isError, NSString * _Nullable strMsg) {
        NSLog(@"%@",result);
    }];
}
#pragma mark
#pragma mark update tableview
#pragma mark

-(void)updateTableView:(NSInteger)i
{
    if (i==4)
    {
        if (appDel.arrStatus.count<=5)
        {
            [appDel.arrStatus addObject:@"1"];
            [tblAThirdStep beginUpdates];
            NSArray *paths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:4 inSection:0]];
            [tblAThirdStep insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationFade];
            [tblAThirdStep endUpdates];
            
        }
    }
    else
    {
        if (appDel.arrStatus.count<=6)
        {
            [appDel.arrStatus addObject:@"1"];
            [tblAThirdStep beginUpdates];
            NSArray *paths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:5 inSection:0]];
            [tblAThirdStep insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationFade];
            [tblAThirdStep endUpdates];
        }
    }
}

#pragma mark
#pragma mark CKCALENDER METHODS
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
    strDate=[self.dateFormatter stringFromDate:date];
    [self.calendarCustom removeFromSuperview];
    [tblAThirdStep reloadData];
    [self updateTableView:4];
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
#pragma mark textfield delegates
#pragma mark


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

-(void)textfieldEditingChanged:(id)sender
{
    UITextField *text=(id)sender;
    [dictPicDetails setObject:text.text forKey:@"2"];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark
#pragma mark webservice called
#pragma mark

-(void)callWebService
{
    
}

@end
