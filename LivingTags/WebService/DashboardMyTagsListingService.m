//
//  DashboardMyTagsListingService.m
//  LivingTags
//
//  Created by appsbeetech on 12/11/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "DashboardMyTagsListingService.h"
#import "ModelEditTagsListing.h"

@implementation DashboardMyTagsListingService
//WEBSERVICE_DASHBOARD_MY_TAGS

+(id)service
{
    static DashboardMyTagsListingService *master=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        master=[[DashboardMyTagsListingService alloc] initWithService:WEBSERVICE_DASHBOARD_MY_TAGS];
    });
    return master;
}

-(void)callDashboardMyTagsListServiceWithAkey:(NSString *)strAKey page:(int)page withCompletionHandler:(WebServiceCompletion)handler
{
    if (appDel.isRechable)
    {
        NSMutableArray *arr=[[NSMutableArray alloc] init];
        [arr addObject:[NSString stringWithFormat:@"akey=%@",strAKey]];
        [arr addObject:[NSString stringWithFormat:@"page=%d",page]];
        
        NSString *postParams = [[arr componentsJoinedByString:@"&"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        //postParams=[postParams stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        NSLog(@"postParams = %@",postParams);
        NSError *errorConversion;
        //NSData *postData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&errorConversion];
        NSData *postData = [NSData dataWithBytes: [postParams UTF8String] length: [postParams length]];
        if (errorConversion)
        {
            handler(errorConversion,YES,@"Something is wrong, please try again later...");
        }
        else
        {
            NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
            [request setURL:urlForService];
            NSLog(@"urlService=%@",urlForService.absoluteString);
            [request setHTTPMethod:@"POST"];
            [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
            [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            [request setValue:@"Basic YWRtaW46MTIzNDU2" forHTTPHeaderField:@"Authorization"];
            NSLog(@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"token"]);
            [request setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"token"] forHTTPHeaderField:@"token"];
            [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [request setTimeoutInterval:60.0];
            [request setHTTPBody:postData];
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
                                    NSLog(@"%@",[[responseDict objectForKey:@"response"] objectForKey:@"data"]);
                                    NSMutableArray *arrData=[[responseDict objectForKey:@"response"] objectForKey:@"data"];
                                    NSMutableArray *arrResponse=[[NSMutableArray alloc]initWithCapacity:arrData.count];
                                    for (int i=0; i<arrData.count; i++)
                                    {
                                        ModelEditTagsListing *obj=[[ModelEditTagsListing alloc]initWithDictionary:[arrData objectAtIndex:i]];
                                        [arrResponse addObject:obj];
                                    }
                                    NSLog(@"%@",arrResponse);
                                    handler(arrResponse,NO,nil );
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
    }
    else
    {
        handler(nil,YES,NO_NETWORK);
    }

}


@end
