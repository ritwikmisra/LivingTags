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
#import "CreateTagsThirdStepService.h"
#import "PreviewViewController.h"
#import <MediaPlayer/MPMoviePlayerController.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "LivingTagsFourthStepService.h"
#import "QRCodeViewController.h"
#import "CustomPopUpViewController.h"
#import "ModelImageUpload.h"
#import "DatePickerViewController.h"


@interface LivingTagsFourthStepViewController ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,CustomPopUPDelegate,CollectionViewSelectionDelegate,SelectedDateDelegate>
{
    IBOutlet UILabel *lbl1;
    IBOutlet UILabel *lbl2;
    IBOutlet UILabel *lbl3;
    IBOutlet UILabel *lbl4;
    UIImageView *img;
    NSString *strDate1;
    NSMutableDictionary *dictPicDetails;
    BOOL isFirstImage,isSuccess;
    IBOutlet UIButton *btnPreview;
    IBOutlet UITableView *tblFourthStep;
    NSString *strWebURI;
    CustomPopUpViewController *customPopUpController;
    int index;
    ModelImageUpload *objForTableView;
    CreateTagsThirdStepCell *cellDelegate;
    DatePickerViewController *datePicker;

}


@end

@implementation LivingTagsFourthStepViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    appDel.dataVoice=nil;
    [appDel.arrCreateTagsUploadImage removeAllObjects];
    [appDel.arrImageUpload removeAllObjects];
    [appDel.arrSuccessUpload removeAllObjects];
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
    dictPicDetails=[[NSMutableDictionary alloc]init];
    index=0;
}

