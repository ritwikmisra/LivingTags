//
//  customAnnotationGroups.h
//  LivingTags
//
//  Created by appsbeetech on 27/05/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
@interface customAnnotationGroups : NSObject

@property(nonatomic,copy)NSString *strGroupName;
@property(nonatomic,assign)int groupTags;
@property(nonatomic,readwrite)CLLocationCoordinate2D coordinate;

-(id)initWithCoordinate:(CLLocationCoordinate2D)coord;

@end
