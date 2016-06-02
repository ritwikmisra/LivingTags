//
//  CustomAnnotationSingle.h
//  LivingTags
//
//  Created by appsbeetech on 27/05/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface CustomAnnotationSingle : NSObject<MKAnnotation>

@property(nonatomic,copy)NSString *strTitle;
@property(nonatomic,readwrite)CLLocationCoordinate2D coordinate;
@property(nonatomic,assign)int tag;

-(id)initWithCoordinate:(CLLocationCoordinate2D)coord;


@end
