//
//  ModelFolders.m
//  LivingTags
//
//  Created by appsbeetech on 28/10/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "ModelFolders.h"

@implementation ModelFolders

-(id)initWithDictionary:(NSDictionary *)dict
{
    if (self=[super init])
    {
        if ([dict objectForKey:@"tkey"]&& ![[dict objectForKey:@"tkey"] isKindOfClass:[NSNull class]])
        {
            self.strTkey=[dict objectForKey:@"tkey"];
        }
        else
        {
            self.strTkey=@"";
        }
        if ([dict objectForKey:@"tagAudioFolder"]&& ![[dict objectForKey:@"tagAudioFolder"] isKindOfClass:[NSNull class]])
        {
            self.strAudioFolder=[dict objectForKey:@"tagAudioFolder"];
        }
        else
        {
            self.strAudioFolder=@"";
        }
        if ([dict objectForKey:@"tagImageFolder"]&& ![[dict objectForKey:@"tagImageFolder"] isKindOfClass:[NSNull class]])
        {
            self.strImageFolder=[dict objectForKey:@"tagImageFolder"];
        }
        else
        {
            self.strImageFolder=@"";
        }
        if ([dict objectForKey:@"tagVideoFolder"]&& ![[dict objectForKey:@"tagVideoFolder"] isKindOfClass:[NSNull class]])
        {
            self.strVideoFolder=[dict objectForKey:@"tagVideoFolder"];
        }
        else
        {
            self.strVideoFolder=@"";
        }
        //tfolder
        if ([dict objectForKey:@"tfolder"]&& ![[dict objectForKey:@"tfolder"] isKindOfClass:[NSNull class]])
        {
            self.strTFolder=[dict objectForKey:@"tfolder"];
        }
        else
        {
            self.strTFolder=@"";
        }
    }
    return self;
}

@end