//
//  LivingTagsFourthStepViewController.m
//  LivingTags
//
//  Created by appsbeetech on 05/08/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "LivingTagsFourthStepViewController.h"
#import "CreateTagsThirdStepCell.h"
#import "CreateTagsCell.h"
#import <CoreGraphics/CoreGraphics.h>
#import "CKCalendarView.h"
#import "CreateTagsThirdStepService.h"
#import "PreviewViewController.h"
#import <MediaPlayer/MPMoviePlayerController.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "LivingTagsFourthStepService.h"
#import "QRCodeViewController.h"

@interface LivingTagsFourthStepViewController ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,CKCalendarDelegate,UITextFieldDelegate>

{
    IBOutlet UILabel *lbl1;
    IBOutlet UILabel *lbl2;
    IBOutlet UILabel *lbl3;
    IBOutlet UILabel *lbl4;
    UIImageView *img;
    CKCalendarView *calendar;
    NSString *strDate;
    NSMutableDictionary *dictPicDetails;
    BOOL isFirstImage;
    IBOutlet UIButton *btnPreview;
    IBOutlet UITableView *tblFourthStep;
    NSString *strWebURI;
}

@property(nonatomic, weak) CKCalendarView *calendarCustom;
@property(nonatomic, strong) NSDateFormatter *dateFormatter;
@property(nonatomic, strong) NSDate *minimumDate;
@property(nonatomic, strong) NSArray *disabledDates;

@end

@implementation LivingTagsFourthStepViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    appDel.dataVoice=nil;
    [appDel.arrCreateTagsUploadImage removeAllObjects];
    [appDel.arrStatus removeAllObjects];
    [appDel.arrStatus addObject:@"1"];
    [appDel.arrStatus addObject:@"1"];
    [appDel.arrStatus addObject:@"1"];
    [appDel.arrStatus addObject:@"1"];

    isFirstImage=NO;
    btnPreview.hidden=YES;
    tblFourthStep.separatorStyle=UITableViewCellSeparatorStyleNone;
    [tblFourthStep setBounces:NO];
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
    NSLog(@"%@",appDel.dataVoice);
    if (appDel.dataVoice.length>0)
    {
        [dictPicDetails setObject:appDel.dataVoice forKey:@"4"];
    }
    [tblFourthStep reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (void)localeDidChange
{
    [self.calendarCustom setLocale:[NSLocale currentLocale]];
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
    return appDel.arrStatus.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case 0:
            if (isFirstImage==NO)
            {
                return 150.0f;
            }
            return 120.0f;
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
            if (isFirstImage==NO)
            {
                if (!cellTags)
                {
                    cellTags=[[[NSBundle mainBundle]loadNibNamed:@"CreateTagsThirdStepCell" owner:self options:nil] objectAtIndex:6];
                }
                cellTags.btnBrowse.tag=indexPath.row;
                cellTags.lbl.text=@"Add Videos";
                [cellTags.btnBrowse addTarget:self action:@selector(btnUserBrowsePicClicked:) forControlEvents:UIControlEventTouchUpInside];
                break;
            }
            else
            {
                if (!cellTags)
                {
                    cellTags=[[[NSBundle mainBundle]loadNibNamed:@"CreateTagsThirdStepCell" owner:self options:nil] objectAtIndex:0];
                }
                cellTags.lbl.text=@"Add Videos";
                break;
            }
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
            cellTags.lbl.text=@"When was the video taken?";
            cellTags.lblCalender.text=strDate;
            if ([dictPicDetails objectForKey:@"3"])
            {
                cellTags.lblCalender.text=[dictPicDetails objectForKey:@"3"];
            }
            else
            {
                cellTags.lblCalender.text=@"";
            }
            [cellTags.btnCalender addTarget:self action:@selector(btnCalenderPressed:) forControlEvents:UIControlEventTouchUpInside];
            break;

        case 3:
            if (!cellTags)
            {
                cellTags=[[[NSBundle mainBundle]loadNibNamed:@"CreateTagsThirdStepCell" owner:self options:nil] objectAtIndex:2];
            }
            cellTags.btnRecording.tag=indexPath.row;
            if ([dictPicDetails objectForKey:@"4"])
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
            [cellTags.btnAddPhoto setTitle:@"Add more videos" forState:UIControlStateNormal];
            [cellTags.btnAddPhoto addTarget:self action:@selector(btnAddPhoto:) forControlEvents:UIControlEventTouchUpInside];
            
            break;
            
        case 5:
            if (!cellTags)
            {
                cellTags=[[[NSBundle mainBundle]loadNibNamed:@"CreateTagsThirdStepCell" owner:self options:nil] objectAtIndex:5];
            }
            [cellTags.btnNext setTitle:@"Publish" forState:UIControlStateNormal];
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
    [self videoUploadPopUp];
}

-(void)btnCalenderPressed:(id)sender
{
    [self.view addSubview:calendar];
}

-(void)btnRecordingPressed:(id)sender
{
    [self performSegueWithIdentifier:@"segueVideoToAudio" sender:self];
}

-(void)btnNext:(id)sender
{
    //[self performSegueWithIdentifier:@"segueFourthStep" sender:self];
    [[LivingTagsFourthStepService service]callPublishDataWithPublish:@"P" livingTagsID:self.strTempVidID userID:appDel.objUser.strUserID withCompletionHandler:^(id  _Nullable result, BOOL isError, NSString * _Nullable strMsg) {
        if (isError)
        {
            [self displayErrorWithMessage:strMsg];
        }
        else
        {
            NSLog(@"%@",result);
            strWebURI=[NSString stringWithFormat:@"%@",result];
            [self performSegueWithIdentifier:@"segueQR" sender:self];
        }
    }];
}

-(void)btnAddPhoto:(id)sender
{
    [self updateTableView:5];
    [self performSelector:@selector(videoUploadPopUp) withObject:nil afterDelay:0.8f];
    // call webservice in a separate thread
    dispatch_async(dispatch_get_main_queue(), ^{
        if (dictPicDetails.count>0)
        {
            [self callWebService];
        }
    });
}

-(IBAction)btnPreviewPressed:(id)sender
{
    [self performSegueWithIdentifier:@"seguePreview" sender:self];
    
}


#pragma mark
#pragma mark update tableview
#pragma mark

-(void)updateTableView:(NSInteger)i
{
    if (i==4)
    {
        if (appDel.arrStatus.count==4)
        {
            [appDel.arrStatus addObject:@"1"];
            [tblFourthStep beginUpdates];
            NSArray *paths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:4 inSection:0]];
            [tblFourthStep insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationFade];
            [tblFourthStep endUpdates];
        }
    }
    else
    {
        if (appDel.arrStatus.count==5)
        {
            [appDel.arrStatus addObject:@"1"];
            [tblFourthStep beginUpdates];
            NSArray *paths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:5 inSection:0]];
            [tblFourthStep insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationFade];
            [tblFourthStep endUpdates];
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
    [dictPicDetails setObject:strDate forKey:@"3"];
    [self.calendarCustom removeFromSuperview];
    [self updateTableView:4];
    [tblFourthStep reloadData];
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
    if ([dictPicDetails objectForKey:@"3"] && [dictPicDetails objectForKey:@"1"])
    {
        [[LivingTagsFourthStepService service]callThirdStepServiceWithImage:dictPicDetails livingTagsID:self.strTempVidID userID:appDel.objUser.strUserID withCompletionHandler:^(id  _Nullable result, BOOL isError, NSString * _Nullable strMsg) {
        }];
    }
    else
    {
        [self displayErrorWithMessage:@"Please give atleast one photo and the date of the picture.."];
    }
    [dictPicDetails removeAllObjects];
    appDel.dataVoice=nil;   
    NSLog(@"%@",dictPicDetails);
    [tblFourthStep reloadData];
}

