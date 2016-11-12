//
//  WebServiceBaseClass.h
//  CARLiFESTYLEExchange
//
//  Created by appsbeetech on 29/01/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

#define SOMETHING_WRONG @"Something is wrong, please try again later!"
#define NO_NETWORK @"Please check the network connection"

typedef  void(^ _Nullable WebServiceCompletion)(_Nullable id result,BOOL isError, NSString * _Nullable strMsg);
typedef void(^ _Nullable UploadSessionBlock)( NSData * _Nullable data,BOOL isError, NSString * _Nullable strMsg);


typedef NS_ENUM(NSUInteger, WEB_SERVICES) {
    WEB_SERVICES_REGISTRATION,
    WEB_SERVICES_LOGIN,
    WEB_SERVICES_GET_PROFILE,
    WEB_SERVICES_UPDATE_PROFILE,
    WEB_SERVICES_FORGET_PASSWORD,
    WEB_SERVICES_LIVING_TAG_LISTING,
    WEB_SERVICE_SOCIAL_LOGIN,
    WEB_SERVICES_GET_ALL_TEMPLATES,
    WEB_SERVICES_READ_ALL_TAGS,
    WEB_SERVICES_TEMPLATE_SELECTION,
    WEB_SERVICES_LIVING_TAGS,
    WEB_SERVICES_LIVING_TAGS_SECOND_STEP,
    WEB_SERVICES_LIVING_TAGS_THIRD_STEP,
    WEB_SERVICES_CREATE_TEMPLATES_UPLOAD_PROFILE_PIC,
    WEB_SERVICES_CREATE_TEMPLATES_UPLOAD_COVER_PIC,
    WEB_SERVICES_CREATE_TAGS,
    WEB_SERVICE_UPDATE_TAGS,
    WEB_SERVICES_CREATE_TAGS_VIDEOS,
    CLOUDINARY_UPLOAD_IMAGE,
    CLOUDINARY_DELETE_IMAGE,
    WEB_SERVICE_PUBLISH_TAG,
    WEB_SERVICE_PREVIEW_TAG,
    WEBSERVICE_CATEGORY,
    WEB_SERVICE_MY_TAGS_BATCH_COUNT,
    WEB_SERVICE_TAG_LIST_CATEGORY,
    EDIT_TAGS_GET_DETAILS,
    WEBSERVICE_DASHBOARD_MY_TAGS
};

@interface WebServiceBaseClass : NSObject<NSURLSessionDataDelegate>
{
    @protected
    NSURL *urlForService;
    AppDelegate *appDel;
}

-(_Nullable id)initWithService:(WEB_SERVICES)service;

-(void)displayNetworkActivity;

-(void)hideNetworkActivity;

-(void)callWebServiceWithRequest:( NSMutableURLRequest* _Nullable)request Compeltion:(void(^ _Nullable )(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))handler;

-(void)callWebServiceUploadWithRequest:( NSMutableURLRequest* _Nullable)request Compeltion:(void(^ _Nullable )(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))handler;


@end
