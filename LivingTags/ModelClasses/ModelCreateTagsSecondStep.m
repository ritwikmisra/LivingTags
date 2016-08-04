//
//  ModelCreateTagsSecondStep.m
//  LivingTags
//
//  Created by appsbeetech on 19/07/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "ModelCreateTagsSecondStep.h"

@implementation ModelCreateTagsSecondStep

-(id)initWithDictionary:(NSDictionary *)dict
{
    if (self=[super init])
    {
        if ([dict objectForKey:@"id"] && ![[dict objectForKey:@"id"] isKindOfClass:[NSNull class]])
        {
            self.strID=[dict objectForKey:@"id"];
        }
        else
        {
            self.strID=@"";
        }
        
        if ([dict objectForKey:@"account_id"] && ![[dict objectForKey:@"account_id"] isKindOfClass:[NSNull class]])
        {
            self.strAccountID=[dict objectForKey:@"account_id"];
        }
        else
        {
            self.strAccountID=@"";
        }
        if ([dict objectForKey:@"template_id"] && ![[dict objectForKey:@"template_id"] isKindOfClass:[NSNull class]])
        {
            self.strTemplateID=[dict objectForKey:@"template_id"];
        }
        else
        {
            self.strTemplateID=@"";
        }
        if ([dict objectForKey:@"cover_uri"] && ![[dict objectForKey:@"cover_uri"] isKindOfClass:[NSNull class]])
        {
            self.strCoverURI=[dict objectForKey:@"cover_uri"] ;
        }
        else
        {
            self.strCoverURI=@"";
        }
        if ([dict objectForKey:@"photo_uri"] && ![[dict objectForKey:@"photo_uri"] isKindOfClass:[NSNull class]])
        {
            self.strUserPicURI=[dict objectForKey:@"photo_uri"];
        }
        else
        {
            self.strUserPicURI=@"";
        }
        NSLog(@"%@",dict);
        if ([dict objectForKey:@"name"] && ![[dict objectForKey:@"name"] isKindOfClass:[NSNull class]])
        {
            self.strName=[dict objectForKey:@"name"];
        }
        else
        {
            self.strName=@"";
        }
        if ([dict objectForKey:@"born"] && ![[dict objectForKey:@"born"] isKindOfClass:[NSNull class]])
        {
            self.strBorn=[dict objectForKey:@"born"];
        }
        else
        {
            self.strBorn=@"";
        }
        if ([dict objectForKey:@"died"] && ![[dict objectForKey:@"died"] isKindOfClass:[NSNull class]])
        {
            self.strDied=[dict objectForKey:@"died"];
        }
        else
        {
            self.strDied=@"";
        }
        if ([dict objectForKey:@"lat1"] && ![[dict objectForKey:@"lat1"] isKindOfClass:[NSNull class]])
        {
            self.strLat1=[dict objectForKey:@"lat1"] ;
        }
        else
        {
            self.strLat1=@"";
        }
        if ([dict objectForKey:@"long1"] && ![[dict objectForKey:@"long1"] isKindOfClass:[NSNull class]])
        {
            self.strLong1=[dict objectForKey:@"long1"];
        }
        else
        {
            self.strLong1=@"";
        }
        if ([dict objectForKey:@"lat2"] && ![[dict objectForKey:@"lat2"] isKindOfClass:[NSNull class]])
        {
            self.strLat2=[dict objectForKey:@"lat2"];
        }
        else
        {
            self.strLat2=@"";
        }
        if ([dict objectForKey:@"long2"] && ![[dict objectForKey:@"long2"] isKindOfClass:[NSNull class]])
        {
            self.strLong2=[dict objectForKey:@"long2"];
        }
        else
        {
            self.strLong2=@"";
        }
        if ([dict objectForKey:@"lat3"] && ![[dict objectForKey:@"lat3"] isKindOfClass:[NSNull class]])
        {
            self.strLat3=[dict objectForKey:@"lat3"];
        }
        else
        {
            self.strLat3=@"";
        }
        if ([dict objectForKey:@"long3"] && ![[dict objectForKey:@"long3"] isKindOfClass:[NSNull class]])
        {
            self.strLong3=[dict objectForKey:@"long3"];
        }
        else
        {
            self.strLong3=@"";
        }
        if ([dict objectForKey:@"memorial_quote"] && ![[dict objectForKey:@"memorial_quote"] isKindOfClass:[NSNull class]])
        {
            self.strMemorialQuote=[dict objectForKey:@"memorial_quote"] ;
        }
        else
        {
            self.strMemorialQuote=@"";
        }
       if ([dict objectForKey:@"gender"] && ![[dict objectForKey:@"gender"] isKindOfClass:[NSNull class]])
        {
            self.strGender=[dict objectForKey:@"gender"];
        }
        else
        {
            self.strGender=@"";
        }
    }
    return self;
}

@end
