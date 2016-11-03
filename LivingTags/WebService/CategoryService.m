//
//  CategoryService.m
//  LivingTags
//
//  Created by appsbeetech on 03/11/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "CategoryService.h"

@implementation CategoryService

+(id)service
{
    static CategoryService *master=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        master=[[CategoryService alloc] initWithService:WEBSERVICE_CATEGORY];
    });
    return master;
}

-(void)callCategoryServiceWithCompletionHandler:(WebServiceCompletion)handler
{
    if (appDel.isRechable)
    {
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
        [request setURL:urlForService];
        NSLog(@"urlService=%@",urlForService.absoluteString);
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setValue:@"Basic YWRtaW46MTIzNDU2" forHTTPHeaderField:@"Authorization"];
        [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
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
                        @try
                        {
                            if ([[responseDict objectForKey:@"status"]boolValue])
                            {
                                handler([[responseDict objectForKey:@"response"] objectForKey:@"tagCategories"],NO,nil);
                            }
                            else
                            {
                                handler(nil,YES,[responseDict objectForKey:@"error"] );
                            }
                            
                        }
                        @catch (NSException *exception)
                        {
                            [[[UIAlertView alloc]initWithTitle:exception.reason message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
                        }
                        @finally
                        {
                            
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
