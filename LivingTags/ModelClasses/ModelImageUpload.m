//
//  ModelImageUpload.m
//  LivingTags
//
//  Created by appsbeetech on 17/08/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "ModelImageUpload.h"

@implementation ModelImageUpload

-(id)initWithDictionary:(NSDictionary *)dict
{
    if (self=[super init])
    {
        //asset_type
        if ([dict objectForKey:@"asset_type"] && ![[dict objectForKey:@"asset_type"] isKindOfClass:[NSNull class]])
        {
            self.strAssetType=[dict objectForKey:@"asset_type"];
            NSLog(@"%@",self.strAssetType);
        }
        else
        {
            self.strAssetType=@"";
        }
        //asset_uri
        if ([dict objectForKey:@"asset_uri"] && ![[dict objectForKey:@"asset_uri"] isKindOfClass:[NSNull class]])
        {
            self.strAssetURL=[dict objectForKey:@"asset_uri"];
            NSLog(@"%@",self.strAssetURL);
        }
        else
        {
            self.strAssetURL=@"";

        }
        //audio
        if ([dict objectForKey:@"audio"] && ![[dict objectForKey:@"audio"] isKindOfClass:[NSNull class]])
        {
            self.strAudio=[dict objectForKey:@"audio"];
            NSLog(@"%@",self.strAudio);
        }
        else
        {
            self.strAudio=@"";
        }
        //created
        if ([dict objectForKey:@"created"] && ![[dict objectForKey:@"created"] isKindOfClass:[NSNull class]])
        {
            self.strCreated=[dict objectForKey:@"created"];
            NSLog(@"%@",self.strCreated);
        }
        else
        {
            self.strCreated=@"";
        }
        //date_taken
        if ([dict objectForKey:@"date_taken"] && ![[dict objectForKey:@"date_taken"] isKindOfClass:[NSNull class]])
        {
            self.strDateTaken=[dict objectForKey:@"date_taken"];
            NSLog(@"%@",self.strDateTaken);
        }
        else
        {
            self.strDateTaken=@"";
        }
        //id
        if ([dict objectForKey:@"id"] && ![[dict objectForKey:@"id"] isKindOfClass:[NSNull class]])
        {
            self.strID=[dict objectForKey:@"id"];
            NSLog(@"%@",self.strID);
        }
        else
        {
            self.strID=@"";
        }
        //livingtag_id
        if ([dict objectForKey:@"livingtag_id"] && ![[dict objectForKey:@"livingtag_id"] isKindOfClass:[NSNull class]])
        {
            self.strLivingTagsID=[dict objectForKey:@"livingtag_id"];
            NSLog(@"%@",self.strLivingTagsID);
        }
        else
        {
            self.strLivingTagsID=@"";
        }
        //title
        if ([dict objectForKey:@"title"] && ![[dict objectForKey:@"title"] isKindOfClass:[NSNull class]])
        {
            self.strTitle=[dict objectForKey:@"title"];
            NSLog(@"%@",self.strTitle);
        }
        else
        {
            self.strTitle=@"";
        }
    }
    return self;
}

@end
