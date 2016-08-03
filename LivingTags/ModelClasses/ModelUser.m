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
        if ([dict objectForKey:@"id"] && ![[dict objectForKey:@"id"] isKindOfClass:[NSNull class]])
        {
            self.strUserID=[dict objectForKey:@"id"];
            [[NSUserDefaults standardUserDefaults]setValue:self.strUserID forKey:@"user_id"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        else
        {
            self.strUserID=@"";
        }
        if ([dict objectForKey:@"email"] && ![[dict objectForKey:@"email"] isKindOfClass:[NSNull class]])
        {
            self.strEmail=[dict objectForKey:@"email"];
        }
        else
        {
            self.strEmail=@"";
        }
        if ([dict objectForKey:@"name"] && ![[dict objectForKey:@"name"] isKindOfClass:[NSNull class]])
        {
            self.strName=[dict objectForKey:@"name"];
        }
        else
        {
            self.strName=@"";
        }
        if ([dict objectForKey:@"phone"] && ![[dict objectForKey:@"phone"] isKindOfClass:[NSNull class]])
        {
            self.strPhone=[dict objectForKey:@"phone"];
        }
        else
        {
            self.strPhone=@"";
        }
        if ([dict objectForKey:@"pic_uri"] && ![[dict objectForKey:@"pic_uri"] isKindOfClass:[NSNull class]])
        {
            self.strPicURI=[dict objectForKey:@"pic_uri"];
        }
        else
        {
            self.strPicURI=@"";
        }
        if ([dict objectForKey:@"video_uri"] && ![[dict objectForKey:@"video_uri"] isKindOfClass:[NSNull class]])
        {
            self.strVideoURI=[dict objectForKey:@"video_uri"];
        }
        else
        {
            self.strVideoURI=@"";
        }
        if ([dict objectForKey:@"address"] && ![[dict objectForKey:@"address"] isKindOfClass:[NSNull class]])
        {
            self.strAddress=[dict objectForKey:@"address"];
        }
        else
        {
            self.strAddress=@"";
        }
        if ([dict objectForKey:@"lat"] && ![[dict objectForKey:@"lat"] isKindOfClass:[NSNull class]])
        {
            self.strLat=[dict objectForKey:@"lat"];
        }
        else
        {
            self.strLat=@"";
        }
        if ([dict objectForKey:@"long"] && ![[dict objectForKey:@"long"] isKindOfClass:[NSNull class]])
        {
            self.strLong=[dict objectForKey:@"long"];
        }
        else
        {
            self.strLong=@"";
        }
        if ([dict objectForKey:@"pic_uri_40x40"] && ![[dict objectForKey:@"pic_uri_40x40"] isKindOfClass:[NSNull class]])
        {
            self.strPicURI40=[dict objectForKey:@"pic_uri_40x40"];
        }
        else
        {
            self.strPicURI40=@"";
        }
        if ([dict objectForKey:@"pic_uri"] && ![[dict objectForKey:@"pic_uri"] isKindOfClass:[NSNull class]])
        {
            self.strPicURI160=[dict objectForKey:@"pic_uri"];
        }
        else
        {
            self.strPicURI160=@"";
        }
    }
    return self;
}
@end
