//
//  MyTagsEditModeController.h
//  LivingTags
//
//  Created by appsbeetech on 09/11/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "ViewControllerBaseClassViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import <CoreLocation/CoreLocation.h>
#import <GooglePlaces/GooglePlaces.h>
#import <GooglePlacePicker/GooglePlacePicker.h>


@interface MyTagsEditModeController : ViewControllerBaseClassViewController

@property(nonatomic,strong)NSString *strTagName;
@property(nonatomic,strong)NSString *strTKey;

@end
