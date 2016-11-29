//
//  ModelCommentDetails.m
//  LivingTags
//
//  Created by appsbeetech on 29/11/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "ModelCommentDetails.h"

@implementation ModelCommentDetails

-(id)initWithDictionary:(NSDictionary *)dict
{
    if (self=[super init])
    {
        //akey
        if ([dict objectForKey:@"akey"] && ![[dict objectForKey:@"akey"] isKindOfClass:[NSNull class]])
        {
            self.strAKey=[dict objectForKey:@"akey"];
        }
        else
        {
            self.strAKey=@"";
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

        //tcfolder
        if ([dict objectForKey:@"tcfolder"] && ![[dict objectForKey:@"tcfolder"] isKindOfClass:[NSNull class]])
        {
            self.strTCFolder=[dict objectForKey:@"tcfolder"];
        }
        else
        {
            self.strTCFolder=@"";
        }

        //tkey
        if ([dict objectForKey:@"tkey"] && ![[dict objectForKey:@"tkey"] isKindOfClass:[NSNull class]])
        {
            self.strTKey=[dict objectForKey:@"tkey"];
        }
        else
        {
            self.strTKey=@"";
        }

        //tname
        if ([dict objectForKey:@"tname"] && ![[dict objectForKey:@"tname"] isKindOfClass:[NSNull class]])
        {
            self.strTName=[dict objectForKey:@"tname"];
        }
        else
        {
            self.strTName=@"";
        }

        //tlink
        if ([dict objectForKey:@"tlink"] && ![[dict objectForKey:@"tlink"] isKindOfClass:[NSNull class]])
        {
            self.strTLink=[dict objectForKey:@"tlink"];
        }
        else
        {
            self.strTLink=@"";
        }

        //commenter_name
        if ([dict objectForKey:@"commenter_name"] && ![[dict objectForKey:@"commenter_name"] isKindOfClass:[NSNull class]])
        {
            self.strTCommenterName=[dict objectForKey:@"commenter_name"];
        }
        else
        {
            self.strTCommenterName=@"";
        }

        //commenter_photo
        if ([dict objectForKey:@"commenter_photo"] && ![[dict objectForKey:@"commenter_photo"] isKindOfClass:[NSNull class]])
        {
            self.strTCommenterPhoto=[dict objectForKey:@"commenter_photo"];
            self.strTCommenterPhoto=[self.strTCommenterPhoto stringByReplacingOccurrencesOfString:@"https" withString:@"http"];
        }
        else
        {
            self.strTCommenterPhoto=@"";
        }

        //tphototype
        if ([dict objectForKey:@"tphototype"] && ![[dict objectForKey:@"tphototype"] isKindOfClass:[NSNull class]])
        {
            self.strTPhotoType=[dict objectForKey:@"tphototype"];
        }
        else
        {
            self.strTPhotoType=@"";
        }

        //commenter_link
        if ([dict objectForKey:@"commenter_link"] && ![[dict objectForKey:@"commenter_link"] isKindOfClass:[NSNull class]])
        {
            self.strTCommenterLink=[dict objectForKey:@"commenter_link"];
        }
        else
        {
            self.strTCommenterLink=@"";
        }

        //tccomment
        if ([dict objectForKey:@"tccomment"] && ![[dict objectForKey:@"tccomment"] isKindOfClass:[NSNull class]])
        {
            self.strTCommenter=[dict objectForKey:@"tccomment"];
        }
        else
        {
            self.strTCommenter=@"";
        }

        //tcpublished
        if ([dict objectForKey:@"tcpublished"] && ![[dict objectForKey:@"tcpublished"] isKindOfClass:[NSNull class]])
        {
            self.strTPublished=[dict objectForKey:@"tcpublished"];
        }
        else
        {
            self.strTPublished=@"";
        }

        //posted_time
        if ([dict objectForKey:@"posted_time"] && ![[dict objectForKey:@"posted_time"] isKindOfClass:[NSNull class]])
        {
            self.strTCommentTime=[dict objectForKey:@"posted_time"];
        }
        else
        {
            self.strTCommentTime=@"";
        }
        //comment_size
        if ([dict objectForKey:@"comment_size"] && ![[dict objectForKey:@"comment_size"] isKindOfClass:[NSNull class]])
        {
            self.strSize=[dict objectForKey:@"comment_size"];
        }
        else
        {
            self.strSize=@"";
        }

        //comment_asset
        if ([dict objectForKey:@"comment_asset"])
        {
            self.arrCommentAsset=[dict objectForKey:@"comment_asset"];
        }
    }
    return self;
}

@end
