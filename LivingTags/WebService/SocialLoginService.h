//
//  SocialLoginService.h
//  LivingTags
//
//  Created by appsbeetech on 11/05/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "WebServiceBaseClass.h"

@interface SocialLoginService : WebServiceBaseClass

+(id)service;

-(void)callSocialServiceWithEmailID:(NSString *)strEmail id:(NSString *)strID name:(NSString *)strName pic:(NSString *)strPic social:(NSString *)strSocial deviceType:(NSString *)strDeviceType withCompletionHandler:(WebServiceCompletion)handler;

@end
