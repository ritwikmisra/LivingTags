//
//  CameraVideoTextSelectionViewController.m
//  LivingTags
//
//  Created by appsbeetech on 25/08/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "CameraVideoTextSelectionViewController.h"
#import <MapKit/MapKit.h>
#import "CustomAnnotationSingle.h"
#import "TMAnnotationView.h"


@interface CameraVideoTextSelectionViewController ()<MKMapViewDelegate>
{
    IBOutlet MKMapView *mapCamera;
    CAShapeLayer *shapeLayer;
}

@end

@implementation CameraVideoTextSelectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    mapCamera.tintColor = [UIColor redColor];
    mapCamera.showsUserLocation = YES;
    [mapCamera setCenterCoordinate:appDel.location.coordinate animated:YES];
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(appDel.center,900000, 90000);
    MKCoordinateRegion adjustedRegion = [mapCamera regionThatFits:viewRegion];
    [mapCamera setRegion:adjustedRegion animated:YES];
    mapCamera.showsUserLocation = YES;
    mapCamera.delegate=self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
    //draw a slanting line
    if (!shapeLayer)
    {
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(150.0,100.0)];
        [path addLineToPoint:CGPointMake(50.0,60.0)];
        
        shapeLayer = [CAShapeLayer layer];
        shapeLayer.path = [path CGPath];
        shapeLayer.strokeColor = [[UIColor blueColor] CGColor];
        shapeLayer.lineWidth = 3.0;
        shapeLayer.fillColor = [[UIColor greenColor] CGColor];
        
        CABasicAnimation *flash = [CABasicAnimation animationWithKeyPath:@"opacity"];
        flash.fromValue = [NSNumber numberWithFloat:0.0];
        flash.toValue = [NSNumber numberWithFloat:3.0];
        flash.duration = 20.0;        // 1 second
        flash.autoreverses = YES;    // Back
        flash.repeatCount = HUGE;       // Or whatever
        
        [shapeLayer addAnimation:flash forKey:@"flashAnimation"];
        [self.view.layer addSublayer:shapeLayer];
   }
    ////////
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    mapCamera.showsUserLocation=NO;
    mapCamera.delegate=nil;
}


@end
