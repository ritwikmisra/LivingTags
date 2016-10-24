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

@interface DashboardViewController ()<UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate>
{
    IBOutlet UITableView *tblDashboard;
    NSMutableArray *arrPics,*arrLabel;
}

@end

@implementation DashboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    arrPics=[[NSMutableArray alloc]initWithObjects:@"scan_tag",@"create_tag",@"view_local_tags",@"add_icon",nil];
    arrLabel=[[NSMutableArray alloc]initWithObjects:@"Scan a Tag",@"Create a Tag",@"View Local Tags",@"Add to an Existing Tags", nil];
    tblDashboard.backgroundColor=[UIColor clearColor];
    tblDashboard.separatorStyle=UITableViewCellSeparatorStyleNone;
    tblDashboard.bounces=NO;
    [self callLocationManager];
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
    if (___isIphone6Plus)
    {
        return 150.0f;
    }
    if (___isIphone6)
    {
        return 150.0f;
    }
    if (___isIphone5_5s)
    {
        return 110.0f;
    }
    return 95.0f;
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
        }
        else
        {
            NSLog(@"%@", error.debugDescription);
        }
    }];
}

@end
