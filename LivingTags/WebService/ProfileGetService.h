//
//  ProfileGetService.h
//  LivingTags
//
//  Created by appsbeetech on 02/05/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "WebServiceBaseClass.h"

@interface ProfileGetService : WebServiceBaseClass

+(id)service;

-(void)callProfileEditServiceWithUserID:(NSString *)strUserID withCompletionHandler:(WebServiceCompletion)handler;
@end
