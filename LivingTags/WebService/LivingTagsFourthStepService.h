//
//  LivingTagsFourthStepService.h
//  LivingTags
//
//  Created by appsbeetech on 08/08/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "WebServiceBaseClass.h"

@interface LivingTagsFourthStepService : WebServiceBaseClass

+(id)service;

-(void)callThirdStepServiceWithImage:(NSMutableDictionary *)dicDetails livingTagsID:(NSString *)strLivingTagsID userID:(NSString *)strUserID withCompletionHandler:(WebServiceCompletion)completionHandler;

@end
