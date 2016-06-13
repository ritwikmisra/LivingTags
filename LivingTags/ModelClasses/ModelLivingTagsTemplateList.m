//
//  ModelLivingTagsTemplateList.m
//  LivingTags
//
//  Created by appsbeetech on 10/06/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "ModelLivingTagsTemplateList.h"

@implementation ModelLivingTagsTemplateList

-(id)initWithDictionary:(NSDictionary *)dict
{
    self=[super init];
    if (self)
    {
        if ([dict objectForKey:@"id"] && ![[dict objectForKey:@"id"] isKindOfClass:[NSNull class]])
        {
            self.strTemplateID=[dict objectForKey:@"id"];
        }
        else
        {
            self.strTemplateID=@"";
        }
        if ([dict objectForKey:@"template_uri"] && ![[dict objectForKey:@"template_uri"] isKindOfClass:[NSNull class]])
        {
            self.strTemplateURI=[dict objectForKey:@"template_uri"];
        }
        else
        {
            self.strTemplateURI=@"";
        }
        if ([dict objectForKey:@"template_name"] && ![[dict objectForKey:@"template_name"] isKindOfClass:[NSNull class]])
        {
            self.strTemplateName=[dict objectForKey:@"template_name"];
        }
        else
        {
            self.strTemplateName=@"";
        }
        if ([dict objectForKey:@"template_uri_thumb"] && ![[dict objectForKey:@"template_uri_thumb"] isKindOfClass:[NSNull class]])
        {
            self.strTemplateThumb=[dict objectForKey:@"template_uri_thumb"];
        }
        else
        {
            self.strTemplateThumb=@"";
        }
    }
    return self;
}


@end
