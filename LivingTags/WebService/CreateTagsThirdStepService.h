//
//  CreateTagsThirdStepService.h
//  LivingTags
//
//  Created by appsbeetech on 28/07/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "WebServiceBaseClass.h"

@interface CreateTagsThirdStepService : WebServiceBaseClass

+(id)service;

-(void)callThirdStepServiceWithImage:(UIImage *)imgThirdStep livingTagsID:(NSString *)strLivingTagsID userID:(NSString *)strUserID withCompletionHandler:(WebServiceCompletion)completionHandler;


@end
