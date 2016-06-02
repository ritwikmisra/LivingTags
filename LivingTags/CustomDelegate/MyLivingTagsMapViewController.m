
//
//  MyLivingTagsMapViewController.m
//  LivingTags
//
//  Created by appsbeetech on 19/05/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "MyLivingTagsMapViewController.h"
#import <MapKit/MapKit.h>
#import "ModelListing.h"
#import "CustomAnnotationSingle.h"
#import "customAnnotationGroups.h"
#import "GroupPopupController.h"
#import "UIImageView+WebCache.h"
#import "TMAnnotationView.h"
#import "LivingTagsViewController.h"
#import "LivingTagsViewController.h"

@interface MyLivingTagsMapViewController ()<MKMapViewDelegate,RemovePopUpDelegate>
{
    IBOutlet MKMapView *mapTags;
    NSMutableArray *arrClusters,*arrSingle,*arrDuplicate;
    NSMutableDictionary *dict;
    UILabel *lblAnnotatation;
    GroupPopupController *master;
    UIImageView *pinView;
    UIView *vwAnotationDetails;
    UIButton *btnClose;
    UIView *callOutView;
    NSInteger calloutTag;
    int i;
}
@end

@implementation MyLivingTagsMapViewController

#pragma mark
#pragma mark Instance
#pragma mark

+(id)instance
{
    static MyLivingTagsMapViewController *master=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        master=[[MyLivingTagsMapViewController alloc]init];
    });
    return master;
}

#pragma mark

- (void)viewDidLoad
{
    [super viewDidLoad];
    mapTags.tintColor = [UIColor redColor];
    mapTags.showsUserLocation = YES;
    [mapTags setCenterCoordinate:appDel.location.coordinate animated:YES];
    arrClusters=[[NSMutableArray alloc]init];
    arrSingle=[[NSMutableArray alloc]init];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    dict=[[NSMutableDictionary alloc]init];
    arrDuplicate=[[NSMutableArray alloc]init];
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(appDel.center,900000, 90000);
    MKCoordinateRegion adjustedRegion = [mapTags regionThatFits:viewRegion];
    [mapTags setRegion:adjustedRegion animated:YES];
    mapTags.showsUserLocation = YES;
    mapTags.userLocation.title=appDel.objUser.strName;
    NSLog(@"%@",self.arrListFromMap);
    for (int j=0; j<self.arrListFromMap.count; j++)
    {
        [arrDuplicate addObject:[self.arrListFromMap objectAtIndex:j]];
    }
    //arrDuplicate=self.arrListFromMap;
    [self getPrimaryLocations:arrDuplicate];
    mapTags.delegate=self;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)getPrimaryLocations:(NSMutableArray *)arrLocations
{
    i=0;
    NSLog(@"%@",self.arrListFromMap);
    while (arrLocations.count>0)
    {
        // create a new group for the key
        ModelListing *obj=[arrLocations objectAtIndex:0];
        CLLocation *locObj1=[[CLLocation alloc]initWithLatitude:[obj.strLat1 doubleValue] longitude:[obj.strLong1 doubleValue]];
        NSString *str=[NSString stringWithFormat:@"%d",i];
        NSMutableSet *set=[[NSMutableSet alloc] init];
        [set addObject:obj];
        [dict setObject:set forKey:str];
        //traverse the array and compare other item with the key
        for (int j=1; j<arrLocations.count; j++)
        {
            ModelListing *objTraverse=[arrLocations objectAtIndex:j];
            NSLog(@"%@ %@",obj.strID,objTraverse.strID);
            CLLocation *locObjTraverse=[[CLLocation alloc]initWithLatitude:[objTraverse.strLat1 doubleValue] longitude:[objTraverse.strLong1 doubleValue]];
            if ((int)[locObjTraverse distanceFromLocation:locObj1]<=20)
            {
                // add the item into current group
                // remove the item from the list
                [set addObject:objTraverse];
                NSString *str1=[NSString stringWithFormat:@"%d",i];
                [dict setObject:set forKey:str1];
                [arrLocations removeObjectAtIndex:j];
                j--;
            }
        }
        [arrLocations removeObjectAtIndex:0];
        NSLog(@"%@",self.arrListFromMap);
        i++;
    }
    NSLog(@"%@",dict);
    NSLog(@"%@",self.arrListFromMap);
    [self getLatitudesAndLongitudesForSinglePoints];
}

#pragma mark 
#pragma mark get Latitude and longitude for groups and single latitude and longitudes
#pragma mark

