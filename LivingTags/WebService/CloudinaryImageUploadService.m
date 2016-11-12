//
//  CloudinaryImageUploadService.m
//  LivingTags
//
//  Created by appsbeetech on 28/10/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "CloudinaryImageUploadService.h"

@implementation CloudinaryImageUploadService

+(id)service
{
    static CloudinaryImageUploadService *master=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        master=[[CloudinaryImageUploadService alloc] initWithService:CLOUDINARY_UPLOAD_IMAGE];
    });
    return master;
}


-(void)callCloudinaryImageUploadServiceWithBytes:(NSString *)strBytes created_date:(NSString *)strCreatedDate fileName:(NSString *)strFileName k_key:(NSString *)strt_key type:(NSString *)strType public_id:(NSString *)strPublicID withCompletionHandler:(WebServiceCompletion)completionHandler
{
    NSMutableDictionary *dictParams=[[NSMutableDictionary alloc]init];
    [dictParams setObject:strType forKey:@"tdata[tatype]"];
    [dictParams setObject:strBytes forKey:@"tdata[tasize]"];
    [dictParams setObject:strCreatedDate forKey:@"tdata[tadate]"];
    [dictParams setObject:strFileName forKey:@"tdata[tauri]"];


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
        //public_id
        NSDictionary *params1 = @{@"tkey": strt_key};
        NSLog(@"postprams=%@",params1);
        [params1 enumerateKeysAndObjectsUsingBlock:^(NSString *parameterKey, NSString *parameterValue, BOOL *stop) {
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", parameterKey] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"%@\r\n", parameterValue] dataUsingEncoding:NSUTF8StringEncoding]];
        }];
        
        NSDictionary *params2 = @{@"public_id": strPublicID};
        NSLog(@"postprams=%@",params2);
        [params2 enumerateKeysAndObjectsUsingBlock:^(NSString *parameterKey, NSString *parameterValue, BOOL *stop) {
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
                         @try
                        {
                            if ([[responseDict objectForKey:@"status"] boolValue])
                            {
                                if ([[responseDict objectForKey:@"response"] isKindOfClass:[NSDictionary class]])
                                {
                                    NSString *strTAKey=[[responseDict objectForKey:@"response"] objectForKey:@"takey"];
                                    completionHandler(strTAKey,NO,nil);
                                }
                            }
                            else
                            {
                                completionHandler(nil,YES,[responseDict objectForKey:@"error"] );
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
