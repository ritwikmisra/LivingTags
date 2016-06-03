//
//  LoginService.m
//  LivingTags
//
//  Created by appsbeetech on 28/04/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "LoginService.h"
#import "ModelUser.h"

@implementation LoginService

+(id)service
{
    static LoginService *master=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        master=[[LoginService alloc]initWithService:WEB_SERVICES_LOGIN];
    });
    return master;
}

-(void)callLoginServiceWithEmailID:(NSString *)strEmail Password:(NSString *)strPassword withCompletionHandler:(WebServiceCompletion)handler
{
    if (appDel.isRechable)
    {
        NSMutableArray *arr=[[NSMutableArray alloc] init];
        [arr addObject:[NSString stringWithFormat:@"email=%@",strEmail]];
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
                            if ([[responseDict objectForKey:@"status"]boolValue])
                            {
                                NSString *strToken=[[responseDict objectForKey:@"response"] objectForKey:@"token"];
                                [[NSUserDefaults standardUserDefaults]setObject:strToken forKey:@"Token"];
                                [[NSUserDefaults standardUserDefaults] synchronize];
                                NSLog(@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"]);
                                appDel.objUser=[[ModelUser alloc]initWithDictionary:[[responseDict objectForKey:@"response"] objectForKey:@"account"]];
                                NSLog(@"%@",appDel.objUser.strName);
                                handler([responseDict objectForKey:@"response"],NO,nil);
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
    }
    else
    {
        handler(nil,YES,NO_NETWORK);
    }
}

@end
