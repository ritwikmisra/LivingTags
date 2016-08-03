//  ProfileViewController.m
//  LivingTags
//
//  Created by appsbeetech on 28/04/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "ProfileViewController.h"
#import "EditProfilePicCellTableViewCell.h"
//#import <MediaPlayer/MediaPlayer.h>
#import "ProfileGetService.h"
#import "UIImageView+WebCache.h"
#import "UpdateProfileService.h"
#import "YTVimeoExtractor.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import <UIKit/UIKit.h>

@interface ProfileViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    IBOutlet UITableView *tblProfile;
    NSMutableArray *arrProfile,*arrPics,*arrTexts;
    NSString *strVideoLink,*strPhoneNumber,*strName,*strVideoID;
    BOOL isEditing;
    IBOutlet UIButton *btnSave;
    UIImageView *img;
    UIImage *imgChosen;
    BOOL isYoutube;
    AVPlayer *player ;
    GMSPlacePicker *placePicker;
    GMSMapView *mapView;
    GMSPlace *pickedPlace;
    NSString *name2;
    NSString *address2;
    NSString *strCat;
    UITextField *activeTextField;
}
@end

@implementation ProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    tblProfile.separatorStyle=UITableViewCellSeparatorStyleNone;
    arrProfile=[[NSMutableArray alloc]initWithObjects:@"",@"Email",@"Phone",@"Video", nil];
    arrPics=[[NSMutableArray alloc]initWithObjects:@"",@"mail_icon1",@"phone_icon",@"video_icon", nil];
    isEditing=NO;
    btnSave.hidden=YES;
    [tblProfile setTag:1];
    //get profile web service
    [[ProfileGetService service]callProfileEditServiceWithUserID:appDel.objUser.strUserID withCompletionHandler:^(id  _Nullable result, BOOL isError, NSString * _Nullable strMsg) {
        if (isError)
        {
            [self displayErrorWithMessage:strMsg];
        }
        else
        {
            NSLog(@"%@",result);
            arrTexts=[[NSMutableArray alloc]initWithObjects:appDel.objUser.strName,appDel.objUser.strEmail,appDel.objUser.strPhone,appDel.objUser.strVideoURI, nil];
            strName=[arrTexts objectAtIndex:0];
            strPhoneNumber=[arrTexts objectAtIndex:2];
            strVideoLink=[arrTexts objectAtIndex:3];
            [self checkYoutubeLINK:strVideoLink];
            [tblProfile reloadData];
        }
    }];
    //
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    mapView.settings.myLocationButton = YES;
    mapView.myLocationEnabled = YES;
    mapView.hidden = YES;
    NSLog(@"User's location: %@", mapView.myLocation);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return arrTexts.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (___isIphone4_4s)
    {
        if (indexPath.row==0)
        {
            return 200.0f;
        }
        else if (indexPath.row==3)
        {
            if (strVideoID.length==0)
            {
                return 60.0f;
            }
            return 230.0f;
        }
        return 60.0f;
    }
   else if (___isIphone5_5s)
    {
        if (indexPath.row==0)
        {
            return 220.0f;
        }
        else if (indexPath.row==3)
        {
            if (strVideoID.length==0)
            {
                return 60.0f;
            }
            return 250.0f;
        }
        return 60.0f;
    }
    else if (___isIphone6)
    {
        if (indexPath.row==0)
        {
            return 240.0f;
        }
        else if (indexPath.row==3)
        {
            if (strVideoID.length==0)
            {
                return 80.0f;
            }
            return 250.0f;
        }
        return 80.0f;
    }
    else
    {
        if (indexPath.row==0)
        {
            return 260.0f;
        }
        else if (indexPath.row==3)
        {
            if (strVideoID.length==0)
            {
                return 100.0f;
            }
            return 270.0f;
        }
        return 100.0f;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if(indexPath.row==0)
    {
        EditProfilePicCellTableViewCell *cellA=[tableView dequeueReusableCellWithIdentifier:@"str"];
        if(!cellA)
        {
            cellA=[[[NSBundle mainBundle]loadNibNamed:@"EditProfilePicCellTableViewCell" owner:self options:nil]objectAtIndex:0];
        }
        cellA.txtName.text=[arrTexts objectAtIndex:indexPath.row];
        cellA.txtName.delegate=self;
        [cellA.btnProfileEdit addTarget:self action:@selector(btnEditPressed:) forControlEvents:UIControlEventTouchUpInside];
        NSLog(@"%@",appDel.objLivingTags.strCreated);
        [cellA.btnProfilePicUpdate addTarget:self action:@selector(btnImageUploadPressed:) forControlEvents:UIControlEventTouchUpInside];
        [cellA.btnLocation addTarget:self action:@selector(btnLocationPressed:) forControlEvents:UIControlEventTouchUpInside];
        [cellA.txtName addTarget:self action:@selector(txtfieldEditingForProfile:) forControlEvents:UIControlEventEditingChanged];
        if (imgChosen)
        {
            cellA.imgProfile.image=imgChosen;
        }
        else
        {
            NSLog(@"%@",appDel.objUser.strPicURI160);
            NSURL *url=[NSURL URLWithString:appDel.objUser.strPicURI160];
            dispatch_async(dispatch_get_main_queue(), ^{
                [cellA.imgProfile sd_setImageWithURL:url
                                            placeholderImage:[UIImage imageNamed:@"defltmale_user_icon"]
                                                     options:SDWebImageHighPriority
                                                    progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                                        if (cellA.actProfileIndicator)
                                                        {
                                                            [cellA.actProfileIndicator startAnimating];
                                                        }
                                                    }
                                                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                                       [cellA.actProfileIndicator stopAnimating];
                                                   }];
            });
        }
        img=cellA.imgProfile;
        cellA.constHeight.constant=self.view.frame.size.height/5;
        cellA.imgProfile.layer.cornerRadius=self.view.frame.size.height/10;
        cellA.imgProfile.layer.masksToBounds=YES;
        [cellA.contentView updateConstraints];
        if(appDel.objLivingTags.strCreated.length>0)
        {
            cellA.lblMemoriesCreated.text=appDel.objLivingTags.strCreated;
            cellA.lblMemoriesViewed.text=appDel.objLivingTags.strViewd;
        }
        else
        {
            cellA.lblMemoriesCreated.text=@"";
            cellA.lblMemoriesViewed.text=@"";
        }
        if(isEditing==NO)
        {
            cellA.btnProfileEdit.hidden=NO;
            cellA.txtName.userInteractionEnabled=NO;
        }
        else
        {
            cellA.btnProfileEdit.hidden=YES;
            cellA.txtName.userInteractionEnabled=YES;
        }
        cell=cellA;
    }
    else if (indexPath.row==3)
    {
        if(strVideoID.length==0)
        {
            EditProfilePicCellTableViewCell *cellc=[tableView dequeueReusableCellWithIdentifier:@"str"];
            if(!cellc)
            {
                cellc=[[[NSBundle mainBundle]loadNibNamed:@"EditProfilePicCellTableViewCell" owner:self options:nil]objectAtIndex:1];
            }
            cellc.img.image=[UIImage imageNamed:[arrPics objectAtIndex:indexPath.row]];
            cellc.lblPlaceHolders.text=[arrProfile objectAtIndex:indexPath.row];
            [cellc.txt setValue:[UIColor colorWithRed:98.0/255.0 green:105.0/255.0 blue:108.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
            cellc.txt.placeholder=@"https://www.youtube.com/watch?v=j4s3JmLGLCA";
            cellc.txt.text=[arrTexts objectAtIndex:indexPath.row];
            cellc.txt.tag=indexPath.row;
            [cellc.txt addTarget:self action:@selector(txtfieldEditingForProfile:) forControlEvents:UIControlEventEditingChanged];
            cellc.txt.delegate=self;
            if(isEditing==NO)
            {
                cellc.txt.userInteractionEnabled=NO;
            }
            else
            {
                cellc.txt.userInteractionEnabled=YES;
            }

            cell=cellc;
        }
        else if(isYoutube==YES)
        {
            EditProfilePicCellTableViewCell *cellc=[tableView dequeueReusableCellWithIdentifier:@"str"];
            if(!cellc)
            {
                cellc=[[[NSBundle mainBundle]loadNibNamed:@"EditProfilePicCellTableViewCell" owner:self options:nil]objectAtIndex:2];
            }
            cellc.lblPlaceHolders.text=[arrProfile objectAtIndex:indexPath.row];
            cellc.txt.tag=indexPath.row;
            [cellc.txt setValue:[UIColor colorWithRed:98.0/255.0 green:105.0/255.0 blue:108.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
            cellc.txt.text=[arrTexts objectAtIndex:indexPath.row];
            [cellc.txt addTarget:self action:@selector(txtfieldEditingForProfile:) forControlEvents:UIControlEventEditingChanged];
            NSDictionary *playerVars = @{@"playsinline" : @1,};
            [cellc.vwPlayer loadWithVideoId:strVideoID playerVars:playerVars];
            cellc.txt.delegate=self;
            cellc.txt.placeholder=@"https://www.youtube.com/watch?v=j4s3JmLGLCA";
            if(isEditing==NO)
            {
                cellc.txt.userInteractionEnabled=NO;
            }
            else
            {
                cellc.txt.userInteractionEnabled=YES;
            }
            cell=cellc;
        }
        else
        {
            EditProfilePicCellTableViewCell *cellc=[tableView dequeueReusableCellWithIdentifier:@"str"];
            if(!cellc)
            {
                cellc=[[[NSBundle mainBundle]loadNibNamed:@"EditProfilePicCellTableViewCell" owner:self options:nil]objectAtIndex:3];
            }
            cellc.lblPlaceHolders.text=[arrProfile objectAtIndex:indexPath.row];
            cellc.txt.placeholder=@"https://www.youtube.com/watch?v=j4s3JmLGLCA";
            [cellc.txt setValue:[UIColor colorWithRed:98.0/255.0 green:105.0/255.0 blue:108.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
            cellc.txt.tag=indexPath.row;
            cellc.txt.text=[arrTexts objectAtIndex:indexPath.row];
            [cellc.txt addTarget:self action:@selector(txtfieldEditingForProfile:) forControlEvents:UIControlEventEditingChanged];
            cellc.txt.delegate=self;
            if(isEditing==NO)
            {
                cellc.txt.userInteractionEnabled=NO;
            }
            else
            {
                cellc.txt.userInteractionEnabled=YES;
            }
            //vimeo functionality
            [[YTVimeoExtractor sharedExtractor]fetchVideoWithVimeoURL:strVideoLink withReferer:nil completionHandler:^(YTVimeoVideo * _Nullable video, NSError * _Nullable error) {
                if (video)
                {
                    NSString *str = [NSString stringWithFormat:@"Video Title: %@",video.title];
                    NSLog(@"%@",str);
                    NSURL *highQualityURL = [video lowestQualityStreamURL];
                    player = [[AVPlayer alloc] initWithURL: highQualityURL];
                    AVPlayerViewController *controller = [[AVPlayerViewController alloc]init];
                    controller.player = player;
                    controller.showsPlaybackControls=NO;
                    controller.view.frame = CGRectMake(cellc.vwVimeo.frame.origin.x, 0, cellc.vwVimeo.frame.size.width, cellc.vwVimeo.frame.size.height);
                    [cellc.vwVimeo addSubview:controller.view];
                    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
                    btn.frame=CGRectMake(controller.view.frame.origin.x, 0, controller.view.frame.size.width, controller.view.frame.size.height);
                    [controller.view addSubview:btn];
                    btn.backgroundColor=[UIColor clearColor];
                    [btn addTarget:self action:@selector(btnVideoClicked:) forControlEvents:UIControlEventTouchUpInside];
                    [btn setBackgroundImage:[UIImage imageNamed:@"play_icon"] forState:UIControlStateNormal];
                    [player pause];
                }
                else
                {
                    UIAlertView *alertView = [[UIAlertView alloc]init];
                    alertView.title = error.localizedDescription;
                    alertView.message = error.localizedFailureReason;
                    [alertView addButtonWithTitle:@"OK"];
                    [alertView show];
                }
            }];
            //vimeo functionality complete
            cell=cellc;
        }
    }
    else
    {
        EditProfilePicCellTableViewCell *cellB=[tableView dequeueReusableCellWithIdentifier:@"str"];
        if(!cellB)
        {
            cellB=[[[NSBundle mainBundle]loadNibNamed:@"EditProfilePicCellTableViewCell" owner:self options:nil]objectAtIndex:1];
        }
        cellB.img.image=[UIImage imageNamed:[arrPics objectAtIndex:indexPath.row]];
        cellB.lblPlaceHolders.text=[arrProfile objectAtIndex:indexPath.row];
        cellB.txt.text=[arrTexts objectAtIndex:indexPath.row];
        cellB.txt.tag=indexPath.row;
        [cellB.txt addTarget:self action:@selector(txtfieldEditingForProfile:) forControlEvents:UIControlEventEditingChanged];
        cellB.txt.delegate=self;
        if(indexPath.row==2)
        {
            UIToolbar *keyboardToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
            keyboardToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(toolBarCancelNumberPad:)],
                                      [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                      [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(toolBardoneButtonNumberPad:)]];
            
            [cellB.txt setInputAccessoryView:keyboardToolbar];
            
            activeTextField = cellB.txt;
            
            cellB.txt.keyboardType=UIKeyboardTypeNumberPad;
        }
        if(isEditing==NO)
        {
            cellB.txt.userInteractionEnabled=NO;
        }
        else
        {
            cellB.txt.userInteractionEnabled=YES;
        }
        if(cellB.txt.tag==1)
        {
            cellB.txt.userInteractionEnabled=NO;
        }
        cell=cellB;
    }
    cell.backgroundColor=[UIColor clearColor];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma Number pad Toolbar Done and Cancel button

-(void)toolBarCancelNumberPad :(id)sender
{
    [self.view endEditing:YES];
    //activeTextField.text = @"";
}

-(void)toolBardoneButtonNumberPad:(id)sender
{
   NSString *numberFromTheKeyboard = activeTextField.text;
    [self.view endEditing:YES];
}

#pragma mark
#pragma mark textfield delegate
#pragma mark

-(void)txtfieldEditingForProfile:(id)sender
{
    UITextField *textField=(id)sender;
    if (textField.tag==3)
    {
        strVideoLink=textField.text;
        [arrTexts removeObjectAtIndex:textField.tag];
        [arrTexts insertObject:strVideoLink atIndex:textField.tag];
        [self checkYoutubeLINK:strVideoLink];
    }
    else if (textField.tag==2)
    {
        strPhoneNumber=textField.text;
        [arrTexts removeObjectAtIndex:textField.tag];
        [arrTexts insertObject:strPhoneNumber atIndex:textField.tag];
    }
    else if (textField.tag==0)
    {
        strName=textField.text;
        [arrTexts removeObjectAtIndex:textField.tag];
        [arrTexts insertObject:strName atIndex:textField.tag];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag==2)
    {
        NSString *currentString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        long length = [currentString length];
        if (length > 10)
        {
            return NO;
        }
    }
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGPoint textFieldOriginInTableView = [textField convertPoint:textField.frame.origin toView:tblProfile];
    NSLog(@"%@",NSStringFromCGPoint(textFieldOriginInTableView));
    NSLog(@"%ld",(long)textField.tag);
    if (textFieldOriginInTableView.y>220)
    {
        if (___isIphone4_4s)
        {
            [tblProfile setContentOffset:CGPointMake(0, textFieldOriginInTableView.y-130) animated:YES];
        }
        else if (___isIphone5_5s)
        {
            [tblProfile setContentOffset:CGPointMake(0, textFieldOriginInTableView.y-200) animated:YES];
        }
        else if (___isIphone6)
        {
            [tblProfile setContentOffset:CGPointMake(0, textFieldOriginInTableView.y-300) animated:YES];
        }
        else
        {
            [tblProfile setContentOffset:CGPointMake(0, textFieldOriginInTableView.y-320) animated:YES];
        }
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if (textField.tag==3)
    {
        [self checkYoutubeLINK:strVideoLink];
    }
    [tblProfile reloadData];
    [tblProfile setContentOffset:CGPointMake(0,0) animated:YES];
    return YES;
}

#pragma mark
#pragma mark IBACTIONS
#pragma mark

-(void)btnVideoClicked:(id)sender
{
    UIButton *btn=(id)sender;
    NSLog(@"Pressed");
    if(player.rate==1)
    {
        [player pause];
        [btn setBackgroundImage:[UIImage imageNamed:@"play_icon"] forState:UIControlStateNormal];

    }
    else
    {
        [player play];
        [btn setBackgroundImage:nil forState:UIControlStateNormal];
    }
}

-(void)btnEditPressed:(id)sender
{
    btnSave.hidden=NO;
    isEditing=YES;
    [tblProfile reloadData];
}

-(IBAction)btnSavePressed:(id)sender
{
    if ([self alertChecking])
    {
        isEditing=NO;
        btnSave.hidden=YES;
        [tblProfile reloadData];
        [[UpdateProfileService service]callUpdateProfileRequestWIthUserID:appDel.objUser.strUserID Name:strName Address:@"Bangur Avenue,Kolkata" Latitude:@"22.51758" Longitude:@"88.352215" videoURI:strVideoLink phoneNumber:strPhoneNumber userFile:imgChosen withCompletionHandler:^(id  _Nullable result, BOOL isError, NSString * _Nullable strMsg) {
            if (isError)
            {
                [self displayErrorWithMessage:strMsg];
            }
            else
            {
                NSLog(@"%@",result);
            }
        }];
    }
    else
    {
        NSLog(@"not complete");
    }
}

-(void)btnLocationPressed:(id)sender
{
    if (isEditing==YES)
    {
        CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:tblProfile];
        NSIndexPath *indexPath = [tblProfile indexPathForRowAtPoint:buttonPosition];
        EditProfilePicCellTableViewCell *editProfileCell = (EditProfilePicCellTableViewCell *)[tblProfile cellForRowAtIndexPath:indexPath];
        
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
                return;
            }
            
            if (place != nil) {
                name2 = place.name;
                NSLog(@"place.name:%@",place.name);
                
                [[GMSGeocoder geocoder] reverseGeocodeCoordinate:CLLocationCoordinate2DMake(place.coordinate.latitude, place.coordinate.longitude) completionHandler:^(GMSReverseGeocodeResponse* response, NSError* error)
                 {
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
                         editProfileCell.lblLocation.text = [NSString stringWithFormat:@"%@, %@",addressObj.locality,addressObj.administrativeArea];
                         break;
                     }
                 }];
                
                address2 = place.formattedAddress;
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
    else
    {
        NSLog(@"NO EDIT");
    }
}

-(void)btnImageUploadPressed:(id)sender
{
    NSLog(@"%d",isEditing);
    if (isEditing)
    {
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
    else
    {
        NSLog(@"No edit");
    }
}

#pragma mark
#pragma mark IMAGE PICKER
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
    imgChosen=info[UIImagePickerControllerEditedImage] ;
    [picker dismissViewControllerAnimated:YES completion:^{
        [tblProfile reloadData ];
    }] ;
}

-(void)checkYoutubeLINK:(NSString *)strYoutubeLink
{
    NSURL* url = [NSURL URLWithString:strYoutubeLink];
    NSString* domain = [url host];
    if (strYoutubeLink.length>0)
    {
        if (domain)
        {
            if ([domain containsString:@"youtube.com"])
            {
                NSLog(@"VALID");
                NSString *regexString = @"((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)";
                NSRegularExpression *regExp = [NSRegularExpression regularExpressionWithPattern:regexString
                                                                                        options:NSRegularExpressionCaseInsensitive
                                                                                          error:nil];
                NSArray *array = [regExp matchesInString:strVideoLink options:0 range:NSMakeRange(0,strVideoLink.length)];
                if (array.count > 0)
                {
                    NSTextCheckingResult *result = array.firstObject;
                    strVideoID=[strYoutubeLink substringWithRange:result.range];
                    NSLog(@"%@,%@", [strYoutubeLink substringWithRange:result.range],strVideoID);
                    isYoutube=YES;
                }
                else
                {
                    //[self displayErrorWithMessage:@"Please enter a valid youtube URL!!"];
                    strVideoID=@"";
                }
            }
            else if([domain containsString:@"vimeo.com"])
            {
                NSLog(@"Vimeo");
                isYoutube=NO;
                strVideoID=@"Vimeo";
            }
            else
            {
                strVideoID=@"";
            }
        }
        else
        {
            [self displayErrorWithMessage:@"Please enter a valid URL"];
            strVideoID=@"";
        }
    }
    else
    {
        NSLog(@"not entered");
        strVideoID=@"";
    }
}

#pragma mark
#pragma mark Alert checking
#pragma mark

-(BOOL)alertChecking
{
    if (strName.length==0)
    {
        [self displayErrorWithMessage:@"Please enter a name."];
        return NO;
    }
    if (strPhoneNumber.length<10)
    {
        [self displayErrorWithMessage:@"Please enter a proper phone number."];
        return NO;
    }
    if (strVideoLink.length>0)
    {
        if (strVideoID.length==0)
        {
            [self displayErrorWithMessage:@"Please enter a valid URL."];
            return NO;
        }
    }
    return YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [player pause];
}
@end
