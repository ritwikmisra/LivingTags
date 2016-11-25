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
            [[NSUserDefaults standardUserDefaults]setObject:self.strKey forKey:@"akey"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            NSLog(@"Original ID:%@.....ID from cache..%@",self.strKey,[[NSUserDefaults standardUserDefaults] objectForKey:@"akey"]);
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
            if ([self.strPicURI containsString:@"https"])
            {
                self.strPicURI=[self.strPicURI stringByReplacingOccurrencesOfString:@"https" withString:@"http"];
            }
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
        if ([dict objectForKey:@"afolder"] && ![[dict objectForKey:@"afolder"] isKindOfClass:[NSNull class]])
        {
            self.strAfolder=[dict objectForKey:@"afolder"];
        }
        else
        {
            self.strAfolder=@"";
        }
        if ([dict objectForKey:@"profileImageFolder"] && ![[dict objectForKey:@"profileImageFolder"] isKindOfClass:[NSNull class]])
        {
            self.strProfilePicFolder=[dict objectForKey:@"profileImageFolder"];
        }
        else
        {
            self.strProfilePicFolder=@"";
        }
        
        if ([dict objectForKey:@"tkey"] && ![[dict objectForKey:@"tkey"] isKindOfClass:[NSNull class]])
        {
            self.strTkey=[dict objectForKey:@"tkey"];
        }
        else
        {
            self.strTkey=@"";
        }
        //astorage
        if ([dict objectForKey:@"astorage"] && ![[dict objectForKey:@"astorage"] isKindOfClass:[NSNull class]])
        {
            self.strTotalStorage=[dict objectForKey:@"astorage"];
        }
        else
        {
            self.strTotalStorage=@"";
        }
        //tsize
        
        if ([dict objectForKey:@"tsize"] && ![[dict objectForKey:@"tsize"] isKindOfClass:[NSNull class]])
        {
            self.strStorageUsed=[dict objectForKey:@"tsize"];
        }
        else
        {
            self.strStorageUsed=@"";
        }
        //tag_counts
        
        if ([dict objectForKey:@"tag_counts"] && ![[dict objectForKey:@"tag_counts"] isKindOfClass:[NSNull class]])
        {
            self.strTagCounts=[dict objectForKey:@"tag_counts"];
        }
        else
        {
            self.strTagCounts=@"";
        }
        //akey
        if ([dict objectForKey:@"akey"] && ![[dict objectForKey:@"akey"] isKindOfClass:[NSNull class]])
        {
            self.strAkey=[dict objectForKey:@"akey"];
        }
        else
        {
            self.strAkey=@"";
        }

    }
    return self;
}
@end
