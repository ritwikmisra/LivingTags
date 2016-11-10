//  ProfileViewController.m
//  LivingTags
//
//  Created by appsbeetech on 28/04/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "ProfileViewController.h"
#import "UIImageView+WebCache.h"
#import "ProfileCell.h"

@interface ProfileViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    IBOutlet UITableView *tblProfile;
}
@end

@implementation ProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    tblProfile.separatorStyle=UITableViewCellSeparatorStyleNone;
    tblProfile.backgroundColor=[UIColor clearColor];
    tblProfile.bounces=NO;
    //
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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
        cellProfile.imgProfilePic.layer.cornerRadius=self.view.frame.size.height/12;
        cellProfile.imgProfilePic.clipsToBounds=YES;
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

        }
        cell=cellOthers;
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark
#pragma mark IBACTIONS
#pragma mark

-(void)btnProfileImageClicked:(id)sender
{
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"Do you want to click a photograph or select it from gallery?" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionCAMERA=[UIAlertAction actionWithTitle:@"CAMERA" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self takePhotoFromCamera];
        [self.navigationController dismissViewControllerAnimated:YES completion:^{
            
        }];
    }];
    
    UIAlertAction *actionGallery=[UIAlertAction actionWithTitle:@"GALLERY" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self takePhotoFromGallery];
        [self.navigationController dismissViewControllerAnimated:YES completion:^{
            
        }];
    }];
    
    UIAlertAction *actionOK=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController dismissViewControllerAnimated:YES completion:^{
            
        }];
    }];

    [alertController addAction:actionOK];
    [alertController addAction:actionCAMERA];
    [alertController addAction:actionGallery];
    
    [self presentViewController:alertController animated:YES completion:^{
        
    }];
}

#pragma mark
#pragma mark CAMERA GALLERY METHODS AND IMAGE PICKER CONTROLLER DELEGATES
#pragma mark

-(void)takePhotoFromCamera
{
    NSLog(@"Camera pressed");
}


-(void)takePhotoFromGallery
{
    NSLog(@"Gallery pressed");
}
@end
