//
//  ModelMyTagsCount.m
//  LivingTags
//
//  Created by appsbeetech on 07/11/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "ModelMyTagsCount.h"

@implementation ModelMyTagsCount

-(id)initWithDictionary:(NSDictionary *)dict
{
    if (self=[super init])
    {
        if ([dict objectForKey:@"id"] && ![[dict objectForKey:@"id"] isKindOfClass:[NSNull class]])
        {
            self.strId=[dict objectForKey:@"id"];
        }
        else
        {
            self.strId=@"";
        }
        if ([dict objectForKey:@"tcname"] && ![[dict objectForKey:@"tcname"] isKindOfClass:[NSNull class]])
        {
            self.strTcname=[dict objectForKey:@"tcname"];
        }
        else
        {
            self.strTcname=@"";
        }
        if ([dict objectForKey:@"totaltags"] && ![[dict objectForKey:@"totaltags"] isKindOfClass:[NSNull class]])
        {
            self.strTotaltags=[dict objectForKey:@"totaltags"];
        }
        else
        {
            self.strTotaltags=@"";
        }
        //tckey
        if ([dict objectForKey:@"tckey"] && ![[dict objectForKey:@"tckey"] isKindOfClass:[NSNull class]])
        {
            self.strTCKey=[dict objectForKey:@"tckey"];
        }
        else
        {
            self.strTCKey=@"";
        }

        
    }
    return self;
}

@end
