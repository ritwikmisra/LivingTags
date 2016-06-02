//
//  LoginService.h
//  LivingTags
//
//  Created by appsbeetech on 28/04/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "WebServiceBaseClass.h"

@interface LoginService : WebServiceBaseClass

+(id)service;

-(void)callLoginServiceWithEmailID:(NSString *)strEmail Password:(NSString *)strPassword withCompletionHandler:(WebServiceCompletion)handler;

@end
