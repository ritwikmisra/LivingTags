//
//  MyTagsBatchCountService.m
//  LivingTags
//
//  Created by appsbeetech on 07/11/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "MyTagsBatchCountService.h"
#import "ModelMyTagsCount.h"

@implementation MyTagsBatchCountService

+(id)service
{
    static MyTagsBatchCountService *master=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        master=[[MyTagsBatchCountService alloc] initWithService:WEB_SERVICE_MY_TAGS_BATCH_COUNT];
    });
    return master;
}

-(void)getMyTagsBatchCountServiceWithCompletionHandler:(WebServiceCompletion)handler
{
    if (appDel.isRechable)
    {
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
        [request setURL:urlForService];
        NSLog(@"urlService=%@",urlForService.absoluteString);
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setValue:@"Basic YWRtaW46MTIzNDU2" forHTTPHeaderField:@"Authorization"];
        NSLog(@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"token"]);
        [request addValue:[[NSUserDefaults standardUserDefaults]objectForKey:@"token"] forHTTPHeaderField:@"token"];
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
                                NSMutableArray *arr=[[responseDict objectForKey:@"response"] objectForKey:@"category_lists"];
                                NSMutableArray *arrResponse=[[NSMutableArray alloc]initWithCapacity:arr.count];
                                for (int i=0; i<arr.count; i++)
                                {
                                    ModelMyTagsCount *obj=[[ModelMyTagsCount alloc]initWithDictionary:[arr objectAtIndex:i]];
                                    [arrResponse addObject:obj];
                                }
                                NSLog(@"%@",arrResponse);
                                handler(arrResponse,NO,nil);
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
