//
//  ModelFindObituary.m
//  LivingTags
//
//  Created by appsbeetech on 01/12/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "ModelFindObituary.h"

@implementation ModelFindObituary

-(id)initWithDictionary:(NSDictionary *)dict
{
    if (self=[super init])
    {
        //id
        if ([dict objectForKey:@"id"] && ![[dict objectForKey:@"id"] isKindOfClass:[NSNull class]])
        {
            self.strID=[dict objectForKey:@"id"];
        }
        else
        {
            self.strID=@"";
        }

       // age
        if ([dict objectForKey:@"age"] && ![[dict objectForKey:@"age"] isKindOfClass:[NSNull class]])
        {
            self.strDate=[dict objectForKey:@"age"];
        }
        else
        {
            self.strDate=@"";
        }

        //name
        if ([dict objectForKey:@"name"] && ![[dict objectForKey:@"name"] isKindOfClass:[NSNull class]])
        {
            self.strName=[dict objectForKey:@"name"];
        }
        else
        {
            self.strName=@"";
        }

        //photo
        if ([dict objectForKey:@"photo"] && ![[dict objectForKey:@"photo"] isKindOfClass:[NSNull class]])
        {
            self.strObituaryPic=[dict objectForKey:@"photo"];
        }
        else
        {
            self.strObituaryPic=@"";
        }
    }
    return self;
}

@end
