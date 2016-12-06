//
//  DeleteCommentService.h
//  LivingTags
//
//  Created by appsbeetech on 06/12/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "WebServiceBaseClass.h"

@interface DeleteCommentService : WebServiceBaseClass

+(id)service;

-(void)callDeleteServiceWithAKey:(NSString *)strAKey tcKey:(NSString *)strTCKey withCompletionHandler:(WebServiceCompletion)handler;

@end
