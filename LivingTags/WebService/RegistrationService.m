//
//  RegistrationService.m
//  LivingTags
//
//  Created by appsbeetech on 23/04/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "RegistrationService.h"

@implementation RegistrationService

+(id)service
{
    static RegistrationService *service;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        service=[[RegistrationService alloc]initWithService:WEB_SERVICES_REGISTRATION];
    });
    return service;
}

-(void)callRegistrationServiceWithSource:(NSString *)strSource Name:(NSString *)strName emailAddress:(NSString *)stremail password:(NSString *)strPassword withCompletionHandler:(WebServiceCompletion)handler;
{
    if (appDel.isRechable)
    {
        NSMutableArray *arr=[[NSMutableArray alloc] init];
        [arr addObject:[NSString stringWithFormat:@"signup_source=%@",strSource]];
        [arr addObject:[NSString stringWithFormat:@"email=%@",stremail]];
        [arr addObject:[NSString stringWithFormat:@"name=%@",strName]];
        [arr addObject:[NSString stringWithFormat:@"password=%@",strPassword]];
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
            [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
            //Basic YWRtaW46MTIzNDU2
            
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
                                    handler([responseDict objectForKey:@"response"],NO,[responseDict objectForKey:@"response"] );
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
