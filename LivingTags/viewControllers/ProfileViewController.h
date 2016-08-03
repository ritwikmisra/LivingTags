//
//  ProfileViewController.h
//  LivingTags
//
//  Created by appsbeetech on 28/04/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "ViewControllerBaseClassViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import <CoreLocation/CoreLocation.h>
#import <GooglePlaces/GooglePlaces.h>
#import <GooglePlacePicker/GooglePlacePicker.h>

@interface ProfileViewController : ViewControllerBaseClassViewController

@property (nonatomic,strong) CLLocationManager *locationManager;

@end
