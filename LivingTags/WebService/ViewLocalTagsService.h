//
//  ViewLocalTagsService.h
//  LivingTags
//
//  Created by appsbeetech on 23/11/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "WebServiceBaseClass.h"

@interface ViewLocalTagsService : WebServiceBaseClass

+(id)service;

-(void)getLocalLivingTagsWithAKey:(NSString *)strAKey page:(int)page withCompletionHandler:(WebServiceCompletion)handler;

@end
