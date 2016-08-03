//
//  socialLoginFirstService.m
//  LivingTags
//
//  Created by appsbeetech on 11/05/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "socialLoginFirstService.h"
#import "SocialLoginService.h"

@implementation socialLoginFirstService

+(id)service
{
    static socialLoginFirstService *master=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        master=[[socialLoginFirstService alloc]initWithService:WEB_SERVICE_SOCIAL_LOGIN_FIRST];
    });
    return master;
}

-(void)callSocialServiceFirstTymWithSocialAccountID:(NSString *)strSocialAccountID email:(NSString *)strEmail picture:(NSString *)strPicURL name:(NSString *)strName socialSite:(NSString *)strSocialSite socialEmailAvailable:(NSString *)strEmailAvailable withCompletionHandler:(WebServiceCompletion)Completionhandler
{
    if (appDel.isRechable)
    {
        NSMutableArray *arr=[[NSMutableArray alloc] init];
        [arr addObject:[NSString stringWithFormat:@"social_id=%@",strSocialAccountID]];
        NSString *postParams = [[arr componentsJoinedByString:@"&"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        //postParams=[postParams stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        NSLog(@"postParams = %@",postParams);
        NSError *errorConversion;
        //NSData *postData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&errorConversion];
        NSData *postData = [NSData dataWithBytes: [postParams UTF8String] length: [postParams length]];
        if (errorConversion)
        {
            Completionhandler(errorConversion,YES,@"Something is wrong, please try again later...");
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
                if (error)
                {
                    Completionhandler(error,YES,SOMETHING_WRONG);
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
                            Completionhandler(errorJsonConversion,YES,SOMETHING_WRONG);
                        }
                        else
                        {
                            if ([[responseDict objectForKey:@"status"]boolValue])
                            {
                                [self hideNetworkActivity];
                                NSString *strToken=[[responseDict objectForKey:@"response"] objectForKey:@"token"];
                                [[NSUserDefaults standardUserDefaults]setObject:strToken forKey:@"Token"];
                                [[NSUserDefaults standardUserDefaults] synchronize];
                                NSLog(@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"]);
                                appDel.objUser=[[ModelUser alloc]initWithDictionary:[[responseDict objectForKey:@"response"] objectForKey:@"account"]];
                                
                                NSLog(@"%@",appDel.objUser.strName);
                                Completionhandler([responseDict objectForKey:@"response"],NO,[[responseDict objectForKey:@"response"] objectForKey:@"message"]);
                            }
                            else
                            {
                                if ([[responseDict objectForKey:@"error_code"]integerValue]==1011)
                                {
                                    [[SocialLoginService service]callSocialServiceWithEmailID:strEmail id:strSocialAccountID name:strName pic:strPicURL social:strSocialSite socialEmail:strEmailAvailable deviceType:@"IPHONE" withCompletionHandler:^(id  _Nullable result, BOOL isError, NSString * _Nullable strMsg) {
                                        [self hideNetworkActivity];
                                        if (isError)
                                        {
                                            Completionhandler(nil,YES,strMsg);
                                        }
                                        else
                                        {
                                            Completionhandler(result,NO,nil);
                                        }
                                    }];
                                }
                                else
                                {
                                    [self hideNetworkActivity];
                                    Completionhandler(nil,YES,[responseDict objectForKey:@"error"] );
                                }
                            }
                        }
                    }
                    else
                    {
                        Completionhandler(nil,YES,SOMETHING_WRONG);
                    }
                }
            }];
        }
    }
    else
    {
        Completionhandler(nil,YES,NO_NETWORK);
    }
}
@end
