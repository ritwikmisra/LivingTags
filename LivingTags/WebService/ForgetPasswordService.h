//
//  ForgetPasswordService.h
//  LivingTags
//
//  Created by appsbeetech on 04/05/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "WebServiceBaseClass.h"

@interface ForgetPasswordService : WebServiceBaseClass

+(id)service;

-(void)callForgetPasswordServiceWithEmailID:(NSString *)strEmailID withCompletionHandler:(WebServiceCompletion)handler;
@end
