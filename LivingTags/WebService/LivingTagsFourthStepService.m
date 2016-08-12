//
//  LivingTagsFourthStepService.m
//  LivingTags
//
//  Created by appsbeetech on 08/08/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "LivingTagsFourthStepService.h"

@implementation LivingTagsFourthStepService

+(id)service
{
    static LivingTagsFourthStepService *master=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        master=[[LivingTagsFourthStepService alloc]initWithService:WEB_SERVICES_CREATE_TAGS_VIDEOS];
    });
    return master;
}

-(void)callThirdStepServiceWithImage:(NSMutableDictionary *)dicDetails livingTagsID:(NSString *)strLivingTagsID userID:(NSString *)strUserID withCompletionHandler:(WebServiceCompletion)completionHandler
{
    NSLog(@"%@",dicDetails);
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
        NSLog(@"%lu",(unsigned long)[dicDetails count]);
        if ([dicDetails count]==2)
        {
            NSString *str=[dicDetails objectForKey:@"3"];
            NSDictionary *params2 = @{@"date_taken": str};
            NSLog(@"postprams=%@",params2);
            [params2 enumerateKeysAndObjectsUsingBlock:^(NSString *parameterKey, NSString *parameterValue, BOOL *stop) {
                [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", parameterKey] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[[NSString stringWithFormat:@"%@\r\n", parameterValue] dataUsingEncoding:NSUTF8StringEncoding]];
            }];
            //image upload
            //The file to upload
           NSData *imgData=[dicDetails objectForKey:@"1"];
            if (imgData.length>0)
            {
                [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[[NSString stringWithFormat:@"Content-Disposition: attachment; name=\"asset_uri\"; filename=\"image.jpg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[@"Content-Type: image/jpg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[NSData dataWithData:imgData]];
                [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                //The file to upload
                [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            }
        }
        else if ([dicDetails count]==3)
        {
            //title
            NSString *strDate=[dicDetails objectForKey:@"3"];
            NSDictionary *paramsDate = @{@"title": strDate};
            NSLog(@"postprams=%@",paramsDate);
            [paramsDate enumerateKeysAndObjectsUsingBlock:^(NSString *parameterKey, NSString *parameterValue, BOOL *stop) {
                [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", parameterKey] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[[NSString stringWithFormat:@"%@\r\n", parameterValue] dataUsingEncoding:NSUTF8StringEncoding]];
            }];
            
            //date taken
            NSString *str=[dicDetails objectForKey:@"3"];
            NSDictionary *params2 = @{@"date_taken": str};
            NSLog(@"postprams=%@",params2);
            [params2 enumerateKeysAndObjectsUsingBlock:^(NSString *parameterKey, NSString *parameterValue, BOOL *stop) {
                [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", parameterKey] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[[NSString stringWithFormat:@"%@\r\n", parameterValue] dataUsingEncoding:NSUTF8StringEncoding]];
            }];
            
            //image upload
            
            //The file to upload
            NSData *imgData=[dicDetails objectForKey:@"1"];
            if (imgData.length>0)
            {
                [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[[NSString stringWithFormat:@"Content-Disposition: attachment; name=\"asset_uri\"; filename=\"image.jpg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[@"Content-Type: image/jpg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[NSData dataWithData:imgData]];
                [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                //The file to upload
                [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            }
        }
        else
        {
            //title
            NSString *strDate=[dicDetails objectForKey:@"2"];
            NSDictionary *paramsDate = @{@"title": strDate};
            NSLog(@"postprams=%@",paramsDate);
            [paramsDate enumerateKeysAndObjectsUsingBlock:^(NSString *parameterKey, NSString *parameterValue, BOOL *stop) {
                [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", parameterKey] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[[NSString stringWithFormat:@"%@\r\n", parameterValue] dataUsingEncoding:NSUTF8StringEncoding]];
            }];
            
            //date taken
            NSString *str=[dicDetails objectForKey:@"3"];
            NSDictionary *params2 = @{@"date_taken": str};
            NSLog(@"postprams=%@",params2);
            [params2 enumerateKeysAndObjectsUsingBlock:^(NSString *parameterKey, NSString *parameterValue, BOOL *stop) {
                [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", parameterKey] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[[NSString stringWithFormat:@"%@\r\n", parameterValue] dataUsingEncoding:NSUTF8StringEncoding]];
            }];
            
            //image upload
            //The file to upload
            NSData *imgData=[dicDetails objectForKey:@"1"];
            if (imgData.length>0)
            {
                [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[[NSString stringWithFormat:@"Content-Disposition: attachment; name=\"asset_uri\"; filename=\"image.jpg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[@"Content-Type: image/jpg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[NSData dataWithData:imgData]];
                [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                //The file to upload
                [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            }
            //audio
            NSData *dataAudio=[dicDetails objectForKey:@"4"];
            //The file to upload
            if (dataAudio)
            {
                [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[[NSString stringWithFormat:@"Content-Disposition: attachment; name=\"audio\"; filename=\"image.jpg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[@"Content-Type: image/jpg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[NSData dataWithData:dataAudio]];
                [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                //The file to upload
                [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            }
        }
        [request setHTTPBody:body];
        // [self displayNetworkActivity];
        [self callWebServiceUploadWithRequest:request  Compeltion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
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

-(void)callPublishDataWithPublish:(NSString *)strPublish livingTagsID:(NSString *)strLivingTagsID userID:(NSString *)strUserID withCompletionHandler:(WebServiceCompletion)handler
{
    //http://192.168.0.1/LivingTags/www/api/Livingtags/updateLivingTag
    
    //https://chart.googleapis.com/chart?chs=200x200&cht=qr&chl=http://192.168.0.1/LivingTags/www/tags/dsadsd806&choe=UTF-8%22%20title=livingtags.com
    
   // https://chart.googleapis.com/chart?chs=200x200&cht=qr&chl=http://livingtags.digiopia.in/tags/asasdsad166&choe=UTF-8%22%20title=livingtags.com
    
    http://192.168.0.1/LivingTags/www/tags/WEB_URI
    if (appDel.isRechable)
    {
        //NSString *urlString =@"http://192.168.0.1/LivingTags/www/api/Livingtags/updateLivingTag";
       NSString *urlString =@"http://livingtags.digiopia.in/api/Livingtags/updateLivingTag";
        
        NSURL *url=[NSURL URLWithString:urlString];

        NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:180.0];
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
        //data[name]
        NSDictionary *params2 = @{@"data[published]": strPublish};
        NSLog(@"postprams=%@",params2);
        [params2 enumerateKeysAndObjectsUsingBlock:^(NSString *parameterKey, NSString *parameterValue, BOOL *stop) {
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", parameterKey] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"%@\r\n", parameterValue] dataUsingEncoding:NSUTF8StringEncoding]];
        }];
        [request setHTTPBody:body];
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
                            NSString *strWebURI=[[[[responseDict objectForKey:@"response"] objectForKey:@"livingtag"]objectForKey:@"livingtag"] objectForKey:@"web_uri"];
                            handler(strWebURI,NO,[[responseDict objectForKey:@"response"] objectForKey:@"message"]);
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
    else
    {
        handler(nil,YES,NO_NETWORK);
    }
}

@end
