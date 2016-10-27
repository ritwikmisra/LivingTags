//
//  CreateTagsPublishService.h
//  LivingTags
//
//  Created by appsbeetech on 01/08/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "WebServiceBaseClass.h"

@interface CreateTagsPublishService : WebServiceBaseClass

+(id)service;

-(void)callPublishServiceWithLivingTagsID:(NSString *)strUserID tcKey:(NSString *)strTCKey withCompletionHandler:(WebServiceCompletion)handler;

@end
