//
//  ModelEditTagsListing.m
//  LivingTags
//
//  Created by appsbeetech on 09/11/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "ModelEditTagsListing.h"

@implementation ModelEditTagsListing

-(id)initWithDictionary:(NSDictionary *)dict
{
   // akey
    if (self=[super init])
    {
        if ([dict objectForKey:@"akey"] && ![[dict objectForKey:@"akey"] isKindOfClass:[NSNull class]])
        {
            self.strAkey=[dict objectForKey:@"akey"];
        }
        else
        {
            self.strAkey=@"";
        }
        
        //tkey
        
        if ([dict objectForKey:@"tkey"] && ![[dict objectForKey:@"tkey"] isKindOfClass:[NSNull class]])
        {
            self.strtkey=[dict objectForKey:@"tkey"];
        }
        else
        {
            self.strtkey=@"";
        }
        
        //tphoto
        
        if ([dict objectForKey:@"tphoto"] && ![[dict objectForKey:@"tphoto"] isKindOfClass:[NSNull class]])
        {
            self.strtphoto=[dict objectForKey:@"tphoto"];
        }
        else
        {
            self.strtphoto=@"";
        }
        
        //tname
        
        if ([dict objectForKey:@"tname"] && ![[dict objectForKey:@"tname"] isKindOfClass:[NSNull class]])
        {
            self.strTname=[dict objectForKey:@"tname"];
        }
        else
        {
            self.strTname=@"";
        }
        
        //cname
        
        if ([dict objectForKey:@"cname"] && ![[dict objectForKey:@"cname"] isKindOfClass:[NSNull class]])
        {
            self.strCname=[dict objectForKey:@"cname"];
        }
        else
        {
            self.strCname=@"";
        }
        //total_comments
        
        if ([dict objectForKey:@"total_comments"] && ![[dict objectForKey:@"total_comments"] isKindOfClass:[NSNull class]])
        {
            self.strTotal_comments=[dict objectForKey:@"total_comments"];
        }
        else
        {
            self.strTotal_comments=@"";
        }
        
        //total_views
        
        if ([dict objectForKey:@"total_views"] && ![[dict objectForKey:@"total_views"] isKindOfClass:[NSNull class]])
        {
            self.strTotal_views=[dict objectForKey:@"total_views"];
        }
        else
        {
            self.strTotal_views=@"";
        }
        
        //tsize
        
        if ([dict objectForKey:@"tsize"] && ![[dict objectForKey:@"tsize"] isKindOfClass:[NSNull class]])
        {
            self.strTsize=[dict objectForKey:@"tsize"];
        }
        else
        {
            self.strTsize=@"";
        }
        
        //posted_time
        
        if ([dict objectForKey:@"posted_time"] && ![[dict objectForKey:@"posted_time"] isKindOfClass:[NSNull class]])
        {
            self.strPosted_time=[dict objectForKey:@"posted_time"];
        }
        else
        {
            self.strPosted_time=@"";
        }
    }
    return self;
}

@end
