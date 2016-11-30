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

//#define BASE_URL @"http://developer.livingtags.com/api/"
#define BASE_URL @"http://staging.livingtags.com/api/"

//#define BASE_URL @"http://192.168.0.1/LivingTags/www/api/"
//http://developer.livingtags.com/api/Auths/signin

#define K_NOTIFICATION_CREATE_TAGS_IMAGES_UPLOAD @"IMAGE_UPLOAD_CREATE_TAGS"
#define K_NOTIFICATION_CREATE_TAGS_VIDEO_UPLOAD @"VIDEO_UPLOAD_CREATE_TAGS"
#define K_NOTIFICATION_CREATE_TAGS_ERROR @"ERROR"

//readtags

NSString *const strAPI[]={
    [WEB_SERVICES_REGISTRATION]                  =           @"auths/signup",
    [WEB_SERVICES_LOGIN]                                  =         @"Auths/signin",
    [WEB_SERVICES_GET_PROFILE]                     =          @"accounts/getAccount",
    [WEB_SERVICES_UPDATE_PROFILE]             =           @"",
    [WEB_SERVICES_FORGET_PASSWORD]        =          @"Auths/forgotpass",
    [WEB_SERVICES_LIVING_TAG_LISTING]      =            @"",
    [WEB_SERVICE_SOCIAL_LOGIN]                     =         @"Auths/socialSignup",
    [WEB_SERVICES_GET_ALL_TEMPLATES]     =            @"",
    [WEB_SERVICES_READ_ALL_TAGS]               =          @"",
    [WEB_SERVICES_TEMPLATE_SELECTION]   =            @"",
    [WEB_SERVICES_LIVING_TAGS_SECOND_STEP] =   @"",
    [WEB_SERVICES_LIVING_TAGS_THIRD_STEP]   =      @"",
    [WEB_SERVICES_CREATE_TEMPLATES_UPLOAD_PROFILE_PIC]=@"",
    [WEB_SERVICES_CREATE_TEMPLATES_UPLOAD_COVER_PIC]=@"i",
    [WEB_SERVICES_CREATE_TAGS]=@"Tags/createTag",
    [WEB_SERVICE_UPDATE_TAGS]   =@"Tags/updateTag",
    [CLOUDINARY_UPLOAD_IMAGE]=@"Tags/updateTagAsset",
    [CLOUDINARY_DELETE_IMAGE]=@"Tags/removeTagAsset",
    [WEB_SERVICE_PUBLISH_TAG]=@"Tags/publishTag",
    [WEB_SERVICE_PREVIEW_TAG]=@"Tags/previewTag",
    [WEBSERVICE_CATEGORY]   =@"Tags/getCategories",
    [WEB_SERVICE_MY_TAGS_BATCH_COUNT]=@"Tags/templateCategoryLists",
    [WEB_SERVICE_TAG_LIST_CATEGORY]=@"Tags/tagListsByCategory",
    [EDIT_TAGS_GET_DETAILS]=@"Tags/getTagDetails",
    [WEBSERVICE_DASHBOARD_MY_TAGS ]=@"Tags/tagLists",
    [WEB_SERVICE_PRODUCT_LISTING]=@"products/productLists",
    [WEB_SERVICE_PRODUCT_DETAILS]=@"products/productDetails",
    [WEB_SERVICE_DELETE_VOICE]=@"Tags/removeTagVoice",
    [WEB_SERVICE_VIEW_LOCAL_TAGS]=@"tags/getLocalTagLists",
    [WEB_SERVICE_COMMENT_LISTING]=@"tagcomments/getMyTagComments"
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
