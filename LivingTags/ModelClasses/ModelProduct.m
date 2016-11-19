//
//  ModelProduct.m
//  LivingTags
//
//  Created by appsbeetech on 18/11/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "ModelProduct.h"

@implementation ModelProduct

-(id)initWithDictionary:(NSDictionary *)dict
{
    if (self=[super init])
    {
        //id
        if ([dict objectForKey:@"id"] && ![[dict objectForKey:@"id"] isKindOfClass:[NSNull class]])
        {
            self.strId=[dict objectForKey:@"id"];
        }
        else
        {
            self.strId=@"";
        }

        //pkey
        if ([dict objectForKey:@"pkey"] && ![[dict objectForKey:@"pkey"] isKindOfClass:[NSNull class]])
        {
            self.strPkey=[dict objectForKey:@"pkey"];
        }
        else
        {
            self.strPkey=@"";
        }

        //pfolder
        if ([dict objectForKey:@"pfolder"] && ![[dict objectForKey:@"pfolder"] isKindOfClass:[NSNull class]])
        {
            self.strPfolder=[dict objectForKey:@"pfolder"];
        }
        else
        {
            self.strPfolder=@"";
        }

        //pname
        if ([dict objectForKey:@"pname"] && ![[dict objectForKey:@"pname"] isKindOfClass:[NSNull class]])
        {
            self.strPname=[dict objectForKey:@"pname"];
        }
        else
        {
            self.strPname=@"";
        }

        //puri
        if ([dict objectForKey:@"puri"] && ![[dict objectForKey:@"puri"] isKindOfClass:[NSNull class]])
        {
            self.strPuri=[dict objectForKey:@"puri"];
        }
        else
        {
            self.strPuri=@"";
        }

        //pprice
        if ([dict objectForKey:@"pprice"] && ![[dict objectForKey:@"pprice"] isKindOfClass:[NSNull class]])
        {
            self.strPrice=[dict objectForKey:@"pprice"];
        }
        else
        {
            self.strPrice=@"";
        }

        //pabout
        if ([dict objectForKey:@"pabout"] && ![[dict objectForKey:@"pabout"] isKindOfClass:[NSNull class]])
        {
            self.strPabout=[dict objectForKey:@"pabout"];
        }
        else
        {
            self.strPabout=@"";
        }

        //pavailable
        if ([dict objectForKey:@"pavailable"] && ![[dict objectForKey:@"pavailable"] isKindOfClass:[NSNull class]])
        {
            self.strPavailable=[dict objectForKey:@"pavailable"];
        }
        else
        {
            self.strPavailable=@"";
        }

        //ppuri
        if ([dict objectForKey:@"ppuri"] && ![[dict objectForKey:@"ppuri"] isKindOfClass:[NSNull class]])
        {
            self.strPuri=[dict objectForKey:@"ppuri"];
        }
        else
        {
            self.strPuri=@"";
        }

    }
    return self;
}

@end
