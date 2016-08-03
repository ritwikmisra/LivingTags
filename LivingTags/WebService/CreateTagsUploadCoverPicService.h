//
//  CreateTagsUploadCoverPicService.h
//  LivingTags
//
//  Created by appsbeetech on 01/08/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "WebServiceBaseClass.h"

@interface CreateTagsUploadCoverPicService : WebServiceBaseClass

+(id)service;

-(void)callCreateTagsCoverPicUploadServiceWithLivingTagsID:(NSString *)strLivingTagsID user_ID:(NSString *)strUserID coverImage:(UIImage *)imgCover withCompletionHandler:(WebServiceCompletion)completionHandler;
@end
