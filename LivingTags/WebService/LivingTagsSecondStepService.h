//
//  LivingTagsSecondStepService.h
//  LivingTags
//
//  Created by appsbeetech on 20/07/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "WebServiceBaseClass.h"

@interface LivingTagsSecondStepService : WebServiceBaseClass

+(id)service;

-(void)callSecondStepServiceWithDIctionary:(NSMutableDictionary *)dict UserID:(NSString *)strUserID livingTagsID:(NSString *)strLivingTagID withCompletionHandler:(WebServiceCompletion)completionHandler;

@end
