//
//  ProductDetailsService.m
//  LivingTags
//
//  Created by appsbeetech on 18/11/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "ProductDetailsService.h"
#import "ModelProduct.h"

@implementation ProductDetailsService

//WEB_SERVICE_PRODUCT_DETAILS

+(id)service
{
    static ProductDetailsService *master=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        master=[[ProductDetailsService alloc] initWithService:WEB_SERVICE_PRODUCT_DETAILS];
    });
    return master;
}

-(void)callProductDetailsServiceWithProductKey:(NSString *)strPKey withCompletionHandler:(WebServiceCompletion)handler
{
    if (appDel.isRechable)
    {
        NSMutableArray *arr=[[NSMutableArray alloc] init];
        [arr addObject:[NSString stringWithFormat:@"pkey=%@",strPKey]];
        
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
                                    handler([[responseDict objectForKey:@"response"] objectForKey:@"data"],NO,nil );
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