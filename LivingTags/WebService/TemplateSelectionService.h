//
//  TemplateSelectionService.h
//  LivingTags
//
//  Created by appsbeetech on 19/07/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "WebServiceBaseClass.h"

@interface TemplateSelectionService : WebServiceBaseClass

+(id)service;

-(void)callTemplateServiceWithUserID:(NSString *)strUserID templateID:(NSString *)strTemplateID withCompletionHandler:(WebServiceCompletion)handler;

@end
