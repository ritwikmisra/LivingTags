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

typedef NS_ENUM(NSUInteger, WEB_SERVICES) {
    WEB_SERVICES_REGISTRATION,
    WEB_SERVICES_LOGIN,
    WEB_SERVICES_GET_PROFILE,
    WEB_SERVICES_UPDATE_PROFILE,
    WEB_SERVICES_FORGET_PASSWORD,
    WEB_SERVICES_LIVING_TAG_LISTING,
    WEB_SERVICE_SOCIAL_LOGIN_FIRST,
    WEB_SERVICE_SOCIAL_LOGIN
};

@interface WebServiceBaseClass : NSObject
{
    @protected
    NSURL *urlForService;
    AppDelegate *appDel;
}

-(_Nullable id)initWithService:(WEB_SERVICES)service;

-(void)displayNetworkActivity;

-(void)hideNetworkActivity;

//-(void)storeUserDetails;


-(void)callWebServiceWithRequest:( NSMutableURLRequest* _Nullable)request Compeltion:(void(^ _Nullable )(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))handler;

@end
