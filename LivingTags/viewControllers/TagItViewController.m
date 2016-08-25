//
//  TagItViewController.m
//  LivingTags
//
//  Created by appsbeetech on 25/08/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "TagItViewController.h"
#import <MapKit/MapKit.h>
#import "CustomAnnotationSingle.h"
#import "TMAnnotationView.h"

@interface TagItViewController ()<MKMapViewDelegate>
{
    IBOutlet MKMapView *mapTagIT;
}

@end

@implementation TagItViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    mapTagIT.tintColor = [UIColor redColor];
    mapTagIT.showsUserLocation = YES;
    [mapTagIT setCenterCoordinate:appDel.location.coordinate animated:YES];
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(appDel.center,900000, 90000);
    MKCoordinateRegion adjustedRegion = [mapTagIT regionThatFits:viewRegion];
    [mapTagIT setRegion:adjustedRegion animated:YES];
    mapTagIT.showsUserLocation = YES;
    mapTagIT.userLocation.title=appDel.objUser.strName;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    mapTagIT.delegate=self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark
#pragma mark MAP VIEW DELEGATE
#pragma mark

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]])
    {
        TMAnnotationView *annotationView = (TMAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:NSStringFromClass([TMAnnotationView class])];
        UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"blue-location-icon-png-19"]];//
        annotationView = [[TMAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:NSStringFromClass([TMAnnotationView class])pinView:img];
        NSLog(@"Title: %@",annotation.title);
        [annotationView setTag:-1];
        annotationView.canShowCallout=YES;
        return annotationView;
    }
    return nil;
}
#pragma mark
#pragma mark IBACTIONS
#pragma mark

-(IBAction)btnSkipPressed:(id)sender
{
    
}

-(IBAction)btnNextPressed:(id)sender
{
    [self performSegueWithIdentifier:@"segueCameraVideoSelection" sender:self];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    mapTagIT.showsUserLocation=NO;
    mapTagIT.delegate=nil;
}
@end
