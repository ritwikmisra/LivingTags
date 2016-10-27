//
//  ModelUser.m
//  LivingTags
//
//  Created by appsbeetech on 28/04/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "ModelUser.h"

@implementation ModelUser

-(id)initWithDictionary:(NSDictionary *)dict
{
    if (self=[super init])
    {
        if ([dict objectForKey:@"akey"] && ![[dict objectForKey:@"akey"] isKindOfClass:[NSNull class]])
        {
            self.strKey=[dict objectForKey:@"akey"];
        }
        else
        {
            self.strKey=@"";
        }
        if ([dict objectForKey:@"aemail"] && ![[dict objectForKey:@"aemail"] isKindOfClass:[NSNull class]])
        {
            self.strEmail=[dict objectForKey:@"aemail"];
        }
        else
        {
            self.strEmail=@"";
        }
        if ([dict objectForKey:@"tname"] && ![[dict objectForKey:@"tname"] isKindOfClass:[NSNull class]])
        {
            self.strName=[dict objectForKey:@"tname"];
        }
        else
        {
            self.strName=@"";
        }
        if ([dict objectForKey:@"tphone"] && ![[dict objectForKey:@"tphone"] isKindOfClass:[NSNull class]])
        {
            self.strPhone=[dict objectForKey:@"tphone"];
        }
        else
        {
            self.strPhone=@"";
        }
        if ([dict objectForKey:@"tphoto"] && ![[dict objectForKey:@"tphoto"] isKindOfClass:[NSNull class]])
        {
            self.strPicURI=[dict objectForKey:@"tphoto"];
        }
        else
        {
            self.strPicURI=@"";
        }
        if ([dict objectForKey:@"taddress1"] && ![[dict objectForKey:@"taddress1"] isKindOfClass:[NSNull class]])
        {
            self.strAddress=[dict objectForKey:@"taddress1"];
        }
        else
        {
            self.strAddress=@"";
        }
        if ([dict objectForKey:@"tlat1"] && ![[dict objectForKey:@"tlat1"] isKindOfClass:[NSNull class]])
        {
            self.strLat=[dict objectForKey:@"tlat1"];
        }
        else
        {
            self.strLat=@"";
        }
        if ([dict objectForKey:@"tlong1"] && ![[dict objectForKey:@"tlong1"] isKindOfClass:[NSNull class]])
        {
            self.strLong=[dict objectForKey:@"tlong1"];
        }
        else
        {
            self.strLong=@"";
        }
    }
    return self;
}
@end
