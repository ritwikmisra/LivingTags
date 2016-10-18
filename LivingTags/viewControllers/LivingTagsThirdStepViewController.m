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
#import "CreateTagsThirdStepService.h"
#import "PreviewViewController.h"
#import "LivingTagsFourthStepViewController.h"
#import "ModelImageUpload.h"
#import "DatePickerViewController.h"

@interface LivingTagsThirdStepViewController ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,CollectionViewSelectionDelegate,SelectedDateDelegate>
{
    IBOutlet UILabel *lbl1;
    IBOutlet UILabel *lbl2;
    IBOutlet UILabel *lbl3;
    IBOutlet UILabel *lbl4;
    IBOutlet UITableView *tblAThirdStep;
    UIImageView *img;
    NSString *strDate1;
    NSMutableDictionary *dictPicDetails;
    BOOL isFirstImage,isSuccess;
    IBOutlet UIButton *btnPreview;
    int index;
    ModelImageUpload *objForTableView;
    CreateTagsThirdStepCell *cellDelegate;
    DatePickerViewController *datePicker;
}


@end

@implementation LivingTagsThirdStepViewController

//seguePreview
- (void)viewDidLoad
{
    [super viewDidLoad];
    isFirstImage=NO;
    btnPreview.hidden=YES;
    tblAThirdStep.separatorStyle=UITableViewCellSeparatorStyleNone;
    [tblAThirdStep setBounces:NO];
    appDel.arrCreateTagsUploadImage=[[NSMutableArray alloc]init];
    dictPicDetails=[[NSMutableDictionary alloc]init];
    index=0;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(imageUploadedToServer:) name:K_NOTIFICATION_CREATE_TAGS_IMAGES_UPLOAD object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(imageGalleryUploadError) name:K_NOTIFICATION_CREATE_TAGS_ERROR object:nil];
    if (appDel.dataVoice.length>0)
    {
        [dictPicDetails setObject:appDel.dataVoice forKey:@"4"];
    }
    NSLog(@"%@",appDel.dataVoice);
    [tblAThirdStep reloadData];
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
    NSLog(@"%@",appDel.arrSuccessUpload);
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
                [cellTags.btnBrowse addTarget:self action:@selector(btnUserBrowsePicClicked:) forControlEvents:UIControlEventTouchUpInside];
                break;
            }
            else
            {
                if (!cellTags)
                {
                    cellTags=[[[NSBundle mainBundle]loadNibNamed:@"CreateTagsThirdStepCell" owner:self options:nil] objectAtIndex:0];
                }
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
}

-(void)btnCalenderPressed:(id)sender
{
    [self showDatePickerWithTextFieldTag:[sender tag]];
}

-(void)btnRecordingPressed:(id)sender
{
    [self performSegueWithIdentifier:@"segueAudio" sender:self];
}

-(void)btnNext:(id)sender
{
    [self performSegueWithIdentifier:@"segueFourthStep" sender:self];
}

-(void)btnAddPhoto:(id)sender
{
    [self updateTableView:5];
    if (dictPicDetails.count>1)
    {
        [self callWebService];
    }
    else
    {
    }
    NSLog(@"%@",dictPicDetails);
}

-(IBAction)btnPreviewPressed:(id)sender
{
    [self performSegueWithIdentifier:@"seguePreview" sender:self];

}

#pragma mark
#pragma mark IMAGE PICKER CONTROLLER METHODS
#pragma mark


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
    UIImage *imgChosen=info[UIImagePickerControllerOriginalImage] ;
    [appDel.arrCreateTagsUploadImage addObject:imgChosen];
    [picker dismissViewControllerAnimated:YES completion:^{
        [appDel.arrSuccessUpload insertObject:@"0" atIndex:index];
        NSLog(@"%d",index);
        NSLog(@"%@",appDel.arrSuccessUpload);
        isFirstImage=YES;
        [tblAThirdStep reloadData ];
        [dictPicDetails setObject:imgChosen forKey:@"1"];
    }] ;
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
            [tblAThirdStep beginUpdates];
            NSArray *paths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:4 inSection:0]];
            [tblAThirdStep insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationFade];
            [tblAThirdStep endUpdates];
        }
    }
    else
    {
        if (appDel.arrStatus.count==5)
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
    NSLog(@"%@",dictPicDetails);
    if ([dictPicDetails objectForKey:@"3"] && [dictPicDetails objectForKey:@"1"])
    {
        btnPreview.hidden=NO;
        [[CreateTagsThirdStepService service]callThirdStepServiceWithImage:dictPicDetails livingTagsID:self.strTempID userID:appDel.objUser.strUserID withCompletionHandler:^(id  _Nullable result, BOOL isError, NSString * _Nullable strMsg) {
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
}


#pragma mark
#pragma mark PREPARE FOR SEGUE
#pragma mark

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"segueFourthStep"])
    {
        LivingTagsFourthStepViewController *master=[segue destinationViewController];
        master.strTempVidID=self.strTempID;
    }
}

#pragma mark
#pragma mark CUSTOM POP UP DELEGATES
#pragma mark

-(void)takePictureFromCamera
{
    [self imageUploadFromCamera];
}

-(void)takePictureFromGallery
{
    [self imageUploadFromGallery];
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
    [tblAThirdStep reloadData];
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
    [tblAThirdStep beginUpdates];
    [tblAThirdStep reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    [tblAThirdStep endUpdates];
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
    [tblAThirdStep reloadData];
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    cellDelegate.delegate=nil;
    [[NSNotificationCenter defaultCenter]removeObserver:self];
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
    strDate1=strDate;
    [dictPicDetails setObject:strDate1 forKey:@"3"];
    [self updateTableView:4];
    [tblAThirdStep reloadData];
}


@end
