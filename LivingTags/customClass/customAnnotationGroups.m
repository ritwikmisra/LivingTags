//
//  customAnnotationGroups.m
//  LivingTags
//
//  Created by appsbeetech on 27/05/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "customAnnotationGroups.h"

@implementation customAnnotationGroups

-(id)initWithCoordinate:(CLLocationCoordinate2D)coord
{
    self=[super init];
    if (self)
    {
        self.coordinate=coord;
    }
    return self;
}

-(NSString *)title
{
    if ([self.strGroupName isKindOfClass:[NSNull class]])
        return @"";
    else
        return self.strGroupName;

}

@end
