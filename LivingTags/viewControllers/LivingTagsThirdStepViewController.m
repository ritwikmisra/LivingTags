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

@interface LivingTagsThirdStepViewController ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    IBOutlet UILabel *lbl1;
    IBOutlet UILabel *lbl2;
    IBOutlet UILabel *lbl3;
    IBOutlet UILabel *lbl4;
    IBOutlet UITableView *tblAThirdStep;
    UIImageView *img;

}

@end

@implementation LivingTagsThirdStepViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    tblAThirdStep.separatorStyle=UITableViewCellSeparatorStyleNone;
    [tblAThirdStep setBounces:NO];
    appDel.arrCreateTagsUploadImage=[[NSMutableArray alloc]init];
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
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case 0:
            return 180.0f;
            break;
        
        default:
            return 70.0f;
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
                cellTags=[[[NSBundle mainBundle]loadNibNamed:@"CreateTagsThirdStepCell" owner:self options:nil] objectAtIndex:indexPath.row];
            }
            [cellTags.btnBrowse addTarget:self action:@selector(btnUserBrowsePicClicked:) forControlEvents:UIControlEventTouchUpInside];
            break;
            
        case 1:
            if (!cellTags)
            {
                cellTags=[[[NSBundle mainBundle]loadNibNamed:@"CreateTagsThirdStepCell" owner:self options:nil] objectAtIndex:indexPath.row];
            }
            [cellTags.btnCalender addTarget:self action:@selector(btnCalenderPressed:) forControlEvents:UIControlEventTouchUpInside];
            break;
            
        case 2:
            if (!cellTags)
            {
                cellTags=[[[NSBundle mainBundle]loadNibNamed:@"CreateTagsThirdStepCell" owner:self options:nil] objectAtIndex:indexPath.row];
            }
            [cellTags.btnRecording addTarget:self action:@selector(btnRecordingPressed:) forControlEvents:UIControlEventTouchUpInside];
            break;
            
        case 3:
            if (!cellTags)
            {
                cellTags=[[[NSBundle mainBundle]loadNibNamed:@"CreateTagsThirdStepCell" owner:self options:nil] objectAtIndex:indexPath.row];
            }
            [cellTags.btnMorePicNo addTarget:self action:@selector(btnNoPressed:) forControlEvents:UIControlEventTouchUpInside];
            [cellTags.btnMorePicYes addTarget:self action:@selector(btnYesPressed:) forControlEvents:UIControlEventTouchUpInside];

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

-(void)btnCalenderPressed:(id)sender
{
}

-(void)btnRecordingPressed:(id)sender
{
    [self performSegueWithIdentifier:@"segueAudio" sender:self];
}

-(void)btnNoPressed:(id)sender
{
}

-(void)btnYesPressed:(id)sender
{
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
    }] ;
}


@end