-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"%@",appDel.dataVoice);
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(imageUploadedToServer:) name:K_NOTIFICATION_CREATE_TAGS_IMAGES_UPLOAD object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(imageGalleryUploadError) name:K_NOTIFICATION_CREATE_TAGS_ERROR object:nil];
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
    if (___isIphone6Plus || ___isIphone6)
    {
        switch (indexPath.row)
        {
            case 0:
                if (isFirstImage==NO)
                {
                    return 170.0f;
                }
                return 140.0f;
                break;
            case 1:
                return 70.0f;
                break;
                
            case 4:
                return 60.0f;
                break;
                
            case 5:
                return 60.0f;
                break;
                
            default:
                return 80.0f;
                break;
        }
    }
    else
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
                cellTags.delegate=self;
                cellDelegate=cellTags;
                break;
            }
        case 1:
            if (!cellTags)
            {
                cellTags=[[[NSBundle mainBundle]loadNibNamed:@"CreateTagsThirdStepCell" owner:self options:nil] objectAtIndex:4];
            }
            cellTags.txtCaptions.delegate=self;
            if (isSuccess==YES)
            {
                if (objForTableView.strTitle.length>0)
                {
                    cellTags.txtCaptions.text=objForTableView.strTitle;
                }
                cellTags.txtCaptions.userInteractionEnabled=NO;
            }
            else
            {
                cellTags.txtCaptions.userInteractionEnabled=YES;
                if ([dictPicDetails objectForKey:@"2"])
                {
                    cellTags.txtCaptions.text=[dictPicDetails objectForKey:@"2"];
                }
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
            //cellTags.lblCalender.text=strDate;
            if (isSuccess==YES)
            {
                if (objForTableView.strDateTaken.length>0)
                {
                    cellTags.lblCalender.text=objForTableView.strDateTaken;
                }
                cellTags.btnCalender.userInteractionEnabled=NO;
            }
            else
            {
                cellTags.btnCalender.userInteractionEnabled=YES;
                if ([dictPicDetails objectForKey:@"3"])
                {
                    cellTags.lblCalender.text=[dictPicDetails objectForKey:@"3"];
                }
                else
                {
                    cellTags.lblCalender.text=@"";
                    
                }
            }
            [cellTags.btnCalender addTarget:self action:@selector(btnCalenderPressed:) forControlEvents:UIControlEventTouchUpInside];
            break;

        case 3:
            if (!cellTags)
            {
                cellTags=[[[NSBundle mainBundle]loadNibNamed:@"CreateTagsThirdStepCell" owner:self options:nil] objectAtIndex:2];
            }
            cellTags.btnRecording.tag=indexPath.row;
            if (isSuccess==YES)
            {
                cellTags.btnRecording.userInteractionEnabled=NO;
                if (objForTableView.strAudio.length>0)
                {
                    cellTags.lblRecording.text=objForTableView.strAudio;
                }
            }
            else
            {
                cellTags.btnRecording.userInteractionEnabled=YES;
                if ([dictPicDetails objectForKey:@"4"])
                {
                    cellTags.lblRecording.text=@"MyRecording.m4a";
                }
                else
                {
                    cellTags.lblRecording.text=@"No recording voice";
                }
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
    [self showDatePickerWithTextFieldTag:[sender tag]];
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
 /*   [self updateTableView:5];
    [self performSelector:@selector(videoUploadPopUp) withObject:nil afterDelay:0.8f];
    // call webservice in a separate thread
    dispatch_async(dispatch_get_main_queue(), ^{
        if (dictPicDetails.count>0)
        {
            [self callWebService];
        }
    });*/
    [self updateTableView:5];
    if (dictPicDetails.count>1)
    {
        [self callWebService];
    }
    else
    {
        [self videoUploadPopUp];
    }
    NSLog(@"%@",dictPicDetails);
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
            if (isError)
            {
                [self displayErrorWithMessage:strMsg];
            }
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
    customPopUpController=[[CustomPopUpViewController alloc] initWithNibName:@"CustomPopUpViewController" bundle:nil];
    customPopUpController.view.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:customPopUpController.view];
    [self addChildViewController:customPopUpController];
    customPopUpController.delegate=self;
    [customPopUpController didMoveToParentViewController:self];
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
            [appDel.arrSuccessUpload insertObject:@"0" atIndex:index];
            NSLog(@"%d",index);
            NSLog(@"%@",appDel.arrSuccessUpload);
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
            [appDel.arrSuccessUpload insertObject:@"0" atIndex:index];
            NSLog(@"%d",index);
            NSLog(@"%@",appDel.arrSuccessUpload);
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

#pragma mark
#pragma mark CUSTOM POP UP DELEGATES
#pragma mark

-(void)takePictureFromCamera
{
    [customPopUpController.view removeFromSuperview];
    [self videoUploadFromCamera];
}

-(void)takePictureFromGallery
{
    [customPopUpController.view removeFromSuperview];
    [self videoUploadFromGallery];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [customPopUpController removeFromParentViewController];
    customPopUpController=nil;
    cellDelegate.delegate=nil;
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [datePicker removeFromParentViewController];
    datePicker=nil;
}

#pragma mark
#pragma mark NOTIFICATION METHOD
#pragma mark

-(void)imageUploadedToServer:(NSNotification*)note
{
    NSDictionary *theData = [note userInfo];
    NSLog(@"%@",theData);
    ModelImageUpload *obj=[[ModelImageUpload alloc]initWithDictionary:theData];
    [appDel.arrImageUpload addObject:obj];
    NSLog(@"%@",appDel.arrSuccessUpload);
    [appDel.arrSuccessUpload replaceObjectAtIndex:index withObject:@"1"];
    index++;
    [dictPicDetails removeAllObjects];
    appDel.dataVoice=nil;
    NSLog(@"%@",dictPicDetails);
    [tblFourthStep reloadData];
    [self videoUploadPopUp];
}

-(void)imageGalleryUploadError
{
    [self displayErrorWithMessage:@"Something is wrong,please try again later."];
}

#pragma mark
#pragma mark CUSTOM DELEGATE METHODS
#pragma mark

-(void)didSelectCollectionViewWithRow:(NSInteger)rowNumber
{
    NSLog(@"ROW NUMBER=%d \n ARRAY COUNT=%d",rowNumber,appDel.arrImageUpload.count);
    if (appDel.arrSuccessUpload.count>0)
    {
        if ([[appDel.arrSuccessUpload objectAtIndex:rowNumber]isEqualToString:@"1"])
        {
            isSuccess=YES;
        }
        else
        {
            isSuccess=NO;
        }
    }
    else
    {
        isSuccess=NO;
    }
    if (appDel.arrImageUpload.count>0)
    {
        if (rowNumber<appDel.arrImageUpload.count)
        {
            objForTableView=[appDel.arrImageUpload objectAtIndex:rowNumber];
        }
    }
    //[tblAThirdStep reloadData];
    // update tableview according to collection view index path selection
    NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:1 inSection:0];
    NSIndexPath *indexPath2 = [NSIndexPath indexPathForRow:2 inSection:0];
    NSIndexPath *indexPath3 = [NSIndexPath indexPathForRow:3 inSection:0];
    NSArray *indexPaths = [[NSArray alloc] initWithObjects:indexPath1,indexPath2,indexPath3,nil];
    [tblFourthStep beginUpdates];
    [tblFourthStep reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    [tblFourthStep endUpdates];
}

-(void)deleteImageWithButtonTag:(NSInteger)btnTag
{
    [appDel.arrCreateTagsUploadImage removeObjectAtIndex:btnTag];
    [appDel.arrImageUpload removeObjectAtIndex:btnTag];
    [appDel.arrSuccessUpload removeObjectAtIndex:btnTag];
    index--;
    if (btnTag>0)
    {
        NSLog(@"%d",btnTag-1);
        objForTableView=[appDel.arrImageUpload objectAtIndex:btnTag-1];
    }
    else
    {
        objForTableView=nil;
    }
    [tblFourthStep reloadData];
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
    strDate1=strDate;
    [dictPicDetails setObject:strDate1 forKey:@"3"];
    [self updateTableView:4];
    [tblFourthStep reloadData];
}

@end
