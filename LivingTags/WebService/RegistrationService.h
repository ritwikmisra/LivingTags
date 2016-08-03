//
//  RegistrationService.h
//  LivingTags
//
//  Created by appsbeetech on 23/04/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "WebServiceBaseClass.h"

@interface RegistrationService : WebServiceBaseClass

+(id)service;

-(void)callRegistrationServiceWithSource:(NSString *)strSource Name:(NSString *)strName emailAddress:(NSString *)stremail password:(NSString *)strPassword withCompletionHandler:(WebServiceCompletion)handler;

@end
