//
//  ModelListing.m
//  LivingTags
//
//  Created by appsbeetech on 17/05/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "ModelListing.h"

@implementation ModelListing

-(id)initWithDictionary:(NSDictionary *)dict
{
    if (self=[super init])
    {
        //id
        if ([dict objectForKey:@"id"]&& ![[dict objectForKey:@"id"] isKindOfClass:[NSNull class]])
        {
            self.strID=[dict objectForKey:@"id"];
        }
        else
        {
            self.strID=@"";
        }
        //account id
        if ([dict objectForKey:@"account_id"]&& ![[dict objectForKey:@"account_id"] isKindOfClass:[NSNull class]])
        {
            self.strUserID=[dict objectForKey:@"account_id"];
        }
        else
        {
            self.strUserID=@"";
        }
        //template_id
        if ([dict objectForKey:@"template_id"]&& ![[dict objectForKey:@"template_id"] isKindOfClass:[NSNull class]])
        {
            self.strTemplateID=[dict objectForKey:@"template_id"];
        }
        else
        {
            self.strTemplateID=@"";
        }
        //cover_uri
        if ([dict objectForKey:@"cover_uri"]&& ![[dict objectForKey:@"cover_uri"] isKindOfClass:[NSNull class]])
        {
            self.strCoverURI=[dict objectForKey:@"cover_uri"];
        }
        else
        {
            self.strCoverURI=@"";
        }
        //photo_uri
        if ([dict objectForKey:@"photo_uri"]&& ![[dict objectForKey:@"photo_uri"] isKindOfClass:[NSNull class]])
        {
            self.strPicURI=[dict objectForKey:@"photo_uri"];
        }
        else
        {
            self.strPicURI=@"";
        }
        //name
        if ([dict objectForKey:@"name"]&& ![[dict objectForKey:@"name"] isKindOfClass:[NSNull class]])
        {
            self.strName=[dict objectForKey:@"name"];
        }
        else
        {
            self.strName=@"";
        }
        //born
        if ([dict objectForKey:@"born"]&& ![[dict objectForKey:@"born"] isKindOfClass:[NSNull class]])
        {
            self.strBorn=[dict objectForKey:@"born"];
        }
        else
        {
            self.strBorn=@"";
        }
        // died
        if ([dict objectForKey:@"died"]&& ![[dict objectForKey:@"died"] isKindOfClass:[NSNull class]])
        {
            self.strDied=[dict objectForKey:@"died"];
        }
        else
        {
            self.strDied=@"";
        }
        //address1
        if ([dict objectForKey:@"address1"]&& ![[dict objectForKey:@"address1"] isKindOfClass:[NSNull class]])
        {
            self.strAddress1=[dict objectForKey:@"address1"];
        }
        else
        {
            self.strAddress1=@"";
        }
        //lat1
        if ([dict objectForKey:@"lat1"]&& ![[dict objectForKey:@"lat1"] isKindOfClass:[NSNull class]])
        {
            self.strLat1=[dict objectForKey:@"lat1"];
        }
        else
        {
            self.strLat1=@"";
        }
        //long1
        if ([dict objectForKey:@"long1"]&& ![[dict objectForKey:@"long1"] isKindOfClass:[NSNull class]])
        {
            self.strLong1=[dict objectForKey:@"long1"];
        }
        else
        {
            self.strLong1=@"";
        }
        //address2
        if ([dict objectForKey:@"address2"]&& ![[dict objectForKey:@"address2"] isKindOfClass:[NSNull class]])
        {
            self.strAddress2=[dict objectForKey:@"address2"];
        }
        else
        {
            self.strAddress2=@"";
        }
        //lat2
        if ([dict objectForKey:@"lat2"]&& ![[dict objectForKey:@"lat2"] isKindOfClass:[NSNull class]])
        {
            self.strLat2=[dict objectForKey:@"lat2"];
        }
        else
        {
            self.strLat2=@"";
        }
        //long2
        if ([dict objectForKey:@"long2"]&& ![[dict objectForKey:@"long2"] isKindOfClass:[NSNull class]])
        {
            self.strLong2=[dict objectForKey:@"long2"];
        }
        else
        {
            self.strLong2=@"";
        }
        //address3
        if ([dict objectForKey:@"address3"]&& ![[dict objectForKey:@"address3"] isKindOfClass:[NSNull class]])
        {
            self.strAddress3=[dict objectForKey:@"address3"];
        }
        else
        {
            self.strAddress3=@"";
        }
        //lat3
        if ([dict objectForKey:@"lat3"]&& ![[dict objectForKey:@"lat3"] isKindOfClass:[NSNull class]])
        {
            self.strLatitude3=[dict objectForKey:@"lat3"];
        }
        else
        {
            self.strLatitude3=@"";
        }
        //long3
        if ([dict objectForKey:@"long3"]&& ![[dict objectForKey:@"long3"] isKindOfClass:[NSNull class]])
        {
            self.strLongitude3=[dict objectForKey:@"long3"];
        }
        else
        {
            self.strLongitude3=@"";
        }
        //web_uri
        if ([dict objectForKey:@"web_uri"]&& ![[dict objectForKey:@"web_uri"] isKindOfClass:[NSNull class]])
        {
            self.strWebURI=[dict objectForKey:@"web_uri"];
        }
        else
        {
            self.strWebURI=@"";
        }
        //created
        if ([dict objectForKey:@"created"]&& ![[dict objectForKey:@"created"] isKindOfClass:[NSNull class]])
        {
            self.strCreated=[dict objectForKey:@"created"];
        }
        else
        {
            self.strCreated=@"";
        }
    }
    return self;
}

@end