#pragma mark
#pragma mark PREPARE FOR SEGUE
#pragma mark

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"segueQR"])
    {
        QRCodeViewController *master=[segue destinationViewController];
        master.strWebURI=strWebURI;
        NSLog(@"%@",master.strWebURI);
    }
}


#pragma mark
#pragma mark IMAGE PICKER CONTROLLER METHODS
#pragma mark

-(void)videoUploadPopUp
{
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"Please select the image from gallery or click it from your camera.." message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionCamera=[UIAlertAction actionWithTitle:@"CAMERA" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self videoUploadFromCamera];
    }];
    UIAlertAction *actionGallery=[UIAlertAction actionWithTitle:@"GALLERY" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self videoUploadFromGallery];
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

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //    NSURL *videoURL = info[UIImagePickerControllerMediaURL];
    //    [picker dismissViewControllerAnimated:YES completion:NULL];
    //    NSLog(@"%@",videoURL);
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
            [dictPicDetails setObject:videoData forKey:@"1"];
            NSLog(@"%lu",(unsigned long)videoData.length);
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
                UIImage *thumbnail = [UIImage imageWithCGImage:imageRef];
                [appDel.arrCreateTagsUploadImage addObject:thumbnail];
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
            [dictPicDetails setObject:videoData forKey:@"1"];
            NSLog(@"%lu",(unsigned long)videoData.length);
            AVAsset *asset = [AVAsset assetWithURL:videoURL];
            AVAssetImageGenerator *imageGenerator = [[AVAssetImageGenerator alloc]initWithAsset:asset];
            CMTime time = CMTimeMake(1, 1);
            CGImageRef imageRef = [imageGenerator copyCGImageAtTime:time actualTime:NULL error:NULL];
            UIImage *thumbnail = [UIImage imageWithCGImage:imageRef];
            [appDel.arrCreateTagsUploadImage addObject:thumbnail];
            CGImageRelease(imageRef);
        }
    }
    [picker dismissViewControllerAnimated:YES completion:^{
        isFirstImage=YES;
        [tblFourthStep reloadData];
    }];
}

@end
