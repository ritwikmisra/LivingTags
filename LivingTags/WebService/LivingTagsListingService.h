//
//  LivingTagsListingService.h
//  LivingTags
//
//  Created by appsbeetech on 17/05/16.
//  Copyright © 2016 appsbeetech. All rights reserved.


#import "WebServiceBaseClass.h"

@interface LivingTagsListingService : WebServiceBaseClass

+(id)service;

-(void)callListingServiceWithUserID:(NSString *)strUser paging:(int)i withCompletionHandler:(WebServiceCompletion)handler;

@end
