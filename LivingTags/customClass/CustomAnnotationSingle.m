//
//  CustomAnnotationSingle.m
//  LivingTags
//
//  Created by appsbeetech on 27/05/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "CustomAnnotationSingle.h"

@implementation CustomAnnotationSingle

-(id)initWithCoordinate:(CLLocationCoordinate2D)coord;
{
    if (self=[super init]) // assuming init is the designated initialiser of the super class
    {
        self.coordinate=coord;
    }
    return self;
}

- (NSString *)title
{
    if ([self.strTitle isKindOfClass:[NSNull class]])
        return @"hh";
    else
        return self.strTitle;
}
@end
