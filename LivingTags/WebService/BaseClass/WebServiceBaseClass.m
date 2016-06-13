//
//  WebServiceBaseClass.m
//  CARLiFESTYLEExchange
//
//  Created by appsbeetech on 29/01/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "WebServiceBaseClass.h"
#import "NetworkActivityViewController.h"

//http://carlifestyle.digiopia.in/user/registration

//#define BASE_URL @"http://livingtags.digiopia.in/api/"
#define BASE_URL @"http://192.168.0.1/LivingTags/www/api/"

NSString *const strAPI[]={
    [WEB_SERVICES_REGISTRATION]         =          @"auths/signup",
    [WEB_SERVICES_LOGIN]                =          @"auths/signin",
    [WEB_SERVICES_GET_PROFILE]          =          @"Accounts/getAccount",
    [WEB_SERVICES_UPDATE_PROFILE]       =          @"Accounts/updateAccount",
    [WEB_SERVICES_FORGET_PASSWORD]      =          @"auths/forgotpass",
    [WEB_SERVICES_LIVING_TAG_LISTING]   =          @"Livingtags/myLivingtags",
    [WEB_SERVICE_SOCIAL_LOGIN_FIRST]    =          @"auths/social_signin",
    [WEB_SERVICE_SOCIAL_LOGIN]          =          @"auths/social_signup",
    [WEB_SERVICES_GET_ALL_TEMPLATES]    =          @"Livingtags/getAllTemplates"
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
@end
