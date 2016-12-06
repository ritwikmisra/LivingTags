//
//  ModelAssetDetails.m
//  LivingTags
//
//  Created by appsbeetech on 06/12/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "ModelAssetDetails.h"

@implementation ModelAssetDetails

-(id)initwithDictionary:(NSDictionary *)dict
{
    if ([super init])
    {
        //tckey
        if ([dict objectForKey:@"tckey"] && ![[dict objectForKey:@"tckey"] isKindOfClass:[NSNull class]])
        {
            self.strTCKey=[dict objectForKey:@"tckey"];
        }
        else
        {
            self.strTCKey=@"";
        }

        //tcatype
        if ([dict objectForKey:@"tcatype"] && ![[dict objectForKey:@"tcatype"] isKindOfClass:[NSNull class]])
        {
            self.strTCAType=[dict objectForKey:@"tcatype"];
        }
        else
        {
            self.strTCAType=@"";
        }

        //tcakey
        if ([dict objectForKey:@"tcakey"] && ![[dict objectForKey:@"tcakey"] isKindOfClass:[NSNull class]])
        {
            self.strTCAkey=[dict objectForKey:@"tcakey"];
        }
        else
        {
            self.strTCAkey=@"";
        }

        //tcaasset_thumb
        if ([dict objectForKey:@"tcaasset_thumb"] && ![[dict objectForKey:@"tcaasset_thumb"] isKindOfClass:[NSNull class]])
        {
            self.strAssetsThumb=[dict objectForKey:@"tcaasset_thumb"];
        }
        else
        {
            self.strAssetsThumb=@"";
        }

        //tcaassetsize
        if ([dict objectForKey:@"tcaassetsize"] && ![[dict objectForKey:@"tcaassetsize"] isKindOfClass:[NSNull class]])
        {
            self.strAssetsSize=[dict objectForKey:@"tcaassetsize"];
        }
        else
        {
            self.strAssetsSize=@"";
        }
        //tcaasset
        if ([dict objectForKey:@"tcaasset"] && ![[dict objectForKey:@"tcaasset"] isKindOfClass:[NSNull class]])
        {
            self.strAssets=[dict objectForKey:@"tcaasset"];
        }
        else
        {
            self.strAssets=@"";
        }

    }
    return [super init];
}

@end
