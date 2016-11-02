//
//  LivingTagsSecondStepService.m
//  LivingTags
//
//  Created by appsbeetech on 20/07/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "LivingTagsSecondStepService.h"

@implementation LivingTagsSecondStepService

+(id)service
{
    static LivingTagsSecondStepService *master=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        master=[[LivingTagsSecondStepService alloc] initWithService:WEB_SERVICE_UPDATE_TAGS];
    });
    return master;
}

-(void)callSecondStepServiceWithDIctionary:(NSMutableDictionary *)dict tKey:(NSString *)strtKey withCompletionHandler:(WebServiceCompletion)completionHandler
{
    NSLog(@"%@,,,,%@",dict,strtKey);
    NSMutableDictionary *dictParams=[[NSMutableDictionary alloc]init];
    for (NSString *key in dict)
    {
        NSLog(@"%@",key);
        // {@"data[name]":strName,@"data[phone]":strPhoneNumber,@"data[address]":strAddress,@"data[lat]":strLatitude,@"data[video_uri]":strvideoURI,@"data[long]":strLongitude};

        [dictParams setObject:[dict objectForKey:key] forKey:[NSString stringWithFormat:@"tdata[%@]",key]];
    }
    NSLog(@"%@",dictParams);
    if (appDel.isRechable)
    {
        NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:urlForService cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:180.0];
        [request setHTTPMethod:@"POST"];
        NSMutableData *body = [NSMutableData data];
        NSString *boundary = nil;//@"---------------------------14737800031466499882746641949";
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; charset=utf-8; boundary=%@", boundary];
        [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
        NSLog(@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"]);
        [request addValue:[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"] forHTTPHeaderField:@"token"];
        [request setValue:@"Basic YWRtaW46MTIzNDU2" forHTTPHeaderField:@"Authorization"];
        NSLog(@"postprams=%@",dictParams);
        [dictParams enumerateKeysAndObjectsUsingBlock:^(NSString *parameterKey, NSString *parameterValue, BOOL *stop) {
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", parameterKey] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"%@\r\n", parameterValue] dataUsingEncoding:NSUTF8StringEncoding]];
        }];
        //@"account_id":strUserID
        NSDictionary *params1 = @{@"tkey": strtKey};
        NSLog(@"postprams=%@",params1);
        [params1 enumerateKeysAndObjectsUsingBlock:^(NSString *parameterKey, NSString *parameterValue, BOOL *stop) {
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", parameterKey] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"%@\r\n", parameterValue] dataUsingEncoding:NSUTF8StringEncoding]];
        }];
        [request setHTTPBody:body];
       // [self displayNetworkActivity];
        [self callWebServiceWithRequest:request Compeltion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
         {
            // [self hideNetworkActivity];
             if (error)
             {
                 completionHandler(error,YES,SOMETHING_WRONG);
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
                         completionHandler(errorJsonConversion,YES,SOMETHING_WRONG);
                     }
                     else
                     {
                         if ([[responseDict objectForKey:@"status"] boolValue])
                         {
                             if ([[responseDict objectForKey:@"response"] isKindOfClass:[NSDictionary class]])
                             {
                                 NSDictionary *dictUser=[responseDict objectForKey:@"response"];
                                 completionHandler(dictUser,NO,nil);
                             }
                         }
                         else
                         {
                             completionHandler(nil,YES,[responseDict objectForKey:@"error"] );
                         }
                     }
                 }
                 else
                 {
                     completionHandler(nil,YES,SOMETHING_WRONG);
                 }
             }
         }];
    }
    else
    {
        completionHandler(nil,YES,NO_NETWORK);
    }
}


-(void)callCloudinaryAudioServiceWithDIctionary:(NSMutableDictionary *)dict tKey:(NSString *)strtKey withCompletionHandler:(WebServiceCompletion)completionHandler
{
    NSLog(@"%@",dict);
    if (appDel.isRechable)
    {
        NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:urlForService cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:180.0];
        [request setHTTPMethod:@"POST"];
        NSMutableData *body = [NSMutableData data];
        NSString *boundary = nil;//@"---------------------------14737800031466499882746641949";
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; charset=utf-8; boundary=%@", boundary];
        [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
        NSLog(@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"]);
        [request addValue:[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"] forHTTPHeaderField:@"token"];
        [request setValue:@"Basic YWRtaW46MTIzNDU2" forHTTPHeaderField:@"Authorization"];
        NSLog(@"postprams=%@",dict);
        [dict enumerateKeysAndObjectsUsingBlock:^(NSString *parameterKey, NSString *parameterValue, BOOL *stop) {
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", parameterKey] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"%@\r\n", parameterValue] dataUsingEncoding:NSUTF8StringEncoding]];
        }];
        //@"account_id":strUserID
        NSDictionary *params1 = @{@"tkey": strtKey};
        NSLog(@"postprams=%@",params1);
        [params1 enumerateKeysAndObjectsUsingBlock:^(NSString *parameterKey, NSString *parameterValue, BOOL *stop) {
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", parameterKey] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"%@\r\n", parameterValue] dataUsingEncoding:NSUTF8StringEncoding]];
        }];
        [request setHTTPBody:body];
        // [self displayNetworkActivity];
        [self callWebServiceWithRequest:request Compeltion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
         {
              [self hideNetworkActivity];
             if (error)
             {
                 completionHandler(error,YES,SOMETHING_WRONG);
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
                         completionHandler(errorJsonConversion,YES,SOMETHING_WRONG);
                     }
                     else
                     {
                         if ([[responseDict objectForKey:@"status"] boolValue])
                         {
                             if ([[responseDict objectForKey:@"response"] isKindOfClass:[NSDictionary class]])
                             {
                                 NSDictionary *dictUser=[responseDict objectForKey:@"response"];
                                 completionHandler(dictUser,NO,nil);
                             }
                         }
                         else
                         {
                             completionHandler(nil,YES,[responseDict objectForKey:@"error"] );
                         }
                     }
                 }
                 else
                 {
                     completionHandler(nil,YES,SOMETHING_WRONG);
                 }
             }
         }];
    }
    else
    {
        completionHandler(nil,YES,NO_NETWORK);
    }

}


@end
