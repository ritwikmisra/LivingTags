//
//  ModelImageAndVideoAssets.m
//  LivingTags
//
//  Created by appsbeetech on 09/11/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "ModelImageAndVideoAssets.h"

@implementation ModelImageAndVideoAssets

-(id)initWithDictionary:(NSDictionary *)dict
{
    if ([super init])
    {
        //tkey
        if ([dict objectForKey:@"tkey"] && ![[dict objectForKey:@"tkey"] isKindOfClass:[NSNull class]])
        {
            self.strTkey=[dict objectForKey:@"tkey"];
        }
        else
        {
            self.strTkey=@"";
        }
        
        //asset_path
        if ([dict objectForKey:@"asset_path"] && ![[dict objectForKey:@"asset_path"] isKindOfClass:[NSNull class]])
        {
            self.strPicURI=[dict objectForKey:@"asset_path"];
            NSLog(@"%@",self.strPicURI);
        }
        else
        {
            self.strPicURI=@"";
        }
        
        //thumb_path
        if ([dict objectForKey:@"thumb_path"] && ![[dict objectForKey:@"thumb_path"] isKindOfClass:[NSNull class]])
        {
            self.strVideoThumb=[dict objectForKey:@"thumb_path"];
        }
        else
        {
            self.strVideoThumb=@"";
        }
        
        //takey
        if ([dict objectForKey:@"takey"] && ![[dict objectForKey:@"takey"] isKindOfClass:[NSNull class]])
        {
            self.strTAKey=[dict objectForKey:@"takey"];
        }
        else
        {
            self.strTAKey=@"";
        }


    }
    return [super init];
}

@end
