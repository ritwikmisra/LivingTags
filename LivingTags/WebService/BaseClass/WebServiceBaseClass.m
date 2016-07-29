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

//#define BASE_URL @"http://livingtags.digiopia.in/api/"
#define BASE_URL @"http://192.168.0.1/LivingTags/www/api/"

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
    [WEB_SERVICES_LIVING_TAGS_THIRD_STEP]   =@"Livingtagassets/uploadPhoto"
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
}


- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSLog(@"%@",response);
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
    CreateTagsThirdStepCell *master=[[CreateTagsThirdStepCell alloc]init];
    //uploadSliderWithNumber
    [master performSelector:@selector(uploadSliderWithNumber:) withObject:[NSNumber numberWithFloat:progress]];
}

@end
