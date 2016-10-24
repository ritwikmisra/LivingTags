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

@interface LivingTagsThirdStepViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,SelectedDateDelegate>
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
    dictPicDetails=[[NSMutableDictionary alloc]init];
    index=0;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(imageUploadedToServer:) name:K_NOTIFICATION_CREATE_TAGS_IMAGES_UPLOAD object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(imageGalleryUploadError) name:K_NOTIFICATION_CREATE_TAGS_ERROR object:nil];
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
#pragma mark IBACITONS
#pragma mark

-(void)btnUserBrowsePicClicked:(id)sender
{
    NSLog(@"preseed");
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
    
}


#pragma mark
#pragma mark update tableview
#pragma mark


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
}

-(void)imageGalleryUploadError
{
    [self displayErrorWithMessage:@"Something is wrong,please try again later."];
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [datePicker removeFromParentViewController];
    datePicker=nil;
}


@end
