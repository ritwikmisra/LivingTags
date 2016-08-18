//
//  WebServiceBaseClass.m
//  CARLiFESTYLEExchange
//
//  Created by appsbeetech on 29/01/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "WebServiceBaseClass.h"
#import "NetworkActivityViewController.h"
#import "CreateTagsThirdStepCell.h"

//http://carlifestyle.digiopia.in/user/registration

#define BASE_URL @"http://livingtags.digiopia.in/api/"
//#define BASE_URL @"http://192.168.0.1/LivingTags/www/api/"

#define K_NOTIFICATION_CREATE_TAGS_IMAGES_UPLOAD @"IMAGE_UPLOAD_CREATE_TAGS"
#define K_NOTIFICATION_CREATE_TAGS_VIDEO_UPLOAD @"VIDEO_UPLOAD_CREATE_TAGS"
#define K_NOTIFICATION_CREATE_TAGS_ERROR @"ERROR"

//readtags

NSString *const strAPI[]={
    [WEB_SERVICES_REGISTRATION]                  =          @"auths/signup",
    [WEB_SERVICES_LOGIN]                                  =          @"auths/signin",
    [WEB_SERVICES_GET_PROFILE]                     =          @"Accounts/getAccount",
    [WEB_SERVICES_UPDATE_PROFILE]             =          @"Accounts/updateAccount",
    [WEB_SERVICES_FORGET_PASSWORD]        =          @"auths/forgotpass",
    [WEB_SERVICES_LIVING_TAG_LISTING]      =          @"Livingtags/myLivingtags",
    [WEB_SERVICE_SOCIAL_LOGIN_FIRST]        =          @"auths/social_signin",
    [WEB_SERVICE_SOCIAL_LOGIN]                     =          @"auths/social_signup",
    [WEB_SERVICES_GET_ALL_TEMPLATES]     =          @"Livingtags/getAllTemplates",
    [WEB_SERVICES_READ_ALL_TAGS]               =          @"Livingtags/readtags",
    [WEB_SERVICES_TEMPLATE_SELECTION]   =           @"Livingtags/createLivingTag",
    [WEB_SERVICES_LIVING_TAGS_SECOND_STEP] =@"Livingtags/updateLivingTag",
    [WEB_SERVICES_LIVING_TAGS_THIRD_STEP]   =@"Livingtagassets/uploadPhoto",
    [WEB_SERVICES_CREATE_TEMPLATES_UPLOAD_PROFILE_PIC]=@"Livingtags/updatePhotoUri",
    [WEB_SERVICES_CREATE_TEMPLATES_UPLOAD_COVER_PIC]=@"Livingtags/updateCoverUri",
    [WEB_SERVICES_CREATE_TEMPLATES_PUBLISH]=@"Livingtags/publishTag",
    [WEB_SERVICES_CREATE_TAGS_VIDEOS]=@"Livingtagassets/uploadVideo"
};


@implementation WebServiceBaseClass

-(id)initWithService:(WEB_SERVICES)service
{
    if (self=[super init])
    {
        urlForService=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,strAPI[service]]];
        appDel=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    }
    return self;
}

-(void)displayNetworkActivity
{
    NetworkActivityViewController *netwokActivity=[NetworkActivityViewController sharedInstance];
    UIWindow *window=[[UIApplication sharedApplication] keyWindow];
    netwokActivity.view.frame=CGRectMake(0, 0, window.frame.size.width, window.frame.size.height);
    [window addSubview:netwokActivity.view];
    [netwokActivity changeAnimatingStatusTo:YES];
}

-(void)hideNetworkActivity
{
    NetworkActivityViewController *netwokActivity=[NetworkActivityViewController sharedInstance];
    [netwokActivity.view removeFromSuperview];
    [netwokActivity changeAnimatingStatusTo:NO];
}

-(void)callWebServiceWithRequest:( NSMutableURLRequest* _Nullable)request Compeltion:(void(^ _Nullable )(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))handler
{
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate:nil delegateQueue: [NSOperationQueue  mainQueue]];
    NSURLSessionDataTask *dataTask=[defaultSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        handler(data,response,error);
    }];
    [dataTask resume];
}

-(void)callWebServiceUploadWithRequest:( NSMutableURLRequest* _Nullable)request Compeltion:(void(^ _Nullable )(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))handler
{
    NSURLSessionConfiguration *backgroundConfiguration = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"com.com.livingTags"];
    NSURLSession *defaultSession =[NSURLSession sessionWithConfiguration:backgroundConfiguration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionUploadTask *dataTask=[defaultSession uploadTaskWithStreamedRequest:request];
    [dataTask resume];
    [self displayNetworkActivity];
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    [self hideNetworkActivity];
    NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    NSError *errorJsonConversion=nil;
    NSDictionary *response=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&errorJsonConversion];
    if (errorJsonConversion)
    {
        [[NSNotificationCenter defaultCenter]postNotificationName:K_NOTIFICATION_CREATE_TAGS_ERROR object:self];
    }
    else
    {
        NSLog(@"%@",response);
        if ([[response objectForKey:@"status"] boolValue])
        {
            NSDictionary *dictResponse=[response objectForKey:@"response"];
            NSLog(@"%d",dictResponse.count);
            if ([dictResponse isKindOfClass:[NSDictionary class] ] && dictResponse.count>0)
            {
                [[NSNotificationCenter defaultCenter]postNotificationName:K_NOTIFICATION_CREATE_TAGS_IMAGES_UPLOAD object:self userInfo:dictResponse];
            }
        }
        else
        {
            [[NSNotificationCenter defaultCenter]postNotificationName:K_NOTIFICATION_CREATE_TAGS_ERROR object:self];
        }
    }
    
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    if (error)
    {
        NSLog(@"%@ failed: %@", task.originalRequest.URL, error);
    }
}

-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didSendBodyData:(int64_t)bytesSent totalBytesSent:(int64_t)totalBytesSent totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend
{
    NSLog(@"Bytes sent%lld\n totalBytesSent %lld\nExpectedTosend %lld",bytesSent,totalBytesSent,totalBytesExpectedToSend);
    float progress=(float)totalBytesSent/(float)totalBytesExpectedToSend;
    NSLog(@"%f",progress);
}

@end
