//
//  ModelViewLocalTags.m
//  LivingTags
//
//  Created by appsbeetech on 23/11/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "ModelViewLocalTags.h"

@implementation ModelViewLocalTags

-(id)initWithDictionary:(NSDictionary *)dict
{
    self=[super init];
    if (self)
    {
        //tphoto
        if ([dict objectForKey:@"tphoto"] && ![[dict objectForKey:@"tphoto"] isKindOfClass:[NSNull class]])
        {
            self.strTPhoto=[dict objectForKey:@"tphoto"];
            if ([self.strTPhoto containsString:@"https"])
            {
                self.strTPhoto=[self.strTPhoto stringByReplacingOccurrencesOfString:@"https" withString:@"http"];
            }
        }
        else
        {
            self.strTPhoto=@"";
        }

        //tname
        if ([dict objectForKey:@"tname"] && ![[dict objectForKey:@"tname"] isKindOfClass:[NSNull class]])
        {
            self.strName=[dict objectForKey:@"tname"];
        }
        else
        {
            self.strName=@"";
        }

        //tlat1
        if ([dict objectForKey:@"tlat1"] && ![[dict objectForKey:@"tlat1"] isKindOfClass:[NSNull class]])
        {
            self.strLat1=[dict objectForKey:@"tlat1"];
        }
        else
        {
            self.strLat1=@"";
        }

        //tlong1
        if ([dict objectForKey:@"tlong1"] && ![[dict objectForKey:@"tlong1"] isKindOfClass:[NSNull class]])
        {
            self.strLong1=[dict objectForKey:@"tlong1"];
        }
        else
        {
            self.strLong1=@"";
        }

        //tlink
        if ([dict objectForKey:@"tlink"] && ![[dict objectForKey:@"tlink"] isKindOfClass:[NSNull class]])
        {
            self.strLink=[dict objectForKey:@"tlink"];
        }
        else
        {
            self.strLink=@"";
        }

        //tcreated
        if ([dict objectForKey:@"tcreated"] && ![[dict objectForKey:@"tcreated"] isKindOfClass:[NSNull class]])
        {
            self.strCreated=[dict objectForKey:@"tcreated"];
        }
        else
        {
            self.strCreated=@"";
        }

        //distance
        if ([dict objectForKey:@"distance"] && ![[dict objectForKey:@"distance"] isKindOfClass:[NSNull class]])
        {
            self.strDistance=[dict objectForKey:@"distance"];
        }
        else
        {
            self.strDistance=@"";
        }
       // posted_time
        if ([dict objectForKey:@"posted_time"] && ![[dict objectForKey:@"posted_time"] isKindOfClass:[NSNull class]])
        {
            self.strPostedOn=[dict objectForKey:@"posted_time"];
        }
        else
        {
            self.strPostedOn=@"";
        }
    }
    return self;
}

@end
