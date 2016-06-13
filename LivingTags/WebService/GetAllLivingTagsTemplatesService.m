//
//  GetAllLivingTagsTemplatesService.m
//  LivingTags
//
//  Created by appsbeetech on 10/06/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "GetAllLivingTagsTemplatesService.h"
#import "ModelLivingTagsTemplateList.h"

@implementation GetAllLivingTagsTemplatesService

+(id)sharedInstance
{
    static GetAllLivingTagsTemplatesService *master=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        master=[[GetAllLivingTagsTemplatesService alloc]initWithService:WEB_SERVICES_GET_ALL_TEMPLATES];
    });
    return master;
}

-(void)getAllTemplateDesignsWithCompletionHandler:(WebServiceCompletion)handler
{
    if (appDel.isRechable)
    {
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
        [request setURL:urlForService];
        NSLog(@"urlService=%@",urlForService.absoluteString);
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
        NSLog(@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"]);
        [request addValue:[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"] forHTTPHeaderField:@"token"];
        [request setTimeoutInterval:60.0];
        [self displayNetworkActivity];
        [self callWebServiceWithRequest:request Compeltion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            [self hideNetworkActivity];
            if (error)
            {
                handler(error,YES,SOMETHING_WRONG);
            }
            else
            {
                if (data.length>0)
                {
                    NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
                    NSError *errorJsonConversion=nil;
                    NSDictionary *responseDict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&errorJsonConversion];
                    if (errorJsonConversion)
                    {
                        handler(errorJsonConversion,YES,SOMETHING_WRONG);
                    }
                    else
                    {
                        if ([[responseDict objectForKey:@"status"]boolValue])
                        {
                            if ([[responseDict objectForKey:@"response"] isKindOfClass:[NSMutableArray class]])
                            {
                                NSMutableArray *arrResponse=[responseDict objectForKey:@"response"];
                                NSMutableArray *arr=[[NSMutableArray alloc]initWithCapacity:arrResponse.count];
                                for (int i=0; i<arrResponse.count; i++)
                                {
                                    ModelLivingTagsTemplateList *obj=[[ModelLivingTagsTemplateList alloc]initWithDictionary:[arrResponse objectAtIndex:i]];
                                    [arr addObject:obj];
                                }
                                NSLog(@"%@",arr);
                                handler(arr,NO,nil);
                            }
                        }
                        else
                        {
                            handler(nil,YES,[responseDict objectForKey:@"error"] );
                        }
                    }
                }
                else
                {
                    handler(nil,YES,SOMETHING_WRONG);
                }
            }
        }];
    }
    else
    {
        handler(nil,YES,NO_NETWORK);
    }
}

@end
