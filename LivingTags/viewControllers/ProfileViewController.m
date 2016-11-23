//  ProfileViewController.m
//  LivingTags
//
//  Created by appsbeetech on 28/04/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "ProfileViewController.h"
#import "UIImageView+WebCache.h"
#import "ProfileCell.h"
#import "UIImageView+WebCache.h"
#import "CLCloudinary.h"
#import "CLUploader.h"
#import "LivingTagsSecondStepService.h"
#import "ProfileGetService.h"
#import "MyTagsEditModeController.h"


@interface ProfileViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,CLUploaderDelegate>
{
    IBOutlet UITableView *tblProfile;
    // cloudinary instance
    CLCloudinary *cloudinary;
    UIImage *imgChosen;
}
@end

@implementation ProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    tblProfile.separatorStyle=UITableViewCellSeparatorStyleNone;
    tblProfile.backgroundColor=[UIColor clearColor];
    tblProfile.bounces=NO;
    cloudinary = [[CLCloudinary alloc] init];
    [cloudinary.config setValue:@"dw2w2nb2e" forKey:@"cloud_name"];
    [cloudinary.config setValue:@"963284535365757" forKey:@"api_key"];
    [cloudinary.config setValue:@"m7Op_O9CtqVTUOVkdbDdfA4u_6o" forKey:@"api_secret"];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"%@",appDel.objUser.strKey);
    [[ProfileGetService service]callProfileEditServiceWithUserID:appDel.objUser.strKey withCompletionHandler:^(id  _Nullable result, BOOL isError, NSString * _Nullable strMsg) {
        if (isError)
        {
            [self displayErrorWithMessage:strMsg];
        }
        else
        {
            [tblProfile reloadData];
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark
#pragma mark tableview datasource and delegate
#pragma mark

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case 0:
            return 160.0f;
            break;
            
        default:
            return 60.0f;
            break;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=nil;
    if (indexPath.row==0)
    {
        ProfileCell *cellProfile=[tblProfile dequeueReusableCellWithIdentifier:@"str"];
        if (!cellProfile)
        {
            cellProfile=[[[NSBundle mainBundle]loadNibNamed:@"ProfileCell" owner:self options:nil]objectAtIndex:0];
        }
        if(___isIphone6Plus || ___isIphone6)
        {
            cellProfile.imgProfilePic.layer.cornerRadius=self.view.frame.size.height/18;
        }
        else
        {
            cellProfile.imgProfilePic.layer.cornerRadius=self.view.frame.size.height/14;
        }
        cellProfile.imgProfilePic.clipsToBounds=YES;
        cellProfile.lblName.text=appDel.objUser.strName;
        cellProfile.lblEmail.text=appDel.objUser.strEmail;
        if (imgChosen)
        {
            cellProfile.imgProfilePic.image=imgChosen;
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [cellProfile.imgProfilePic sd_setImageWithURL:[NSURL URLWithString:appDel.objUser.strPicURI]
                                             placeholderImage:[UIImage imageNamed:@"defltmale_user_icon"]
                                                      options:SDWebImageHighPriority
                                                     progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                                         [cellProfile.actIndicatorProfilePic startAnimating];
                                                     }
                                                    completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                                        [cellProfile.actIndicatorProfilePic stopAnimating];
                                                        
                                                    }];
            });
        }
        [cellProfile.btnProfileImage addTarget:self action:@selector(btnProfileImageClicked:) forControlEvents:UIControlEventTouchUpInside];
        cell=cellProfile;
    }
    else
    {
        ProfileCell *cellOthers=[tblProfile dequeueReusableCellWithIdentifier:@"str"];
        if (!cellOthers)
        {
            cellOthers=[[[NSBundle mainBundle]loadNibNamed:@"ProfileCell" owner:self options:nil]objectAtIndex:1];
        }
        if (indexPath.row==1)
        {
            cellOthers.lblOthers.text=@"My Profile Tags";
        }
        else
        {
            cellOthers.lblOthers.text=@"Password";
            cellOthers.btnEdit.hidden=YES;

        }
        [cellOthers.btnEdit addTarget:self action:@selector(btnEditClicked:) forControlEvents:UIControlEventTouchUpInside];
        cell=cellOthers;
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark
#pragma mark IBACTIONS
#pragma mark

-(void)btnEditClicked:(id)sender
{
    [self performSegueWithIdentifier:@"segueProfileToEditTags" sender:self];
}

-(void)btnProfileImageClicked:(id)sender
{
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"Please select the image from gallery or click it from your camera.." message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *actionCamera=[UIAlertAction actionWithTitle:@"CAMERA" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self imageUploadFromCamera];
    }];
    UIAlertAction *actionGallery=[UIAlertAction actionWithTitle:@"GALLERY" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self imageUploadFromGallery];
    }];
    UIAlertAction *actionCancel=[UIAlertAction actionWithTitle:@"CANCEL" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alertController dismissViewControllerAnimated:YES completion:^{
            
        }];
    }];
    [alertController addAction:actionCamera];
    [alertController addAction:actionGallery];
    [alertController addAction:actionCancel];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark
#pragma mark CAMERA GALLERY METHODS AND IMAGE PICKER CONTROLLER DELEGATES
#pragma mark

-(void)takePhotoFromCamera
{
    [self imageUploadFromCamera];
}


-(void)takePhotoFromGallery
{
    [self imageUploadFromGallery];
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
    imgChosen=info[UIImagePickerControllerOriginalImage] ;
    [picker dismissViewControllerAnimated:YES completion:^{
        [self uploadImageToCloudinary:imgChosen];
    }] ;
}

-(void)uploadImageToCloudinary:(UIImage *)img
{
    NSData *imageData=UIImageJPEGRepresentation(img, 0.2);
    CLUploader* uploader = [[CLUploader alloc] init:cloudinary delegate:self];
    NSString * strTimestamp = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970] * 1000];
    NSString *strPublicKey=[NSString stringWithFormat:@"%@/%@",appDel.objUser.strProfilePicFolder,strTimestamp];
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
                [[LivingTagsSecondStepService service]callSecondStepServiceWithDIctionary:dict tKey:appDel.objUser.strTkey withCompletionHandler:^(id  _Nullable result, BOOL isError, NSString * _Nullable strMsg) {
                    [self hideNetworkActivity];
                    if (isError)
                    {
                        [self displayErrorWithMessage:strMsg];
                    }
                    else
                    {
                        [tblProfile beginUpdates];
                        NSArray *paths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]];
                        [tblProfile reloadRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationFade];
                        [tblProfile endUpdates];
                        
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


#pragma mark
#pragma mark Prepare for segue
#pragma mark

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"segueProfileToEditTags"])
    {
        MyTagsEditModeController *master=[segue destinationViewController];
        master.strTKey=appDel.objUser.strTkey;
        master.strTagName=@"Person";
    }
}

@end
