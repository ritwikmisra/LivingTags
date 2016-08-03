//
//  CreateTagsUploadCoverPicService.m
//  LivingTags
//
//  Created by appsbeetech on 01/08/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "CreateTagsUploadCoverPicService.h"

@implementation CreateTagsUploadCoverPicService

+(id)service
{
    static CreateTagsUploadCoverPicService *master=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        master=[[CreateTagsUploadCoverPicService alloc]initWithService:WEB_SERVICES_CREATE_TEMPLATES_UPLOAD_COVER_PIC];
    });
    return master;
}

-(void)callCreateTagsCoverPicUploadServiceWithLivingTagsID:(NSString *)strLivingTagsID user_ID:(NSString *)strUserID coverImage:(UIImage *)imgCover withCompletionHandler:(WebServiceCompletion)completionHandler
{
    if (appDel.isRechable)
    {
        NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:urlForService cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:180.0];
        
        [request setHTTPMethod:@"POST"];
        NSMutableData *body = [NSMutableData data];
        NSString *boundary = nil;//@"---------------------------14737800031466499882746641949";
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; charset=utf-8; boundary=%@", boundary];
        [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
        [request addValue:strUserID forHTTPHeaderField:@"id"];
        NSLog(@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"]);
        [request addValue:[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"] forHTTPHeaderField:@"token"];
        //@"account_id":strUserID
        NSDictionary *params1 = @{@"livingtag_id": strLivingTagsID};
        NSLog(@"postprams=%@",params1);
        [params1 enumerateKeysAndObjectsUsingBlock:^(NSString *parameterKey, NSString *parameterValue, BOOL *stop) {
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", parameterKey] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"%@\r\n", parameterValue] dataUsingEncoding:NSUTF8StringEncoding]];
        }];
        NSData *imgData;
        //The file to upload
        imgData=UIImageJPEGRepresentation(imgCover, 0.2);
        if (imgCover)
        {
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: attachment; name=\"cover_uri\"; filename=\"image.jpg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[@"Content-Type: image/jpg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[NSData dataWithData:imgData]];
            [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            //The file to upload
            [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        }
        [request setHTTPBody:body];
        //[self displayNetworkActivity];
        [self callWebServiceWithRequest:request Compeltion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
         {
             //[self hideNetworkActivity];
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
                             
                             completionHandler([responseDict objectForKey:@"response"],NO,nil);
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
