//
//  DashboardViewController.m
//  LivingTags
//
//  Created by appsbeetech on 09/08/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "DashboardViewController.h"
#import "ProfileGetService.h"
#import "DashboardCell.h"
#import <CoreLocation/CoreLocation.h>
#import "ProfileGetService.h"
#import "QRCodeReaderViewController.h"
#import "QRCodeReader.h"
#import "PreviewViewController.h"
#import "LivingTagsSecondStepService.h"


@interface DashboardViewController ()<UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate,QRCodeReaderDelegate>
{
    IBOutlet UITableView *tblDashboard;
    NSMutableArray *arrPics,*arrLabel;
    NSString *strSegue;
    NSMutableDictionary *dictLatLong;
}

@end

@implementation DashboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dictLatLong=[[NSMutableDictionary alloc]init];
    tblDashboard.backgroundColor=[UIColor clearColor];
    tblDashboard.separatorStyle=UITableViewCellSeparatorStyleNone;
    tblDashboard.bounces=NO;
    [[ProfileGetService service]callProfileEditServiceWithUserID:[[NSUserDefaults standardUserDefaults]valueForKey:@"akey"] withCompletionHandler:^(id  _Nullable result, BOOL isError, NSString * _Nullable strMsg) {
        if (isError)
        {
            [self displayErrorWithMessage:strMsg];
        }
        else
        {
            [self callLocationManager];
            if ([appDel.objUser.strTagCounts integerValue]==1)
            {
                arrPics=[[NSMutableArray alloc]initWithObjects:@"scan_tag",@"create_tag",@"view_local_tags",nil];
                arrLabel=[[NSMutableArray alloc]initWithObjects:@"Scan a Tag",@"Create a Tag",@"View Local Tags", nil];
            }
            else
            {
                arrPics=[[NSMutableArray alloc]initWithObjects:@"scan_tag",@"create_tag",@"view_local_tags",@"add_icon",nil];
                arrLabel=[[NSMutableArray alloc]initWithObjects:@"Scan a Tag",@"Create a Tag",@"View Local Tags",@"Add to an Existing Tag", nil];
            }
            [tblDashboard reloadData];
        }
    }];

    
}

-(void)viewWillAppear:(BOOL)animated
{
    //commented on 6th october 2016 by Ritwik
    
    [super viewWillAppear:animated];
    
   /* if (appDel.isGoToDashBoardFromQRbtnTapped) {
        appDel.isGoToDashBoardFromQRbtnTapped = NO;
        appDel.isCreateTagTappedFromDashboard = NO;
        appDel.isMyTagTappedFromDashboard = NO;
        appDel.isReadTagTappedFromDashboard = NO;
    }
    
    
    [[ProfileGetService service]callProfileEditServiceWithUserID:appDel.objUser.strUserID withCompletionHandler:^(id  _Nullable result, BOOL isError, NSString * _Nullable strMsg) {
        if (isError)
        {
            [self displayErrorWithMessage:strMsg];
        }
        else
        {
            NSLog(@"%@",result);
        }
    }];*/
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark
#pragma mark tableview datasource and delegate
#pragma mark

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([appDel.objUser.strTagCounts integerValue]==1)
    {
        if (___isIphone6Plus)
        {
            return 180.0f;
        }
        if (___isIphone6)
        {
            return 160.0f;
        }
        if (___isIphone5_5s)
        {
            return 140.0f;
        }
        return 105.0f;

    }
    else
    {
        if (___isIphone6Plus)
        {
            return 150.0f;
        }
        if (___isIphone6)
        {
            return 130.0f;
        }
        if (___isIphone5_5s)
        {
            return 110.0f;
        }
        return 95.0f;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrPics.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DashboardCell *cell=[tableView dequeueReusableCellWithIdentifier:@"identifiew"];
    if (!cell)
    {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"DashboardCell" owner:self options:nil] objectAtIndex:0];
    }
    if (indexPath.row==0)
    {
        cell.btnScanTag.userInteractionEnabled=YES;
    }
    else
    {
        cell.btnScanTag.userInteractionEnabled=NO;
    }
    [cell.btnScanTag addTarget:self action:@selector(btnScannerTapped:) forControlEvents:UIControlEventTouchUpInside];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor clearColor];
    cell.imgDashboard.image=[UIImage imageNamed:[arrPics objectAtIndex:indexPath.row]];
    cell.lblName.text=[arrLabel objectAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   if (indexPath.row==1)
    {
//        appDel.isCreateTagTappedFromDashboard = YES;
//        appDel.isMyTagTappedFromDashboard = NO;
//        appDel.isReadTagTappedFromDashboard = NO;
       [self performSegueWithIdentifier:@"segueDashboardToCreateTags" sender:self];
    }
    /*if (indexPath.row==2)
    {
        appDel.isMyTagTappedFromDashboard = YES;
        appDel.isCreateTagTappedFromDashboard = NO;
        appDel.isReadTagTappedFromDashboard = NO;
        [self performSegueWithIdentifier:@"segueDashboardToMyTags" sender:self];
    }
    if (indexPath.row==0)
    {
        appDel.isReadTagTappedFromDashboard = YES;
        appDel.isMyTagTappedFromDashboard = NO;
        appDel.isCreateTagTappedFromDashboard = NO;
        [self performSegueWithIdentifier:@"segueDashBoardToReadTags" sender:self];
    }*/
    if (indexPath.row==3)
    {
        [self performSegueWithIdentifier:@"segueDashboardToMyTags" sender:self];
    }
    if (indexPath.row==2)
    {
        [self performSegueWithIdentifier:@"segueViewOtherTags" sender:self];
    }
}