-(void)getLatitudesAndLongitudesForSinglePoints
{
    NSLog(@"%@",dict);
    NSLog(@"%lu",(unsigned long)[dict allKeys].count);
    for (int k=0; k<[dict allKeys].count; k++)
    {
        NSString *str=[NSString stringWithFormat:@"%d",k];
        NSMutableSet *set=[dict objectForKey:str];
        NSMutableArray *arr=[[set allObjects] mutableCopy];
        NSLog(@"%@",arr);
        if (arr.count==1)
        {
            NSLog(@"%d",k);
            ModelListing *objSingle=[arr firstObject];
            // creating custom class for annotation of single point
            CustomAnnotationSingle *annotationSingle=[[CustomAnnotationSingle alloc]initWithCoordinate:CLLocationCoordinate2DMake([objSingle.strLat1 doubleValue], [objSingle.strLong1 doubleValue])];
            annotationSingle.tag=k;
            annotationSingle.strTitle=objSingle.strName;
            [arrSingle addObject:annotationSingle];
        }
    }
    NSLog(@"%@",dict);
    [mapTags addAnnotations:arrSingle];
    [self getClusterPoints];
}

-(void)getClusterPoints
{
    NSLog(@"%lu",(unsigned long)[dict allKeys].count);
    for (int k=0; k<[dict allKeys].count; k++)
    {
        NSString *str=[NSString stringWithFormat:@"%d",k];
        NSMutableSet *set=[dict objectForKey:str];
        NSMutableArray *arr=[[set allObjects] mutableCopy];
        NSLog(@"%@",arr);
        if (arr.count>1)
        {
            NSLog(@"%d",k);
            ModelListing *objSingle=[arr firstObject];
            // creating custom class for annotation of group point
            customAnnotationGroups *annotationGroups=[[customAnnotationGroups alloc]initWithCoordinate:CLLocationCoordinate2DMake([objSingle.strLat1 doubleValue], [objSingle.strLong1 doubleValue])];
            annotationGroups.groupTags=k;
            annotationGroups.strGroupName=objSingle.strName;
            [arrClusters addObject:annotationGroups];
        }
    }
    [mapTags addAnnotations:arrClusters];
}

#pragma mark
#pragma mark IBACTION
#pragma mark

-(IBAction)btnListPressed:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(removeMapFromSuperview)])
    {
        [self.delegate removeMapFromSuperview];
    }
}

