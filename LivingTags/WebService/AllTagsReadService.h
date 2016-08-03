//
//  AllTagsReadService.h
//  LivingTags
//
//  Created by appsbeetech on 04/07/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "WebServiceBaseClass.h"

@interface AllTagsReadService : WebServiceBaseClass

+(id)service;

-(void)callListingServiceWithUserID:(NSString *)strUser paging:(int)i name:(NSString *)strName withCompletionHandler:(WebServiceCompletion)handler;


@end
