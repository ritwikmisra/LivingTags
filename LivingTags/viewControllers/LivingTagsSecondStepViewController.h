//
//  LivingTagsSecondStepViewController.h
//  LivingTags
//
//  Created by appsbeetech on 12/07/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "ViewControllerBaseClassViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import <CoreLocation/CoreLocation.h>
#import <GooglePlaces/GooglePlaces.h>
#import <GooglePlacePicker/GooglePlacePicker.h>

@interface LivingTagsSecondStepViewController : ViewControllerBaseClassViewController

@property(nonatomic,strong)NSString *strTagName;
@property(nonatomic,strong)NSString *strToken;

@end