-(void)btnClosePressed:(id)sender
{
    NSLog(@"%ld",(long)calloutTag);
    NSString *str=[NSString stringWithFormat:@"%ld",(long)calloutTag];
    NSMutableSet *set=[dict objectForKey:str];
    NSMutableArray *arr=[[set allObjects] mutableCopy];
    ModelListing *objSegue=[arr firstObject];
    NSLog(@"%@",objSegue.strPicURI);
    LivingTagsViewController *controller=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LivingTagsViewController"];
    controller.objHTML=objSegue;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark
#pragma mark Map View Delegate
#pragma mark

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]])
    {
        return nil;
    }
    // add single points
    if ([annotation isKindOfClass:[CustomAnnotationSingle class]])
    {
        CustomAnnotationSingle *annotationPoint=(CustomAnnotationSingle *)annotation;
        TMAnnotationView *annotationView = (TMAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:NSStringFromClass([TMAnnotationView class])];
        UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pin_main"]];//
        annotationView = [[TMAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:NSStringFromClass([TMAnnotationView class])pinView:img];
        NSLog(@"Title: %@",annotation.title);
        [annotationView setTag:annotationPoint.tag];
        annotationView.canShowCallout=NO;
        return annotationView;
    }
    //add group points
    if ([annotation isKindOfClass:[customAnnotationGroups class]])
    {
        customAnnotationGroups *annotationPoint=(customAnnotationGroups *)annotation;
        static NSString *strIdentifier=@"Custom Annotation1";
        MKAnnotationView* annotationView = [mapTags dequeueReusableAnnotationViewWithIdentifier:strIdentifier];
        if (annotationView)
        {
            annotationView.annotation=annotation;
        }
        else
        {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation
                                                          reuseIdentifier:strIdentifier];
        }
        if (lblAnnotatation)
        {
        
        }
        else
        {
            lblAnnotatation=[[UILabel alloc]initWithFrame:CGRectMake(annotationView.frame.origin.x+4.0f,annotationView.frame.origin.y+5.0f,18,15)];
        }
        [lblAnnotatation setFont:[UIFont systemFontOfSize:8.0f]];
        lblAnnotatation.textColor=[UIColor whiteColor];
        [annotationView addSubview:lblAnnotatation];
        lblAnnotatation.textAlignment=NSTextAlignmentCenter;
        NSLog(@"Title: %@",annotation.title);
        annotationView.image=[UIImage imageNamed:@"pin_main"];
        [annotationView setTag:annotationPoint.groupTags];
        NSString *str=[NSString stringWithFormat:@"%d",annotationPoint.groupTags];
        NSMutableSet *set=[dict objectForKey:str];
        NSMutableArray *arr=[[set allObjects] mutableCopy];
        lblAnnotatation.text=[NSString stringWithFormat:@"%lu",(unsigned long)arr.count];
        annotationView.canShowCallout=NO;
        return annotationView;
    }
    return nil;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{

    [callOutView removeFromSuperview];
    [mapView deselectAnnotation:view.annotation animated:NO];
    if ([view.annotation isKindOfClass:[MKUserLocation class]])
    {
        NSLog(@"User Location");
    }
    if ([view.annotation isKindOfClass:[CustomAnnotationSingle class]])
    {
        calloutTag=view.tag;
        vwAnotationDetails= [self showSelectedCallOutViewWithTag:view.tag];
        CGRect calloutViewFrame = vwAnotationDetails.frame;
        calloutViewFrame=CGRectMake(0, 0, self.view.frame.size.width/1.5, self.view.frame.size.height/7);
        calloutViewFrame.origin = CGPointMake(-calloutViewFrame.size.width/2 + 16, -calloutViewFrame.size.height);
        vwAnotationDetails.frame=calloutViewFrame;
        view.backgroundColor=[UIColor clearColor];
        [view bringSubviewToFront:vwAnotationDetails];
        [view addSubview:vwAnotationDetails];
        [vwAnotationDetails bringSubviewToFront:view];
    }
    if ([view.annotation isKindOfClass:[customAnnotationGroups class]])
    {
        NSLog(@"group annotation id :%ld",(long)view.tag);
        NSString *str=[NSString stringWithFormat:@"%ld",(long)view.tag];
        NSMutableSet *set=[dict objectForKey:str];
        NSMutableArray *arr=[[set allObjects] mutableCopy];
        master=[GroupPopupController instance];
        master.view.frame=CGRectMake(0, 0,self.view.frame.size.width, self.view.frame.size.height);
        master.arrGroupPopup=arr;
        [self.view addSubview:master.view];
        [self addChildViewController:master];
        [master didMoveToParentViewController:self];
        master.delegate=self;
    }
}


#pragma mark
#pragma mark showSelectedCallOutViewWithTag
#pragma mark

-(UIView *)showSelectedCallOutViewWithTag:(NSInteger)TagValue
{
    callOutView=nil;
    callOutView  =[[[NSBundle mainBundle] loadNibNamed:@"myView" owner:self options:nil] objectAtIndex:0];
    UILabel *lblName=(UILabel *)[callOutView viewWithTag:9999];
    UILabel *lblDied=(UILabel *)[callOutView viewWithTag:9998];
    UIImageView *img=(UIImageView *)[callOutView viewWithTag:9997];

    NSString *str=[NSString stringWithFormat:@"%ld",(long)TagValue];
    NSMutableSet *set=[dict objectForKey:str];
    NSMutableArray *arr=[[set allObjects] mutableCopy];
    
    ModelListing *obj=[arr firstObject];
    lblName.text=obj.strName;
    lblDied.text=[NSString stringWithFormat:@"Died-%@",obj.strDied];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [img sd_setImageWithURL:[NSURL URLWithString:obj.strPicURI]
                            placeholderImage:[UIImage imageNamed:@"defltmale_user_icon"]
                                     options:SDWebImageHighPriority
                                    progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                    }
                                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                   }];
    });
    btnClose=(UIButton *)[callOutView viewWithTag:9000];
    [btnClose addTarget:self action:@selector(btnClosePressed:) forControlEvents:UIControlEventTouchUpInside];
    return callOutView;
}

#pragma mark
#pragma mark textfield delegate
#pragma mark

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view removeFromSuperview];
}

#pragma mark 
#pragma mark custom delegate methods
#pragma mark

-(void)removePopup
{
    [master.view removeFromSuperview];
    master=nil;
}

-(void)removePopupWithRow:(ModelListing *)objSelect;
{
    [master.view removeFromSuperview];
    master=nil;
    LivingTagsViewController *controller=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LivingTagsViewController"];
    controller.objHTML=objSelect;
    [self.navigationController pushViewController:controller animated:YES];
}


@end
