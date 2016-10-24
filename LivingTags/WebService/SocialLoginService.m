//
//  SocialLoginService.m
//  LivingTags
//
//  Created by appsbeetech on 11/05/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "SocialLoginService.h"
#import "SocialLoginService.h"

@implementation SocialLoginService

+(id)service
{
    static SocialLoginService *master=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        master=[[SocialLoginService alloc]initWithService:WEB_SERVICE_SOCIAL_LOGIN];
    });
    return master;
}

-(void)callSocialServiceWithEmailID:(NSString *)strEmail id:(NSString *)strID name:(NSString *)strName pic:(NSString *)strPic social:(NSString *)strSocial socialEmail:(NSString *)strSocialEmailAvailable deviceType:(NSString *)strDeviceType withCompletionHandler:(WebServiceCompletion)handler
{
    if (appDel.isRechable)
    {
        NSMutableArray *arr=[[NSMutableArray alloc] init];
        [arr addObject:[NSString stringWithFormat:@"pic_uri=%@",strPic]];
        [arr addObject:[NSString stringWithFormat:@"social=%@",strSocial]];
        [arr addObject:[NSString stringWithFormat:@"name=%@",strName]];
        [arr addObject:[NSString stringWithFormat:@"email=%@",strEmail]];
        [arr addObject:[NSString stringWithFormat:@"social_id=%@",strID]];
        [arr addObject:[NSString stringWithFormat:@"social_email=%@",strSocialEmailAvailable]];
        [arr addObject:[NSString stringWithFormat:@"rgistration_source=%@",strDeviceType]];

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
                                handler([responseDict objectForKey:@"response"],NO,[[responseDict objectForKey:@"response"] objectForKey:@"message"]);
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
