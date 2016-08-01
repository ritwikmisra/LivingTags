//
//  CreateTagsUploadProfilePicService.h
//  LivingTags
//
//  Created by appsbeetech on 01/08/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "WebServiceBaseClass.h"

@interface CreateTagsUploadProfilePicService : WebServiceBaseClass

+(id)service;

-(void)callCreateTagsUploadProfileServiceWithLivingTagsID:(NSString *)strLivingTagsID user_ID:(NSString *)strUserID image:(UIImage *)imgProfile withCompletionHandler:(WebServiceCompletion)completionHandler;

@end
