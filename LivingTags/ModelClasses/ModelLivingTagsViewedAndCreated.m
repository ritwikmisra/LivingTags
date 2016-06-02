//
//  ModelLivingTagsViewedAndCreated.m
//  LivingTags
//
//  Created by appsbeetech on 03/05/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "ModelLivingTagsViewedAndCreated.h"

@implementation ModelLivingTagsViewedAndCreated

-(id)initWithDictionary:(NSDictionary *)dict
{
    if (self=[super init])
    {
        if ([dict objectForKey:@"created"] && ![[dict objectForKey:@"created"] isKindOfClass:[NSNull class]])
        {
            NSInteger i=[[dict objectForKey:@"created"] integerValue];
            self.strCreated=[NSString stringWithFormat:@"%ld",(long)i];
        }
        else
        {
            self.strCreated=@"";
        }
        if ([dict objectForKey:@"viewed"] && ![[dict objectForKey:@"viewed"] isKindOfClass:[NSNull class]])
        {
            NSInteger i=[[dict objectForKey:@"viewed"] integerValue];
            self.strViewd=[NSString stringWithFormat:@"%ld",(long)i];
        }
        else
        {
            self.strViewd=@"";
        }
    }
    NSLog(@"%@ %@",self.strCreated,self.strViewd);
        return self;
}
@end
