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
#import <GooglePlaces/GooglePlaces.h>
#import <GooglePlacePicker/GooglePlacePicker.h>
#import <GoogleMaps/GoogleMaps.h>
#import <CoreLocation/CoreLocation.h>

@interface TagItViewController ()<MKMapViewDelegate>
{
    IBOutlet MKMapView *mapTagIT;
    IBOutlet UITextField *txtSearch;
    GMSPlacePicker *placePicker;
}

@end

@implementation TagItViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [txtSearch setValue:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self displayNetworkActivity];
    mapTagIT.tintColor = [UIColor redColor];
    mapTagIT.showsUserLocation = YES;
    [mapTagIT setCenterCoordinate:appDel.location.coordinate animated:YES];
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(appDel.center,900000, 90000);
    MKCoordinateRegion adjustedRegion = [mapTagIT regionThatFits:viewRegion];
    [mapTagIT setRegion:adjustedRegion animated:YES];
    mapTagIT.userLocation.title=appDel.objUser.strName;
    mapTagIT.delegate=self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark
#pragma mark MAP VIEW DELEGATE
#pragma mark

- (void)mapViewDidFinishRenderingMap:(MKMapView *)mapView fullyRendered:(BOOL)fullyRendered
{
    if (fullyRendered)
    {
        [self hideNetworkActivity];
    }
 }

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

/*-(IBAction)btnAddressPressed:(id)sender
{
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
            NSLog(@"place.name:%@",place.name);
            
            [[GMSGeocoder geocoder] reverseGeocodeCoordinate:CLLocationCoordinate2DMake(place.coordinate.latitude, place.coordinate.longitude) completionHandler:^(GMSReverseGeocodeResponse* response, NSError* error)
             {
                 NSString *strLat=[NSString stringWithFormat:@"%f",place.coordinate.latitude];
                 NSString *strLong=[NSString stringWithFormat:@"%f",place.coordinate.longitude];
                 
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
                     break;
                 }
             }];
            NSLog(@"place.formattedAddress:%@",place.formattedAddress);
        }
        else
        {
        }
    }];
}*/

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
