//
//  SettingsViewController.m
//  LivingTags
//
//  Created by appsbeetech on 07/11/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "SettingsViewController.h"
#import "SettingsCell.h"

@interface SettingsViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    IBOutlet UITableView *tblSettings;
    NSMutableArray *arrSettingsLabel;
}

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    tblSettings.separatorStyle=UITableViewCellSeparatorStyleNone;
    arrSettingsLabel=[[NSMutableArray alloc]initWithObjects:@"My Tags Privacy",@"Custodian Settings",@"Privacy Policy",@"Terms of Service",@"Push Notification",@"Logout",nil];
    tblSettings.backgroundColor=[UIColor clearColor];
    tblSettings.bounces=NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return arrSettingsLabel.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (___isIphone6Plus)
    {
        return 65.0f;
    }
    return 50.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=nil;
    if (indexPath.row==4)
    {
        SettingsCell *cellSwitch=[tableView dequeueReusableCellWithIdentifier:@"str"];
        if (!cellSwitch)
        {
            cellSwitch=[[[NSBundle mainBundle]loadNibNamed:@"SettingsCell" owner:self options:nil] objectAtIndex:1];
        }
        cellSwitch.lblSettings.text=[arrSettingsLabel objectAtIndex:indexPath.row];
        cell=cellSwitch;
    }
    else
    {
        SettingsCell *cellLabel=[tableView dequeueReusableCellWithIdentifier:@"str"];
        if (!cellLabel)
        {
            cellLabel=[[[NSBundle mainBundle]loadNibNamed:@"SettingsCell" owner:self options:nil] objectAtIndex:0];
        }
        if (indexPath.row==arrSettingsLabel.count-1)
        {
            cellLabel.imgSettingsBottom.hidden=YES;
            cellLabel.imgBtn.hidden=YES;
            cellLabel.btnSettings.hidden=YES;
        }
        cellLabel.lblSettings.text=[arrSettingsLabel objectAtIndex:indexPath.row];
        cell=cellLabel;
    }
    cell.backgroundColor=[UIColor whiteColor];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
        //[self performSegueWithIdentifier:@"segueMyTagsPrivacy" sender:self];
    }
    if (indexPath.row==arrSettingsLabel.count-1)
    {
        [self didPressLogout];
    }
}

#pragma mark
#pragma mark logout functionality 
#pragma mark

-(void)didPressLogout
{
    //segueLogoutToLogin
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"Do you want to logout?" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionOK=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"akey"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [self performSegueWithIdentifier:@"segueLogoutToLogin" sender:self];
        [alertController dismissViewControllerAnimated:YES completion:^{
            
        }];
    }];
    UIAlertAction *actionCancel=[UIAlertAction actionWithTitle:@"CANCEL" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alertController dismissViewControllerAnimated:YES completion:^{
            
        }];
    }];

    [alertController addAction:actionOK];
    [alertController addAction:actionCancel];
    [self presentViewController:alertController animated:YES completion:^{
        
    }];
}

@end