#pragma mark
#pragma mark CLLOCATION METHODS
#pragma mark

-(void)callLocationManager
{
    appDel.locationManager=[[CLLocationManager alloc]init];
    appDel.geoCoder=[[CLGeocoder alloc]init] ;
    appDel.locationManager.delegate=self;
    appDel.locationManager.desiredAccuracy=kCLLocationAccuracyBest ;
    if ([appDel.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
    {
        [appDel.locationManager requestWhenInUseAuthorization];
    }
    [appDel.locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    [appDel.locationManager stopUpdatingLocation];
    appDel.location=newLocation;
    appDel.center=newLocation.coordinate;
    [dictLatLong setObject:[NSString stringWithFormat:@"%f",appDel.center.latitude] forKey:@"tlat1"];
    [dictLatLong setObject:[NSString stringWithFormat:@"%f",appDel.center.longitude] forKey:@"tlong1"];
    NSLog(@"%@",dictLatLong);
    NSLog(@"%f,%f",appDel.center.latitude,appDel.center.longitude);
    NSLog(@"Resolving The Address");
    [appDel.geoCoder reverseGeocodeLocation:appDel.location completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"Found placemarks:%@ error :%@",appDel.placemark,error);
        if(error==nil && [placemarks  count]>0)
        {
            appDel.placemark=[placemarks objectAtIndex:0] ;
            //            NSString *strAddress=[NSString stringWithFormat:@"%@ \n%@ \n%@",placemark.postalCode,placemark.administrativeArea,placemark.country];
            
            //NSLog(@"%@:%@:%@:%@:%@",strAddress,placemark.country,placemark.administrativeArea,placemark.subAdministrativeArea,placemark.subLocality) ;
            NSString *str1=[NSString stringWithFormat:@"%@,%@:%@",appDel.placemark.subAdministrativeArea,appDel.placemark.country,appDel.placemark.administrativeArea];
            NSLog(@"%@",str1);
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
                [[LivingTagsSecondStepService service]callSecondStepServiceWithDIctionary:dictLatLong tKey:appDel.objUser.strTkey withCompletionHandler:^(id  _Nullable result, BOOL isError, NSString * _Nullable strMsg) {
                    if (isError)
                    {
                        [self displayErrorWithMessage:strMsg];
                    }
                    else
                    {
                        NSLog(@"%@",result);
                    }
                }];
            });
        }
        else
        {
            NSLog(@"%@", error.debugDescription);
        }
    }];
}

#pragma mark
#pragma mark IBACTIONS
#pragma mark

-(void)btnScannerTapped:(id)sender
{
    if ([QRCodeReader supportsMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]])
    {
        static QRCodeReaderViewController *vc = nil;
        static dispatch_once_t onceToken;
        
        dispatch_once(&onceToken, ^{
            QRCodeReader *reader = [QRCodeReader readerWithMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
            vc                   = [QRCodeReaderViewController readerWithCancelButtonTitle:@"Cancel" codeReader:reader startScanningAtLoad:YES showSwitchCameraButton:YES showTorchButton:YES];
            vc.modalPresentationStyle = UIModalPresentationFormSheet;
        });
        vc.delegate = self;
        [vc setCompletionWithBlock:^(NSString *resultAsString) {
            NSLog(@"Completion with result: %@", resultAsString);
        }];
        [self presentViewController:vc animated:YES completion:NULL];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Camera not available" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

#pragma mark
#pragma mark - QRCodeReader Delegate Methods
#pragma mark

- (void)reader:(QRCodeReaderViewController *)reader didScanResult:(NSString *)result
{
    [reader stopScanning];
    strSegue=result;
    [self dismissViewControllerAnimated:YES completion:^{
       /* UIAlertController *alertController=[UIAlertController alertControllerWithTitle:result message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionOK=[UIAlertAction actionWithTitle:@"OPEN" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if ([result containsString:@"livingtags.com"])
            {
                [self performSegueWithIdentifier:@"segueScannerToWebview" sender:self];
            }
            else
            {
                
            }
           [alertController dismissViewControllerAnimated:YES completion:^{
               
           }];
        }];
        [alertController addAction:actionOK];
        [self presentViewController:alertController animated:YES completion:^{
            
        }];*/
        [self performSegueWithIdentifier:@"segueScannerToWebview" sender:self];
    }];
}

- (void)readerDidCancel:(QRCodeReaderViewController *)reader
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark
#pragma mark PREPARE FOR SEGUE
#pragma mark

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"segueScannerToWebview"])
    {
        PreviewViewController *master=[segue destinationViewController];
        strSegue=[strSegue stringByReplacingOccurrencesOfString:@"https" withString:@"http"];
        master.strLabel=@"PUBLISH";
        master.str=strSegue;
    }
}
 
@end
