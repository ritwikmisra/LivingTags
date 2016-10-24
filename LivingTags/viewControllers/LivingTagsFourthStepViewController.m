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
#import "ModelImageUpload.h"
#import "DatePickerViewController.h"


@interface LivingTagsFourthStepViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,SelectedDateDelegate>
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

    isFirstImage=NO;
    btnPreview.hidden=YES;
    tblFourthStep.separatorStyle=UITableViewCellSeparatorStyleNone;
    [tblFourthStep setBounces:NO];
    dictPicDetails=[[NSMutableDictionary alloc]init];
    index=0;
}

-(void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(imageUploadedToServer:) name:K_NOTIFICATION_CREATE_TAGS_IMAGES_UPLOAD object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(imageGalleryUploadError) name:K_NOTIFICATION_CREATE_TAGS_ERROR object:nil];
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
}

-(IBAction)btnPreviewPressed:(id)sender
{
    [self performSegueWithIdentifier:@"seguePreview" sender:self];
    
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

#pragma mark
#pragma mark CUSTOM POP UP DELEGATES
#pragma mark

-(void)takePictureFromCamera
{
    [self videoUploadFromCamera];
}

-(void)takePictureFromGallery
{

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
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
    index++;
    [dictPicDetails removeAllObjects];
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
    [tblFourthStep reloadData];
}

@end
